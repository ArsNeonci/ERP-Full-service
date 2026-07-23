from fastapi import FastAPI

# 1. BIẾN 'app' BẮT BUỘC PHẢI TỒN TẠI VÀ ĐÚNG TÊN
app = FastAPI(
    title="ERP AI Service",
    version="1.0.0"
)

@app.get("/")
def read_root():
    return {"status": "AI Service is running"}