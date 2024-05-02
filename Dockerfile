FROM ubuntu:latest
LABEL authors="gabrielguzman"

# Usar una imagen base de Python
FROM python:3.11-slim

# Establecer el directorio de trabajo
WORKDIR /app

# Instalar herramientas de compilación y dependencias necesarias para la compilación
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libc6-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Instalar las dependencias del proyecto
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar los archivos del proyecto al contenedor
COPY . .

# Exponer el puerto que utiliza FastAPI
EXPOSE 8000

# Comando para ejecutar la aplicación
CMD ["uvicorn", "api.api:app", "--host", "0.0.0.0", "--port", "8000"]