FROM python:3.11-alpine

WORKDIR /app

# Установка минимальных системных зависимостей
RUN apk add --no-cache libpq

# Копирование зависимостей и установка
COPY pyproject.toml poetry.lock* /app/

# Установка Poetry (если используете) или напрямую зависимостей
RUN pip install --upgrade pip && \
    pip install uvicorn fastapi  # Добавьте здесь другие зависимости

# Копирование исходного кода
COPY src /app/src

# Настройка окружения
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

EXPOSE 8044

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8044"]
