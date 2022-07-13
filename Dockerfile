#FROM golang:1.12 as exporter
FROM golang:1.18 as exporter
ENV GO111MODULE=on
RUN go install github.com/jonnenauha/prometheus_varnish_exporter@1.6.1

FROM varnish:6.0
COPY --from=exporter /go/bin/prometheus_varnish_exporter /usr/local/bin
EXPOSE 9131
VOLUME /var/lib/varnish
ENTRYPOINT ["/usr/local/bin/prometheus_varnish_exporter"]
