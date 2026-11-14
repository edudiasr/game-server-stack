FROM python:3.13-slim
WORKDIR /app
COPY --from=src relay/relay.py ./
COPY --from=src examples/killfeed.jsonl ./exemplo/killfeed.jsonl
RUN useradd --system app && chown -R app /app
USER app
# manda o killfeed de exemplo uma vez; o .state fica dentro do container
CMD ["sh", "-c", "python relay.py --file exemplo/killfeed.jsonl --url http://ranking:8000 --key \"$LB_API_KEY\" --once"]
