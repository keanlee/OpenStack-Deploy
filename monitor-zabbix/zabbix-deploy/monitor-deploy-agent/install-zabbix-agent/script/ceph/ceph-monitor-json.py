#!/usr/bin/python

import sys
import os

import socket
import threading
import time
import datetime
import signal
import pwd


import commands

import json


import rados

from ceph_argparse import \
	concise_sig, descsort, parse_json_funcsigs, \
	matchnum, validate_command, find_cmd_target, \
	send_command, json_command, run_in_thread


socket_path = "/tmp/ceph-monitor-agent-socket"

cluster_log_list = []
rbd_du_out = "sssss"
warn = 0


def quit(signum, frame):
    print 'You choose to stop me.'
    sys.exit()

def find_warn(str=''):
	global warn
	if ( str.find("WARN") >= 0 ):
		warn = 1
	elif ( str.find("ERR") >= 0 ):
		warn = 2
	elif ( str.find("down") >= 0 ):
		warn = 3
	elif ( str.find("DOWN") >= 0 ):
		warn = 3
	elif ( str.find("HEALTH_OK") >= 0):
		warn = 0


def main(argv):
	global warn


	mutex = threading.Lock()

        try:
                cluster = rados.Rados(conffile='')
        except TypeError as e:
                print 'Argument validation error: ', e
                raise e

        print "Created cluster handle."

        try:
                cluster.connect()
        except Exception as e:
                print "connection error: ", e
                raise e
        finally:
                print "Connected to the cluster."






        s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        try:
                os.remove( socket_path )

        except :
		pass

        #s.bind( socket_path )
	try:
        	s.bind( socket_path )
	except :
		#os._exit(0)
		pass


	#uid = pwd.getpwnam("zabbix")
	uid = pwd.getpwnam(argv[1])
	os.chown(socket_path, uid.pw_uid, uid.pw_gid)

        s.listen(1)

	def ceph_rbd_du():
		global rbd_du_out
		
		while 1:
			starttime = datetime.datetime.now()
                	outbuf = ""
			target = ('mon', '')
			timeout=0
			verbose=False
			inbuf=''
			cmddict = {}
			cmddict.update({'prefix': u'osd lspools', 'format': 'json'})
			ret, outbuf, outs = send_command(cluster, target, [json.dumps(cmddict)],inbuf, timeout, verbose)
			lspools = json.loads(outbuf)
			poollist = []
			for item in lspools:
				d = {}
				#print item["poolname"]
				cmdstr = "rbd -p "+ item["poolname"] + " du"
				#print cmdstr
				images = []
				status, outbuf = commands.getstatusoutput(cmdstr)
				outarray = outbuf.split('\n')
				del outarray[0]
				del outarray[len(outarray)-1]
				for index,value in enumerate(outarray):
					a = value.split(' ')
					tmparray = []
					for index,tmpstr in enumerate(a):
						if ( len(tmpstr) >= 1 ):
							tmparray.append(tmpstr)
					image = {}
					image["used"] = tmparray[2]
					image["provisioned"] = tmparray[1]
					image["name"] = tmparray[0]
					images.append(image)

				d["images"] = images
				d["poolname"] = item["poolname"]
				poollist.append(d)
			mutex.acquire()
			rbd_du_out = json.dumps(poollist)
			mutex.release()
			#print rbd_du_out
			endtime = datetime.datetime.now()
			#print (endtime - starttime).seconds
			if ( (endtime - starttime).seconds < 300 ):
				time.sleep( 300 - (endtime - starttime).seconds )

	t = threading.Thread(target=ceph_rbd_du)
    	t.setDaemon(True)
	t.start()

	
	def watch_cb(arg, line, who, stamp_sec, stamp_nsec, seq, level, msg):
		#print(line)
		#sys.stdout.flush()
		find_warn(line)
		mutex.acquire()
		cluster_log_list.insert(0,line)
		mutex.release()


	# this instance keeps the watch connection alive, but is
	# otherwise unused
	level = "info"
	run_in_thread(cluster.monitor_log, level, watch_cb, 0)

        warn = "0"
        while 1:

                conn, addr = s.accept()

                cmd = conn.recv(1024)

                if not cmd: break

                print cmd

                outbuf = ""
		target = ('mon', '')
		timeout=0
		verbose=False
		inbuf=''
		cmddict = {}

                if ( cmd == "rbd_du" ):
			print rbd_du_out
			mutex.acquire()
			conn.send(rbd_du_out)
			mutex.release()
                	conn.close()
			continue
			
                elif ( cmd == "log" ):
			outbuf = ''

			mutex.acquire()
			for log_str in cluster_log_list:
				outbuf += log_str + "\n"
			del cluster_log_list[:]
			mutex.release()

			conn.send(outbuf)
                	conn.close()
			continue

                elif ( cmd == "warn" ):
                        conn.send( str(warn) )
                	conn.close()
			continue


                elif ( cmd == "status" ): 
			cmddict.update({'prefix': u'status', 'format': 'json'})
                elif( cmd == "osd_pool_stats" ):
			cmddict.update({'prefix': u'osd pool stats', 'format': 'json'})
                elif ( cmd == "osd_tree" ):
			cmddict.update({'prefix': u'osd tree', 'format': 'json'})
                elif ( cmd == "osd_df" ):
			cmddict.update({'prefix': u'osd df', 'format': 'json'})
                elif (cmd == "pg_stat" ):
			cmddict.update({'prefix': u'pg stat', 'format': 'json'})
                elif (cmd == "osd_perf" ):
			cmddict.update({'prefix': u'osd perf', 'format': 'json'})
                elif (cmd == "df" ):
			cmddict.update({'prefix': u'df', 'format': 'json'})
			

		ret, outbuf, outs = send_command(cluster, target, [json.dumps(cmddict)],inbuf, timeout, verbose)
		find_warn(outbuf)
		conn.send(outbuf)
                conn.close()












if __name__ == '__main__':
	try:
        	#signal.signal(signal.SIGINT, quit)
        	#signal.signal(signal.SIGTERM, quit)
        	main(sys.argv)
	except Exception, exc:
        	print exc

