# Use lightweight Python base
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install system dependencies (required for FAISS)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libopenblas-dev \
    libomp-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy your project files into the container
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 8080 (Fly.io default)
EXPOSE 8080

# Start FastAPI server
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080"]
