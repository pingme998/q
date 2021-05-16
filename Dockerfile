FROM kalilinux/kali-rolling
EXPOSE 8080

RUN apt update -y
RUN mkdir /.config
RUN mkdir /.config/rclone
RUN apt install curl -y
RUN apt install unrar -y
RUN apt install wget -y
RUN apt install unzip -y  && \
    curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip rclone-current-linux-amd64.zip && \
    cp /rclone-*-linux-amd64/rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone && \
    apt install aria2 -y
RUN apt install jupyter -y
RUN apt install unzip -y
RUN apt install supervisor -y
RUN mkdir /n 
RUN chown root:root /n && \
    chmod 755 /n
COPY jupyter.py /conf/jupyter.py
COPY jupyter_notebook_config.json /root/.jupyter/jupyter_notebook_config.json
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN rclone version
RUN wget 'https://gist.githubusercontent.com/developeranaz/fb2150cc762fcdb7045dfe83a1439de3/raw/9a80dfaed40e9120a75513b1a1eb9d90f0914bf3/rclon.conf' -O '/.config/rclone/rclone.conf'
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD /entrypoint.sh
#CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
