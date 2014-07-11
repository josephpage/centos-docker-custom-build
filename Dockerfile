FROM centos:centos6
MAINTAINER Joseph Page <joseph.page@rednet.io>

RUN yum install -y git python-imgcreate tar
RUN git clone https://github.com/katzj/ami-creator.git -b master --depth=1; \
  easy_install ami-creator
ADD . /root/

VOLUME /volume
RUN ["start.sh"]
