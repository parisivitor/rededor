FROM python:3.11-slim

ENV TZ=America/Sao_Paulo
ENV LANG C.UTF-8
ENV LANGUAGE=pt_BR:pt
ENV LC_ALL C.UTF-8

RUN apt update && apt install -y

WORKDIR /home/app/

ENV PYTHONPATH=${PYTHONPATH}/home/app/src

COPY requirements.txt /home/app
COPY . /home/app/

RUN pip install -r requirements.txt

EXPOSE 8000

# CMD [ "tail", "-f", "/dev/null" ]
CMD ["uvicorn", "--host=0.0.0.0", "--port=8000", "main:app"]

# docker run --rm -p 8000:8000 parisivitor95/rededor:latest
