FROM openjdk:8-jre-alpine


RUN apk --no-cache --update add curl ca-certificates tar \
docker py-pip python-dev libffi-dev openssl-dev gcc libc-dev make git
RUN pip install docker-compose
RUN pip install jenkins-webapi
RUN apk add --no-cache --update openssh

RUN mkdir -p /home/jenkins
RUN mkdir -p /var/lib/jenkins

ADD slave.py /var/lib/jenkins/slave.py

WORKDIR /home/jenkins

ENV JENKINS_URL "https://eba2d854.ngrok.io"
ENV JENKINS_SLAVE_ADDRESS ""
ENV JENKINS_USER "meron"
ENV JENKINS_PASS "pass"
ENV SLAVE_NAME ""
ENV SLAVE_SECRET ""
ENV SLAVE_EXECUTORS "1"
ENV SLAVE_LABELS "docker"
ENV SLAVE_WORING_DIR ""
ENV CLEAN_WORKING_DIR "true"

CMD [ "python", "-u", "/var/lib/jenkins/slave.py" ]