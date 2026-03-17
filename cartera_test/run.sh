#!/bin/sh
# Script de inicio para Cartera TEST (Add-on Home Assistant - versión de prueba)
# addon_config:rw monta la carpeta del add-on en /config (accesible por Samba: addon_configs)
# share:rw monta /share (accesible por Samba). Puedes elegir la ruta en Configuración del add-on.

# Leer ruta de datos (prioridad: /data/data_path_override.txt > /config/data_path.txt > options.json > por defecto)
# Plan B: si la UI de HA no muestra data_path, configúralo desde la app (Mantenimiento > Ruta de datos)
if [ -f /data/data_path_override.txt ]; then
    DATA_DIR=$(cat /data/data_path_override.txt | head -1 | tr -d '\r\n' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
elif [ -f /config/data_path.txt ]; then
    DATA_DIR=$(cat /config/data_path.txt | head -1 | tr -d '\r\n' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
fi
if [ -z "$DATA_DIR" ] && [ -f /data/options.json ]; then
    DATA_DIR=$(python3 -c "import json; d=json.load(open('/data/options.json')); p=(d.get('data_path') or '/config').strip(); print(p or '/config')" 2>/dev/null)
fi
DATA_DIR=${DATA_DIR:-/share/cartera_test}

export DATA_DIR
export DB_FILENAME=acciones_test.db

# Crear directorio si no existe
mkdir -p "$DATA_DIR"

# Migración: si hay BD antigua en /data y no en DATA_DIR, copiarla
if [ -f /data/acciones_test.db ] && [ ! -f "$DATA_DIR/acciones_test.db" ]; then
    cp -a /data/acciones_test.db "$DATA_DIR/" 2>/dev/null || true
    [ -f "$DATA_DIR/acciones_test.db" ] && echo "Migrada BD de /data a $DATA_DIR"
fi

# Migración: si hay BD antigua en /config y DATA_DIR es distinto, copiarla
if [ "$DATA_DIR" != "/config" ] && [ -f /config/acciones_test.db ] && [ ! -f "$DATA_DIR/acciones_test.db" ]; then
    cp -a /config/acciones_test.db "$DATA_DIR/" 2>/dev/null || true
    [ -f "$DATA_DIR/acciones_test.db" ] && echo "Migrada BD de /config a $DATA_DIR"
fi

echo "Datos en: $DATA_DIR - En Samba busca: share/cartera_test"

# Iniciar Streamlit (escuchar en todas las interfaces para acceso desde la red)
exec python3 -m streamlit run /app/app.py \
    --server.port=8502 \
    --server.address=0.0.0.0 \
    --server.headless=true \
    --browser.gatherUsageStats=false
