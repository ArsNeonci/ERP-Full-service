FROM arsneonci/ai-base:latest 
WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy toàn bộ thư mục app (bao gồm cả api, core, models, services và main.py)
COPY ./app ./app

EXPOSE 8000

# Trỏ uvicorn vào file main.py nằm TRONG thư mục app (app.main:app)
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]