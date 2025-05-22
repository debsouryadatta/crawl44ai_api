FROM python:3.11-slim-bookworm

WORKDIR /app

# Install system dependencies for Playwright and Git for GitIngest
RUN apt-get update && apt-get install -y \
    git \
    libglib2.0-0 \
    libnss3 \
    libnspr4 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libdbus-1-3 \
    libexpat1 \
    libxcb1 \
    libxkbcommon0 \
    libx11-6 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2 \
    libatspi2.0-0 \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install -r requirements.txt

RUN playwright install

COPY . .

EXPOSE 10000

CMD ["uvicorn", "main:app", "--host=0.0.0.0", "--reload", "--port=10000"]