# Cartera Inversiones - Add-on Home Assistant
# Optimizado para ARM64 (Raspberry Pi 4) y otras arquitecturas

ARG BUILD_FROM
FROM ${BUILD_FROM}

# Instalar dependencias del sistema para pandas/numpy (Alpine)
RUN apk add --no-cache \
    build-base \
    libffi-dev \
    libstdc++

# Crear directorio de la aplicación
WORKDIR /app

# Copiar requirements e instalar dependencias Python
# --prefer-binary evita compilar desde fuente (importante en Raspberry Pi)
COPY requirements.txt .
RUN pip3 install --no-cache-dir --prefer-binary -r requirements.txt

# Copiar aplicación
COPY app.py .

# Directorio de datos persistente (mapeado a /data por HA)
ENV DATA_DIR=/data
WORKDIR /data

# Exponer puerto Streamlit (versión de prueba: 8502)
EXPOSE 8502

# Script de inicio (corregir CRLF de Windows si existe)
COPY run.sh /run.sh
RUN sed -i 's/\r$//' /run.sh && chmod a+x /run.sh

CMD ["/run.sh"]
