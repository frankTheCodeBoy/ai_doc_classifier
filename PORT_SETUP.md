# Port Configuration for resume-classifier

## Container Ports (Internal)
- **Backend API**: 8000 (FastAPI/Uvicorn)
- **Streamlit UI**: 8501 (Streamlit)

## Host Ports (External - for accessing from browser/client)
- **Backend API**: 8002 → http://localhost:8002
- **Streamlit UI**: 8502 → http://localhost:8502

## Running the Container

### With docker-compose (Recommended)
```bash
docker compose up -d
```

### With docker run
```bash
docker run -d -p 8002:8000 -p 8502:8501 --name resume-prod resume-classifier:latest
```

## Accessing the Services

- Streamlit App: http://localhost:8502
- Backend API: http://localhost:8002
- API Documentation: http://localhost:8002/docs

## Environment Variables
Set in `docker-compose.yml`:
- `BACKEND_API_KEY`: API authentication key (default: changeme123)
- `ALLOWED_ORIGINS`: CORS allowed origins

To change ports, update `docker-compose.yml` before running `docker compose up -d`.
