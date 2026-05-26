from fastapi.testclient import TestClient

from api.main import app
import api.main as api_main


client = TestClient(app)


def test_analyze_endpoint_returns_summary(monkeypatch):
    monkeypatch.setattr(
        api_main,
        "extract_text_from_upload",
        lambda filename, contents: (
            "Experienced Python developer with FastAPI and SQL skills."
        ),
    )

    monkeypatch.setattr(
        api_main,
        "run_semantic_analysis",
        lambda text: {
            "summary": (
                "Experienced Python developer with FastAPI and SQL skills."
            ),
            "skills": ["Python", "FastAPI", "SQL"],
            "recommended_roles": ["Backend Engineer"],
            "score": 88,
            "source": "local",
        },
    )

    response = client.post(
        "/analyze",
        files={"file": ("resume.pdf", b"%PDF-1.4\n", "application/pdf")},
    )

    assert response.status_code == 200
    payload = response.json()
    assert payload["summary"]
    assert payload["skills"] == ["Python", "FastAPI", "SQL"]
    assert payload["recommended_roles"] == ["Backend Engineer"]
    assert payload["score"] == 88
