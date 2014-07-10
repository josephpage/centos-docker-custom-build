FROM centos:6.4
MAINTAINER Joseph Page <josephpage@github>

RUN yum install -y python-imgcreate tar
RUN git clone https://github.com/katzj/ami-creator.git -b master --depth=1; \
  easy_install ami-creator
ADD . /root/

VOLUME /volume
RUN ["start.sh"]
