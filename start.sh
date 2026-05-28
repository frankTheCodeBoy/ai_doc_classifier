#!/bin/bash
# Start FastAPI backend
uvicorn api.main:app --host 0.0.0.0 --port 8000 &

# Start Streamlit frontend
streamlit run ui/app.py --server.port=8501 --server.headless=true
