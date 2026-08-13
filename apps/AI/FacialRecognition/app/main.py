from fastapi import FastAPI

app = FastAPI()

@app.get("/api/ai-face/test")
def test_python():
    return {"message": "THÀNH CÔNG: Đây là phản hồi từ PYTHON (Face Recognition)!"}