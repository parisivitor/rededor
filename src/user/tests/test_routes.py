import requests

def test_status_code_home():
    response = requests.get('http://localhost:8000')
    assert response.status_code == 200
