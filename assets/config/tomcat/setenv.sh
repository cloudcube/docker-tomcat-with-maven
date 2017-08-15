#!/bin/bash
# export JAVA_OPTS="-Dfile.encoding=UTF-8 -Xmx{{TOMCAT_XMX}} -Xms{{TOMCAT_XMS}} -Xmn{{TOMCAT_XMN}} -Xss{{TOMCAT_XSS}}"
export JAVA_OPTS="-Dfile.encoding=UTF-8 -Xmx{{TOMCAT_XMX}} -Xms{{TOMCAT_XMS}} -XX:PermSize={{TOMCAT_PERM_SIZE}} -XX:MaxPermSize={{TOMCAT_MAX_PERM_SIZE}} -Djava.awt.headless=true -Djava.library.path=/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64 -verbose:gc -XX:+PrintGC -XX:+PrintGCDetails -XX:+PrintHeapAtGC -Xloggc:{{LOG_GC_FILE}}"
