Docker Tomcat with Maven

## 说明
tomcat with maven的dockerfile文件


## 使用

### Dockerfile 使用
```
FROM cloudcube/tomcat-with-maven

```
### 启动参数设置
```
docker run \
	--name demo001 \
	-d -p 18080:8080 \
	-e XMX 512m \
	-e XMS 256m \
	-e PERM_SIZE 128m \
	-e MAX_PERM_SIZE 512m \
	cloudcube/tomcat-with-maven
```
默认值设置  
- XMX 1024m
- XMS 128m  
- PERM_SIZE
- MAX_PERM_SIZE 64m
- MAX_PERM_SIZE 256m
