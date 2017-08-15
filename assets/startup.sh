#!/bin/bash
set -e
set -x

TOMCAT_ADMIN_USER=${TOMCAT_ADMIN_USER:-admin}
TOMCAT_ADMIN_PASSWORD=${TOMCAT_ADMIN_PASSWORD:-admin}
TOMCAT_XMX=${XMX:-1024m}
TOMCAT_XMS=${XMS:-128m}
TOMCAT_PERM_SIZE=${PERM_SIZE:-64m}
TOMCAT_MAX_PERM_SIZE=${MAX_PERM_SIZE:-256m}
LOG_GC_FILE=${LOG_GC_FILE:-/opt/tomcat/logs/gc.log}



sed 's,{{TOMCAT_ADMIN_USER}},'"${TOMCAT_ADMIN_USER}"',g' -i /opt/tomcat/conf/tomcat-users.xml
sed 's,{{TOMCAT_ADMIN_PASSWORD}},'"${TOMCAT_ADMIN_PASSWORD}"',g' -i /opt/tomcat/conf/tomcat-users.xml



if [ ! -f /opt/tomcat/webapps/isFile ]; then
    touch /opt/tomcat/webapps/isFile
    mv /opt/tomcat/host-manager.bak /opt/tomcat/webapps/host-manager
    mv /opt/tomcat/manager.bak /opt/tomcat/webapps/manager
    mv /opt/tomcat/ROOT.bak /opt/tomcat/webapps/ROOT
fi

if [ ! -f /opt/tomcat/bin/isFile ];then
  sed 's,'{{TOMCAT_XMX}}','"${TOMCAT_XMX}"',g' -i /opt/tomcat/bin/setenv.sh
  sed 's,'{{TOMCAT_XMS}}','"${TOMCAT_XMS}"',g' -i /opt/tomcat/bin/setenv.sh
  sed 's,'{{TOMCAT_PERM_SIZE}}','"${TOMCAT_PERM_SIZE}"',g' -i /opt/tomcat/bin/setenv.sh
  sed 's,'{{TOMCAT_MAX_PERM_SIZE}}','"${TOMCAT_MAX_PERM_SIZE}"',g' -i /opt/tomcat/bin/setenv.sh
  sed 's,'{{LOG_GC_FILE}}','"${LOG_GC_FILE}"',g' -i /opt/tomcat/bin/setenv.sh
  touch /opt/tomcat/bin/isFile
fi

exec supervisord -c /etc/supervisor/supervisord.conf
