FROM python:3.13-slim
WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1

COPY --from=src pyproject.toml ./
COPY --from=src leaderboard ./leaderboard
COPY --from=src scripts ./scripts
# httpx só pro simulador, que usa a mesma imagem
RUN pip install --no-cache-dir . httpx && useradd --system app
USER app

EXPOSE 8000
CMD ["uvicorn", "leaderboard.api:app", "--host", "0.0.0.0", "--port", "8000", "--proxy-headers"]
