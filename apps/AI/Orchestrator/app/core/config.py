import os
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    ENV: str = os.getenv("ENV", "development")
    
    # 1. PostgreSQL (LangGraph Checkpointing)
    DB_HOST: str = os.getenv("DB_HOST", "postgres-db")
    DB_PORT: str = os.getenv("DB_PORT", "5432")
    DB_USER: str = os.getenv("DB_USERNAME", "postgres")
    DB_PASS: str = os.getenv("DB_PASSWORD", "secret_password")
    DB_NAME: str = os.getenv("DB_NAME", "ai_orchestrator_db")
    
    # 2. Redis (Semantic Cache & Tokens)
    REDIS_HOST: str = os.getenv("REDIS_HOST", "redis-cache")
    REDIS_PORT: str = os.getenv("REDIS_PORT", "6379")
    
    # 3. MongoDB (Reasoning Logs)
    MONGO_HOST: str = os.getenv("MONGO_HOST", "mongodb-service")
    MONGO_PORT: str = os.getenv("MONGO_PORT", "27017")
    MONGO_DB: str = os.getenv("MONGO_DB", "ai_logs_db")

settings = Settings()