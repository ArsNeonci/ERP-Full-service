# Sử dụng trực tiếp image Python nhẹ vì Orchestrator không cần tính toán AI nặng
FROM python:3.9.12
WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libpq-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy toàn bộ thư mục app (bao gồm cả api, core, models, services và main.py)
COPY ./app ./app

EXPOSE 8000

# Trỏ uvicorn vào file main.py nằm TRONG thư mục app (app.main:app)
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]