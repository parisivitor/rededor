import requests

def test_status_code_home():
    response = requests.get('http://127.0.0.1:8000')
    assert response.status_code == 200
    assert response.json()['message'] == "Projetc Rede D`or with CI/CD, Terraform on aws! Everything works!!!!"
