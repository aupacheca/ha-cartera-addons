#!/bin/sh
# Script de inicio para Cartera TEST (Add-on Home Assistant - versión de prueba)
# Los datos se persisten en /data (mapeado por HA)
# Usa acciones_test.db para no interferir con la versión real

export DATA_DIR=/data
export DB_FILENAME=acciones_test.db

# Crear directorio de datos si no existe
mkdir -p /data

# Iniciar Streamlit (escuchar en todas las interfaces para acceso desde la red)
exec python3 -m streamlit run /app/app.py \
    --server.port=8502 \
    --server.address=0.0.0.0 \
    --server.headless=true \
    --browser.gatherUsageStats=false
