FROM alpine:latest

ARG USER=daskdb
ARG HOME=/HOME/$USER

WORKDIR /function
ADD . /function/

RUN apk update
RUN apk add openssh
RUN apk add sshpass

#RUN pip install -r requirements.txt

RUN addgroup -S docker
RUN adduser \
	--disabled-password \
	-u 1000 \
	--gecos "" \
	daskdb
RUN adduser daskdb docker
USER daskdb

ENTRYPOINT ["/bin/sh", "/function/init.sh"]
CMD ["0"]

