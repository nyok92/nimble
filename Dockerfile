FROM ubuntu:bionic
MAINTAINER Sergei Ovchinnikov (https://wmspanel.com/help)
LABEL	description="Nimble Streamer with SRT"

RUN	apt-get update -y
RUN	apt-get install wget gnupg sudo vim less -y

ENV	TZ=Europe/Paris
RUN	ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN	wget -q -O - http://nimblestreamer.com/gpg.key | sudo apt-key add -
RUN	apt-get update -y
RUN	echo "deb http://nimblestreamer.com/ubuntu bionic/">>/etc/apt/sources.list \
	&& apt-get update -y
RUN	apt-get install nimble nimble-srt -y

#ENV WMSPANEL_SERVER_NAME=$WMSPANEL_SERVER_NAME
#ENV WMSPANEL_ACCOUNT=$WMSPANEL_ACCOUNT
#ENV WMSPANEL_PASS=$WMSPANEL_PASS
#ENV WMSPANEL_HOST=$WMSPANEL_HOST

#ARG	WMSPANEL_SERVER_NAME=Enter_Docker_container_friendly_name_for_WMSPANEL
#ARG	WMSPANEL_ACCOUNT=ENTER_YOUR_ACCOUNT
#ARG	WMSPANEL_PASS=ENTER_YOUR_PASSWORD

#RUN	sudo /usr/bin/nimble_regutil -u $WMSPANEL_ACCOUNT -p $WMSPANEL_PASS --server-name $WMSPANEL_SERVER_NAME --host $WMSPANEL_HOST

EXPOSE 8081 1935 554 4444/udp
ENTRYPOINT	["/usr/bin/nimble", "--conf-dir=/etc/nimble", "--log-dir=/var/log/nimble","--pidfile=/var/run/nimble/nimble.pid"]
