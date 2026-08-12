from fastapi import FastAPI

app = FastAPI()

@app.get("/api/ai-face/health")
def health_check():
    return {"status": "success", "message": "Face Recognition Service is running successfully!"}