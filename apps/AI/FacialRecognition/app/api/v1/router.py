from fastapi import APIRouter

router = APIRouter()

@router.get("/api/ai-face/test")
async def test_ai_face_api():
    return {
        "service": "FacialRecognition", 
        "tech": "Python FastAPI", 
        "status": "200 OK", 
        "message": "AI Face Service is reachable via API Gateway!"
    }