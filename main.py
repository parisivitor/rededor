from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Project Rede D`or with CI/CD, Terraform on aws! It`s over! Let`s bora!!!"}
