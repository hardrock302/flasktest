FROM alpine as intermediate
LABEL stage=intermediate
ARG SSH_PRIVATE_KEY

RUN apk update && \
apk add --update git && \
apk add --update openssh


RUN mkdir -p /root/.ssh/ && \
echo "$SSH_KEY" > /root/.ssh/id_rsa && \
chmod -R 600 /root/.ssh/ && \
ssh-keygen -t rsa github.com >> ~/.ssh/known_hosts

RUN git clone git@github.com:hardrock302/flasktest.git

FROM alpine

RUN apk add python3
RUN mkdir app
COPY --from-intermediate /flasktest/* /app/

RUN python3 -m pip install /app/requirements.txt
CMD ["flask --app  ip run"]


