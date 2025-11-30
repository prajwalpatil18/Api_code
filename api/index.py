# api/index.py
from fastapi import FastAPI
from mangum import Mangum
import sys
import os

# Make sure your app.py is importable
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from app import app  # import your FastAPI instance

handler = Mangum(app)
