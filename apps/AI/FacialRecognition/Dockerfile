# 1. Khai báo biến BASE_IMAGE (có thể để mặc định là python thuần để chạy local)
ARG BASE_IMAGE=python:3.9.12

# 2. Sử dụng biến này làm base
FROM ${BASE_IMAGE}
WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy toàn bộ thư mục app (bao gồm cả api, core, models, services và main.py)
COPY ./app ./app

EXPOSE 8001

# Trỏ uvicorn vào file main.py nằm TRONG thư mục app (app.main:app)
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]