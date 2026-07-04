FROM python:3.13.6-slim-bullseye AS ai-base
WORKDIR /app

# Cài đặt các thư viện hệ thống cần thiết cho OpenCV
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential libgl1-mesa-glx libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# BƯỚC 1: Cài đặt nhóm PyTorch từ kho của hãng (chỉ dùng CPU để giảm dung lượng)
RUN pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# BƯỚC 2: Cài đặt các thư viện Data & AI còn lại từ kho chuẩn PyPI
RUN pip install --no-cache-dir \
    pandas numpy opencv-python-headless \
    langchain transformers fastapi uvicorn pydantic