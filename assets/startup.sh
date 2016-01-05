#!/bin/bash
set -e
set -x

TOMCAT_ADMIN_USER=${TOMCAT_ADMIN_USER:-admin}
TOMCAT_ADMIN_PASSWORD=${TOMCAT_ADMIN_PASSWORD:-admin}



sed 's,{{TOMCAT_ADMIN_USER}},'"${TOMCAT_ADMIN_USER}"',g' -i /opt/tomcat/conf/tomcat-users.xml
sed 's,{{TOMCAT_ADMIN_PASSWORD}},'"${TOMCAT_ADMIN_PASSWORD}"',g' -i /opt/tomcat/conf/tomcat-users.xml



if [ ! -f /opt/tomcat/webapps/isFile ]; then
    touch /opt/tomcat/webapps/isFile
    mv /opt/tomcat/host-manager.bak /opt/tomcat/webapps/host-manager
    mv /opt/tomcat/manager.bak /opt/tomcat/webapps/manager
    mv /opt/tomcat/ROOT.bak /opt/tomcat/webapps/ROOT
fi



exec supervisord -c /etc/supervisor/supervisord.conf
