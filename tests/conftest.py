"""Pytest configuration for test environment."""
import socket
import time
import pytest


def is_backend_running(host='127.0.0.1', port=8000, timeout=1, retries=3):
    """Check if backend is running on the given port."""
    for attempt in range(retries):
        try:
            sock = socket.create_connection((host, port), timeout=timeout)
            sock.close()
            return True
        except (socket.timeout, ConnectionRefusedError, OSError):
            if attempt < retries - 1:
                time.sleep(0.5)
    return False


def pytest_collection_modifyitems(config, items):
    """
    Mark integration tests:
    - SKIP in CI (no backend running)
    - RUN locally (backend available)
    """
    backend_available = is_backend_running()
    
    # Tests that require a running FastAPI backend
    integration_tests = {
        'test_root_without_api_key',
        'test_root_with_api_key',
        'test_classify_without_api_key',
        'test_classify_with_api_key',
        'test_resumes',
    }
    
    for item in items:
        if item.name in integration_tests:
            if not backend_available:
                item.add_marker(pytest.mark.skip(reason="Backend not running on port 8000"))
