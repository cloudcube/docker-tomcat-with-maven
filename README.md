Docker Job Service

## 构建脚本  

publish_jobservice.sh


    #!/bin/sh
    set -e
    
    CODE_BRANCH=${CODE_BRANCH:-"master"}
    SERVER_NAME=${SERVER_NAME:-"jobservice"}
    SSH_PORT=${SSH_PORT:-"10046"}
	
    TMP_PATH=~/tmp
    DOCKER_FOLDER=docker_repos
    DOCKER_DESIGNER=docker-jobservice
    
    if [ ! -d "$TMP_PATH" ] ; then
       mkdir "$TMP_PATH"
    fi
    cd "$TMP_PATH"
    
    if [ ! -d "$DOCKER_FOLDER" ] ; then
       mkdir "$DOCKER_FOLDER"
    fi
    
    cd "$DOCKER_FOLDER"
    
    if [ -d "$DOCKER_DESIGNER" ] ; then
    #echo "hello,docker"
       rm -rf $DOCKER_DESIGNER
    fi
    
    git clone sixstar:david/docker-job-service.git $DOCKER_DESIGNER
    
    cd $DOCKER_DESIGNER
    
    git checkout -b "${CODE_BRANCH}" origin/"${CODE_BRANCH}"
    
    docker rm -f "${SERVER_NAME}"
    
    docker rmi $(docker images | grep "192.168.0.240:4000/'${SERVER_NAME}'" | awk {'print $3'})
    
    docker build --no-cache --rm=true -t "${SERVER_NAME}" .
    
    docker run --name "${SERVER_NAME}" -d -p "${SSH_PORT}":22 "${SERVER_NAME}"
    
    cd ~
	
## 使用
`docker run --name job-service -d -p 10046:22 jobservice`


