centos-docker-custom-build
==========================

Simple scripts to build your own Centos base docker with customizations and additionnal packages. Designed to be lightweight and easy to use, based on official repository.

1. Clone this repository
2. Install python-imgcreate
```
yum install python-imgcreate
```
3. Install ami-creator
```
easy_install ami-creator
```
4. Personnalize centos65-ovh.ks and create your own. Refer to inline comments.
5. Launch image building
```
ami-creator <your_ks_file> <image_name>
```
6. Transform this image to a Docker
```
chmod +x img2docker.sh
./img2docker.sh <image_name>.img <docker_name>
```

That's it !

Sources :
https://github.com/CentOS/sig-cloud-instance-build/tree/master/docker
http://dan.carley.co/blog/2012/04/17/centos-amis-from-kickstart/
