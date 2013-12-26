# runnable base
FROM stackbrew/ubuntu:saucy
MAINTAINER Jon Surrell <jon@surrell.es>
# REPOS
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"

# Node
# RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get -y update

#SHIMS
#RUN dpkg-divert --local --rename --add /sbin/initctl
#RUN ln -s /bin/true /sbin/initctl
#ENV DEBIAN_FRONTEND noninteractive

# EDITORS
RUN apt-get install -y vim

# TOOLS
RUN apt-get install -y curl git wget

# BUILD
# RUN apt-get install -y build-essential g++

# LANGS

## PHP
RUN apt-get install -y php5 php5-cli php5-dev

## NODE
#RUN apt-get install -y nodejs

# SERVICES

## APACHE
RUN apt-get install -y apache2 libapache2-mod-php5

## MYSQL
RUN apt-get install -y mysql-client mysql-server php5-mysqlnd

## APP
RUN rm -rf /var/www/*
ADD app /var/www

### APP DB
RUN service mysql   start
RUN service apache2 start

RUN mysqladmin create gestorneo
RUN mysql -uroot gestorneo < /var/www/application/sql/gestorneo.sql

EXPOSE 80
#ENTRYPOINT ["/usr/sbin/apache2"]

# RESET

#ENV DEBIAN_FRONTEND dialog

## CONFIG
#ENV RUNNABLE_USER_DIR /var/www
#ENV RUNNABLE_SERVICE_CMDS /etc/init.d/apache2 restart; mysqld
