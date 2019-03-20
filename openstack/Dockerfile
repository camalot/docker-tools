FROM python:3.7.2

RUN apt-get update && \
	apt-get install \
	gcc libffi-dev libssl-dev \
	wget \
	git  && \
	pip install python-openstackclient

ENTRYPOINT ["openstack"]
