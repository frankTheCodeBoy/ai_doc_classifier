#!/bin/bash
set -e

echo "🚀 Starting FastAPI backend on port 8000..."
python -m uvicorn api.main:app --host 0.0.0.0 --port 8000 --log-level info &
BACKEND_PID=$!

echo "⏳ Waiting for backend to be ready..."
for i in {1..30}; do
  if python -c "import socket; socket.create_connection(('127.0.0.1', 8000), timeout=1)" 2>/dev/null; then
    echo "✅ Backend is ready!"
    break
  fi
  echo "Waiting... ($i/30)"
  sleep 1
done

echo "🧪 Running tests..."
pytest -v --tb=short tests/

TEST_RESULT=$?

echo "🛑 Stopping backend..."
kill $BACKEND_PID 2>/dev/null || true
wait $BACKEND_PID 2>/dev/null || true

exit $TEST_RESULT
