FROM golang:1.26-alpine AS build
WORKDIR /src
COPY --from=src go.mod ./
COPY --from=src cmd ./cmd
COPY --from=src internal ./internal
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /a2s-monitor ./cmd/a2s-monitor

FROM gcr.io/distroless/static-debian12:nonroot
COPY --from=build /a2s-monitor /a2s-monitor
ENTRYPOINT ["/a2s-monitor"]
CMD ["run", "-config", "/config/servers.json", "-listen", ":9105"]
