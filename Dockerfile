# ---- Base Image ----
FROM python:3.10-slim

# ---- Set working directory ----
WORKDIR /app

# ---- Install system dependencies for FAISS & scientific libs ----
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libopenblas-dev \
    libomp-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ---- Copy project files ----
COPY . .

# ---- Install Python dependencies ----
RUN pip install --no-cache-dir -r requirements.txt

# ---- Expose Fly.io default port ----
EXPOSE 8080

# ---- Run FastAPI using Fly PORT environment variable ----
CMD ["sh", "-c", "uvicorn app:app --host 0.0.0.0 --port ${PORT:-8080}"]
