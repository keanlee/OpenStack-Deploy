#!/usr/bin/python 

import sys
import logging
import commands

import json
import socket

def print_ssd_dev_list():
        status, outbuf = commands.getstatusoutput("sudo nvme list |grep dev|awk -F\" \" '{print $1}'")
        devlist = outbuf.split('\n')
        devstr = {}
        devstr1 = []
         
        for dev in devlist:
                devstr2 = {}
                devstr2["{#DEVICENAME}"] = dev
                devstr1.append(devstr2)

        devstr["data"] = devstr1
        print json.dumps(devstr)


def print_ssd_dev_lifetime(dev_name):
        cmd = "sudo nvme smart-log " + dev_name  +"|grep percentage_used|awk -F\":\" '{print $2}'|awk -F\"%\" '{print $1}'"
        status, outbuf = commands.getstatusoutput(cmd)
        #devlist = outbuf.split('\n')
        print 100 - int(outbuf)



def main(argv):

	cmd = "null"

	for arg in argv:
		if (arg == "status" ):
			cmd = "status"
			break
		elif( arg == "osd_pool_stats" ):
			cmd = "osd_pool_stats"
			break
		elif( arg == "osd_tree" ):
			cmd = "osd_tree"
			break
		elif( arg == "osd_df" ):
			cmd = "osd_df"
			break
		elif( arg == "pg_stat" ):
			cmd = "pg_stat"
			break
		elif( arg == "osd_perf" ):
			cmd = "osd_perf"
			break
		elif( arg == "df" ):
			cmd = "df"
			break
		elif( arg == "rbd_du" ):
			cmd = "rbd_du"
			break
		elif( arg == "log" ):
			cmd = "log"
			break
		elif( arg == "warn" ):
			cmd = "warn"
			break
		elif( arg == "ssd_dev_list_cmd" ):
                        print_ssd_dev_list()
                        return 0
                elif( arg == "ssd_dev_lifetime_cmd" ):
                        print_ssd_dev_lifetime(argv[2])
                        return 0


	

	logging.basicConfig(level=logging.DEBUG,
                format='%(asctime)s %(message)s',
                datefmt='%a, %d %b %Y %H:%M:%S',
                filename='/var/log/ceph-agent.log',
                filemode='w')
	


	s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)

	s.connect("/tmp/ceph-monitor-agent-socket")

	s.send(cmd)

	data = s.recv(524288)

	s.close()


	print data
	
	
	logging.info(data)

if __name__ == '__main__':
	main(sys.argv)

