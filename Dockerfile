#######################
# 3.a BASE STAGE
#######################
FROM ubuntu:22.04 AS base

RUN apt-get update && \
    apt-get install -y cron && \
    useradd -m abc && \
    mkdir -p /opt/demo-folder && \
    chown -R abc:abc /opt/demo-folder

#######################
# 3.b INTERMEDIATE STAGE
#######################
FROM base AS intermediate

COPY script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

# Setup cronjob (template, will be overridden in later stages)
RUN echo "* * * * * abc /usr/local/bin/script.sh 1 >> /var/log/cron.log 2>&1" > /etc/cron.d/mycron && \
    chmod 0644 /etc/cron.d/mycron && \
    crontab -u abc /etc/cron.d/mycron

#######################
# 3.c CLEANUP STAGE (runs script with input 0)
#######################
FROM intermediate AS cleanup

RUN echo "* * * * * abc /usr/local/bin/script.sh 0 >> /var/log/cron.log 2>&1" > /etc/cron.d/mycron && \
    crontab -u abc /etc/cron.d/mycron

CMD ["cron", "-f"]

#######################
# 3.d CREATE STAGE (runs script with input 1)
#######################
FROM intermediate AS create

RUN echo "* * * * * abc /usr/local/bin/script.sh 1 >> /var/log/cron.log 2>&1" > /etc/cron.d/mycron && \
    crontab -u abc /etc/cron.d/mycron

CMD ["cron", "-f"]

