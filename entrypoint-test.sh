#!/usr/bin/env python
"""Test entrypoint that starts FastAPI backend then runs tests."""
import socket
import subprocess
import sys
import time
from pathlib import Path

def wait_for_port(host='127.0.0.1', port=8000, timeout=30):
    """Wait for port to be open."""
    start = time.time()
    while time.time() - start < timeout:
        try:
            sock = socket.create_connection((host, port), timeout=1)
            sock.close()
            return True
        except (socket.timeout, ConnectionRefusedError, OSError):
            time.sleep(0.5)
    return False

def main():
    app_dir = Path('/app')
    
    print("🚀 Starting FastAPI backend on port 8000...")
    
    # Start the backend server
    backend_proc = subprocess.Popen(
        [sys.executable, '-m', 'uvicorn', 'api.main:app', '--host', '0.0.0.0', '--port', '8000', '--log-level', 'info'],
        cwd=app_dir,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True
    )
    
    print(f"Backend process started (PID: {backend_proc.pid})")
    
    # Wait for server to be ready
    print("⏳ Waiting for backend to be ready...")
    if not wait_for_port():
        print("❌ Backend failed to start in time")
        backend_proc.terminate()
        backend_proc.wait()
        return 1
    
    print("✅ Backend is ready!")
    
    # Run tests
    print("🧪 Running tests...")
    test_proc = subprocess.run(
        [sys.executable, '-m', 'pytest', '-v', '--tb=short', 'tests/'],
        cwd=app_dir
    )
    
    # Cleanup
    print("🛑 Stopping backend...")
    backend_proc.terminate()
    try:
        backend_proc.wait(timeout=5)
    except subprocess.TimeoutExpired:
        backend_proc.kill()
        backend_proc.wait()
    
    return test_proc.returncode

if __name__ == '__main__':
    sys.exit(main())
