#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = "keanlee"

import sys,os
import pymysql
import logging 
import datetime
import time 

## ansi colors for formatting heredoc
RED = '\033[31m'       
GREEN = '\033[32m'     
YELLOW = '\033[33m'    
BLUE = '\033[34m'      
FUCHSIA = '\033[35m'   # 紫红色
CYAN = '\033[36m'      # 青蓝色
WHITE = '\033[37m'     
NO_COLOR = '\033[0m'


#Define Log Writing Function
def logwrite(logcontents,loglevel = "error"):
    """
    Get the error message and store in the log file 

    """
    logpath='/var/log/k8s-manager/'
    global hostname
    hostname = os.uname()[1]
         
    if not os.path.isdir(logpath):
        os.makedirs(logpath)

    logdata=datetime.datetime.now()
    logtime=logdata.strftime('%Y-%m-%d %H:%M:%S')
    daylogfile=logpath+'/'+'k8s-manager' + '.log'

    logging.basicConfig(filename = daylogfile,level = logging.DEBUG)
    if str(loglevel) == "info":
        logging.info(" " + str(logtime) + "  " + hostname + "  " + os.path.basename(sys.argv[0]).split(".")[0] \
             + ": " + str(logcontents))
    elif str(loglevel) == "warning":
        logging.warning(" " + str(logtime) + "  " + hostname + "  " + os.path.basename(sys.argv[0]).split(".")[0] \
             + ": " + str(logcontents))
    elif str(loglevel) == "notice":
        logging.notice(" " + str(logtime) + "  " + hostname + "  " + os.path.basename(sys.argv[0]).split(".")[0] \
             + ": " + str(logcontents))
    else:
        logging.error(" " + str(logtime)  + "  " + hostname + "  " + os.path.basename(sys.argv[0]).split(".")[0] \
             + ": " + str(logcontents))
        

def db_manage(sqlcommand):
    
    db = pymysql.connect("localhost","root","admin","db_ai")
    
    cursor = db.cursor()
    #if str(action) == "insert": 
    #    sql_command = "INSERT INTO project SET project_id = " + project_id +", project_name = '自动测wesowds试项目', description = '这个是个测试的项目',create_date = NOW();"
    #else str(action) == "delete":
    #    sql_command = "DELETE FROM EMPLOYEE WHERE AGE > '%d'" % (20)
    sql_command = sqlcommand
    
    try:
        cursor.execute(sql_command)
        db.commit()
        if __name__ == "__main__":
            
            print(RED + "The sql command is: ", end = "")
            print(sql_command)
 
            print(GREEN + "Excute sql command to db successed" + NO_COLOR)
        logwirte("Excute sql command: " + sqlcommand + "  successed","info")
    except:
        db.rollback()

        if __name__ == "__main__":
            print(RED + "Insert data to db failed" + NO_COLOR)
        logwrite("Excute sql command: " + sqlcommand + "  failed") 
    db.close
if __name__ == "__main__":
    #how to call the db function
    #sql = "INSERT INTO job SET project_id = " + "'" + projectName + "'" +",       job_id = " + "'" + jobId + "'" + ",create_date = NOW();"
        ##job_status =  need update later
        #Job_status = 'running'
        #db_manage(sql)
