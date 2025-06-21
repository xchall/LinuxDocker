FROM python:3.11-alpine as builder

WORKDIR /app


RUN python -m venv /app/venv

ENV PATH="/app/venv/bin:$PATH"
ENV PYTHONUNBUFFERED=1

COPY pyproject.toml /app



FROM python:3.11-alpine

WORKDIR /app

COPY --from=builder /app/venv /app/venv
COPY src /app/src

ENV PATH="/app/venv/bin:$PATH"
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

CMD [ "uvicorn", "src.main:app", "--reload", "--host", "0.0.0.0", "--port", "8044" ]
