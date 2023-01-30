FROM amd64/alpine

ENV STARTUP_COMMAND_RUN_VSFTP="vsftpd /etc/vsftpd/vsftpd.conf"

ADD wrapper.sh /
ADD vsftpd.conf vsftpd.email_passwords vsftpd.banner /etc/vsftpd/

RUN ln -s /etc/vsftpd/vsftpd.email_passwords /etc/vsftpd.email_passwords && \
    apk --no-cache --no-progress update && \
    apk --no-cache --no-progress add vsftpd && \
    ln -sf /proc/1/fd/1 /var/log/vsftpd.log

VOLUME /var/lib/ftp/incoming

WORKDIR /var/lib/ftp

EXPOSE 21 32022-32041

ENTRYPOINT /wrapper.sh
