#!/bin/bash
set -e
set -x

TOMCAT_ADMIN_USER=${TOMCAT_ADMIN_USER:-admin}
TOMCAT_ADMIN_PASSWORD=${TOMCAT_ADMIN_PASSWORD:-admin}
TOMCAT_XMX=${XMX:-128m}
TOMCAT_XMS=${XMS:-64m}
TOMCAT_XMN=${XMN:-32m}
TOMCAT_XSS=${XSS:-16m}




sed 's,{{TOMCAT_ADMIN_USER}},'"${TOMCAT_ADMIN_USER}"',g' -i /opt/tomcat/conf/tomcat-users.xml
sed 's,{{TOMCAT_ADMIN_PASSWORD}},'"${TOMCAT_ADMIN_PASSWORD}"',g' -i /opt/tomcat/conf/tomcat-users.xml



if [ ! -f /opt/tomcat/webapps/isFile ]; then
    touch /opt/tomcat/webapps/isFile
    mv /opt/tomcat/host-manager.bak /opt/tomcat/webapps/host-manager
    mv /opt/tomcat/manager.bak /opt/tomcat/webapps/manager
    mv /opt/tomcat/ROOT.bak /opt/tomcat/webapps/ROOT
fi

isExist=`cat /opt/tomcat/bin/catalina.sh|grep "{{JAVA_OPTS}}"`
if [ -n "$isExist" ];then
  sed 's,'{{TOMCAT_XMX}}','"${TOMCAT_XMX}"',g' -i /opt/tomcat/bin/catalina.sh
  sed 's,'{{TOMCAT_XMS}}','"${TOMCAT_XMS}"',g' -i /opt/tomcat/bin/catalina.sh
  sed 's,'{{TOMCAT_XMN}}','"${TOMCAT_XMN}"',g' -i /opt/tomcat/bin/catalina.sh
  sed 's,'{{TOMCAT_XSS}}','"${TOMCAT_XSS}"',g' -i /opt/tomcat/bin/catalina.sh
  sed 's,'\#\ {{JAVA_OPTS}}',' ',g' -i /opt/tomcat/bin/catalina.sh
fi

exec supervisord -c /etc/supervisor/supervisord.conf
