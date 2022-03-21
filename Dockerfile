FROM alpine as builder

RUN apk add --no-cache ca-certificates curl && \
    wget -O - $(curl -s  curl -s https://api.github.com/repos/tindy2013/stairspeedtest-reborn/releases/latest | grep browser_download_url | grep linux64 | cut -d '"' -f 4) > /sst.tar.gz

FROM alpine:latest

COPY --from=builder /sst.tar.gz /sst.tar.gz
COPY entrypoint.sh /usr/local/bin/

RUN tar zxf /sst.tar.gz -C /opt && \
 rm -f /sst.tar.gz && \
 chmod a+x /usr/local/bin/entrypoint.sh
 
ENTRYPOINT ["entrypoint.sh"]
