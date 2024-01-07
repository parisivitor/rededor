from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Projetc Rede D`or with CI/CD, Terraform on aws! Everything works!!!!"}

@app.get("/end")
def read_root():
    return {"message": "AGORA FOI CARALHOOOOOO!!!!!!!!!!!!!!"}
