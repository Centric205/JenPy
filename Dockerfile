FROM python:3.8-slim-buster

WORKDIR /app

COPY . .

RUN pip install -r requirments.txt

CMD [ "python", "app.py" ]