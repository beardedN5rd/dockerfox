FROM ubuntu:18.04

RUN apt-get update && apt-get install -y firefox

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/dockerfox && \
    echo "dockerfox:x:${uid}:${gid}:dockerfox,,,:/home/dockerfox:/bin/bash" >> /etc/passwd && \
    echo "dockerfox:x:${uid}:" >> /etc/group && \
    mkdir -p /etc/sudoers.d/ && \
    echo "dockerfox ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/dockerfox && \
    chmod 0440 /etc/sudoers.d/dockerfox && \
    chown ${uid}:${gid} -R /home/dockerfox

USER dockerfox
ENV HOME /home/dockerfox
CMD /usr/bin/firefox
