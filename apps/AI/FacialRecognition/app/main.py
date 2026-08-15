import uvicorn
from fastapi import FastAPI
from app.api.v1.router import router

app = FastAPI()
app.include_router(router)

if __name__ == "__main__":
    # Port 8001 khớp với containerPort trong ai-face-recognition.yaml
    uvicorn.run(app, host="0.0.0.0", port=8001)