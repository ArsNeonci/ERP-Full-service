from sqlalchemy.orm import Session
from app.models.schemas import EmployeeFace

def find_matching_employee(db: Session, unknown_face_vector: list, threshold: float = 0.6):
    # Truy vấn pgvector sử dụng khoảng cách L2 (Euclidean)
    # Lấy ra nhân viên có vector khuôn mặt giống nhất với khuôn mặt đầu vào
    closest_match = db.query(EmployeeFace)\
        .order_by(EmployeeFace.face_encoding.l2_distance(unknown_face_vector))\
        .first()

    # Kiểm tra xem khoảng cách có nằm trong ngưỡng cho phép (threshold) không
    if closest_match:
        distance = db.scalar(
            EmployeeFace.face_encoding.l2_distance(unknown_face_vector)
        )
        if distance < threshold:
            return closest_match
    
    return None