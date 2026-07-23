# 1. Khai báo biến BASE_IMAGE (mặc định là python thuần để chạy local)
ARG BASE_IMAGE=python:3.9.12

# 2. Sử dụng biến này làm base để có thể nhận image chứa sẵn PyTorch/OpenCV từ GAR thông qua CI/CD
FROM ${BASE_IMAGE}
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
# (Lưu ý: Model weights có thể được mount vào container thông qua Volume trên K3s)
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]