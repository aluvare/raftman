FROM ubuntu:jammy AS builder
RUN apt update && apt install golang-go ca-certificates -y

RUN mkdir -p /opt/app

ADD . /opt/app

RUN cd /opt/app && \
        go build raftman.go

FROM ubuntu:jammy AS final

RUN mkdir -p /opt/app/

COPY --from=builder /opt/app/raftman /opt/app/raftman

ENTRYPOINT ["/opt/app/raftman"]
