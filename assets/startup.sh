#!/bin/bash
set -e
set -x

TOMCAT_ADMIN_USER=${TOMCAT_ADMIN_USER:-admin}
TOMCAT_ADMIN_PASSWORD=${TOMCAT_ADMIN_PASSWORD:-admin}
TOMCAT_XMX=${XMX:-Xmx128m}
TOMCAT_XMS=${XMS:-Xms64m}
TOMCAT_XMN=${XMN:-Xmn32m}




sed 's,{{TOMCAT_ADMIN_USER}},'"${TOMCAT_ADMIN_USER}"',g' -i /opt/tomcat/conf/tomcat-users.xml
sed 's,{{TOMCAT_ADMIN_PASSWORD}},'"${TOMCAT_ADMIN_PASSWORD}"',g' -i /opt/tomcat/conf/tomcat-users.xml



if [ ! -f /opt/tomcat/webapps/isFile ]; then
    touch /opt/tomcat/webapps/isFile
    mv /opt/tomcat/host-manager.bak /opt/tomcat/webapps/host-manager
    mv /opt/tomcat/manager.bak /opt/tomcat/webapps/manager
    mv /opt/tomcat/ROOT.bak /opt/tomcat/webapps/ROOT
fi

if [ echo /opt/tomcat/bin/catalina.sh | grep "{{JAVA_OPTS}}"  ];then
  TOMCAT_JAVA_OPTS= 'JAVA_OPTS="\"\$JAVA_OPTS\:-Xmx128m -Xms64m -Xmn32m\""'
  sed 's,'\#\ {{JAVA_OPTS}}','"${TOMCAT_JAVA_OPTS}"',g' -i /opt/tomcat/bin/catalina.sh
fi

exec supervisord -c /etc/supervisor/supervisord.conf
