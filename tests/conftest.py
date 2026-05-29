"""Pytest configuration for test environment."""
import pytest


def pytest_collection_modifyitems(config, items):
    """Mark integration tests to skip in CI (no backend)."""
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
            item.add_marker(pytest.mark.skip(reason="Requires running FastAPI backend"))
