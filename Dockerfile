FROM python:latest
ENV PYTHONUNBUFFERED 1

# add source for snmp
RUN sed -i "s#jessie main#jessie main contrib non-free#g" /etc/apt/sources.list
# install dependancies
RUN apt-get update -y \
    && apt-get install -y apt-utils python-software-properties libsasl2-dev python3-dev libldap2-dev libssl-dev libsnmp-dev git vim

# copy and install requirements
RUN mkdir /config  
ADD /config/requirements.txt /config/  
RUN pip install -r /config/requirements.txt  
# create folders
RUN mkdir /itapp;
RUN mkdir /static;
# create celery user
RUN useradd -N -M --system -s /bin/false celery
RUN echo celery:"B1llyB0n3s" | /usr/sbin/chpasswd
# celery perms
RUN groupadd grp_celery
RUN usermod -a -G grp_celery celery
RUN mkdir /var/run/celery/
RUN mkdir /var/log/celery/
RUN chown root:root /var/run/celery/
RUN chown root:root /var/log/celery/
# copy celery daemon files
ADD /config/celery/init_celeryd /etc/init.d/celeryd
RUN chmod +x /etc/init.d/celeryd
ADD /config/celery/celerybeat /etc/init.d/celerybeat
RUN chmod +x /etc/init.d/celerybeat
RUN chmod 755 /etc/init.d/celeryd
RUN chown root:root  /etc/init.d/celeryd
RUN chmod 755 /etc/init.d/celerybeat
RUN chown root:root /etc/init.d/celerybeat
# copy celery config
ADD /config/celery/default_celeryd /etc/default/celeryd
# set workign DIR for copying code
ADD /itapp/ /itapp/itapp
WORKDIR /itapp