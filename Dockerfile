# Use Python slim base image
FROM python:3.10-slim

# Avoid Python buffering
ENV PYTHONUNBUFFERED=1

# Install system dependencies required for FAISS
RUN apt-get update && apt-get install -y \
    build-essential \
    libopenblas-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements first (for caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy your entire project
COPY . .

# Expose the port your FastAPI app will run on
EXPOSE 8080

# Set environment variables for your app
# (Values will be injected later on Fly.io / Railway)
ENV OPENAI_API_KEY=""
ENV GROQ_API_KEY=""

# Fly.io requires binding to PORT=8080
ENV PORT=8080

# Start FastAPI app with Uvicorn
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080"]
