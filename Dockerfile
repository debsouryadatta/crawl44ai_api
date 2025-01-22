FROM python:3.11-slim-bookworm

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

RUN playwright install

COPY . .

EXPOSE 10000

CMD ["uvicorn", "main:app", "--host=0.0.0.0", "--reload", "--port=10000"]