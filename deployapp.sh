#!/bin/bash

/u01/Oracle/Middleware/Oracle_Home/oracle_common/common/bin/wlst.sh manageApplication.py -u ${WLS_UID} -p ${WLS_PWD} -a 10.0.0.8:7001 -n mytestapplication -f "/u01/devops/opdemo.war" -t MS1