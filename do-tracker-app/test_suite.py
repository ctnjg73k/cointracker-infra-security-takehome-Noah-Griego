from fastapi.testclient import TestClient
from main import app

c = TestClient(app)


def test_delta():
    r1 = c.get("/")
    assert r1.status_code == 401

    r2 = c.get("/", headers={"X-API-Key": "wrong-secret"})
    assert r2.status_code == 401

    r3 = c.get("/", headers={"X-API-Key": "test-secret"})
    assert r3.status_code == 200
