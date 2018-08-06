#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = "keanlee"


## ansi colors for formatting heredoc
RED = '\033[31m'       
GREEN = '\033[32m'     
YELLOW = '\033[33m'    
BLUE = '\033[34m'      
FUCHSIA = '\033[35m'   # 紫红色
CYAN = '\033[36m'      # 青蓝色
WHITE = '\033[37m'     
NO_COLOR = '\033[0m'


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
