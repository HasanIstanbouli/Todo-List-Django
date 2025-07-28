FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1 PYTHONDONTWRITEBYTECODE=1 PIP_NO_CACHE_DIR=1

# Install dependencies for GObject
RUN apt-get update && apt-get install -y \
    gir1.2-gtk-3.0 \
    libpq-dev gcc  \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

RUN pip install --upgrade pip && pip install -r requirements.txt

COPY . .

RUN chmod +x ./entrypoint.sh

# Run as non-root user (optional but highly recommended in production)
#RUN useradd -m appuser
#USER appuser

ENTRYPOINT ["./entrypoint.sh"]
