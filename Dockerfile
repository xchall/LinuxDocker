# Этап сборки
FROM python:3.11-slim as builder

WORKDIR /app
COPY pyproject.toml .
RUN pip install --user -e .

# Финальный образ
FROM python:3.11-slim
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY --from=builder /app /app
COPY src/ src/

# Настройки
ENV PATH="/root/.local/bin:${PATH}"
ENV PYTHONUNBUFFERED=1
USER nobody

# Порт и healthcheck
EXPOSE 8041
HEALTHCHECK --interval=30s --timeout=3s CMD curl -f http://localhost:8041/health || exit 1

# Команда запуска
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8041"]
