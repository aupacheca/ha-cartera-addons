# Cartera Inversiones - Add-on Home Assistant
# Base Debian: wheels precompilados para numpy/pandas en ARM (evita compilación)

ARG BUILD_FROM
FROM ${BUILD_FROM}

# Crear directorio de la aplicación
WORKDIR /app

# Copiar requirements e instalar dependencias Python
# Debian tiene wheels para todas las arquitecturas - sin compilación
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

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
