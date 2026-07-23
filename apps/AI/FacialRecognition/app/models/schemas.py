from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import declarative_base
from pgvector.sqlalchemy import Vector

Base = declarative_base()

class EmployeeFace(Base):
    __tablename__ = 'employee_faces'

    id = Column(Integer, primary_key=True)
    employee_id = Column(String, unique=True, index=True) # Liên kết với HRM
    name = Column(String)
    # Khai báo trường vector (ví dụ 512 chiều nếu dùng mô hình FaceNet)
    face_encoding = Column(Vector(512))