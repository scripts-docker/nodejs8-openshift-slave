FROM openshift/jenkins-slave-base-centos7

RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -

RUN yum -y install nodejs && yum clean all -y

RUN mkdir -p /opt/sonar-scanner

COPY sonar-scanner /opt/sonar-scanner

ENV PATH=$PATH:/opt/sonar-scanner/bin

RUN chmod +x /opt/sonar-scanner/bin/sonar-scanner

RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME && \
    chown -R 1001:0 /opt/sonar-scanner && \
    chmod -R g+rw /opt/sonar-scanner 
    
COPY google-chrome.repo /etc/yum.repos.d/ 
RUN yum -y install google-chrome-stable && yum clean all -y

RUN chgrp -R 0 /opt/google
RUN chmod -R g+rw /opt/google

RUN chmod 4755 /opt/google/chrome/chrome-sandbox

USER 1001
