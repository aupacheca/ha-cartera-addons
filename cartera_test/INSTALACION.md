# Instalación de Cartera TEST (versión de prueba)

Guía paso a paso para instalar la versión de prueba del addon en Home Assistant OS. Usa puerto **8502** y base de datos **acciones_test.db** para no interferir con la versión real.

---

## Tu estructura de carpetas (Samba)

En tu Home Assistant, las carpetas compartidas aparecen al mismo nivel:

| Carpeta | Uso |
|---------|-----|
| **config** | Configuración de Home Assistant |
| **addon_configs** | Datos persistentes de addons (aquí va la BD) |
| **addons** | Código de addons locales |
| backup, media, share, ssl | Otros usos |

---

## Paso 1: Copiar los archivos del addon

### Por Samba

1. Abre el explorador de Windows y escribe:
   ```
   \\192.168.1.68\addons
   ```
   (o `\\homeassistant.local\addons` si lo tienes configurado)

2. Crea la carpeta **cartera_test** si no existe.

3. Copia **todos** estos archivos de la carpeta `cartera-test` del proyecto a `addons\cartera_test\`:

   | Archivo | Descripción |
   |---------|-------------|
   | `config.yaml` | Configuración del addon |
   | `build.yaml` | Imágenes base por arquitectura |
   | `Dockerfile` | Definición de la imagen |
   | `run.sh` | Script de arranque |
   | `app.py` | Aplicación principal |
   | `requirements.txt` | Dependencias Python |

4. Ruta final: `\\192.168.1.68\addons\cartera_test\` con los 6 archivos dentro.

### Por SSH (alternativa)

```bash
# Crear carpeta
mkdir -p /addons/cartera_test
cd /addons/cartera_test

# Copiar archivos (desde tu PC, usa scp o pega el contenido)
# scp config.yaml build.yaml Dockerfile run.sh app.py requirements.txt root@192.168.1.68:/addons/cartera_test/
```

---

## Paso 2: Registrar el addon en Home Assistant

1. Ve a **Configuración** → **Sistema** → **Supervisor**.
2. Haz clic en **Reiniciar** en el Supervisor (o reinicia Home Assistant).
3. Ve a **Complementos** → **Add-ons**.
4. Busca **"Cartera TEST"** en la lista. Debería aparecer si la carpeta está en `/addons/cartera_test/`.

> **Nota:** Si no aparece, verifica que los 6 archivos estén en `addons\cartera_test\` y que `config.yaml` sea válido. Reinicia el Supervisor de nuevo.

---

## Paso 3: Instalar el addon

1. Haz clic en **Cartera TEST**.
2. Clic en **Instalar**.
3. Espera a que termine la descarga y construcción de la imagen.

---

## Paso 4: Copiar la base de datos (opcional)

Si ya tienes un `acciones.db` o `acciones_test.db` que quieres usar:

1. **Detén** el addon si está en marcha.
2. Abre por Samba:
   ```
   \\192.168.1.68\addon_configs
   ```
3. Entra en la carpeta **cartera_test** (se crea al iniciar el addon la primera vez).
4. Copia tu archivo `acciones_test.db` dentro de esa carpeta.
   - Si tienes `acciones.db`, renómbralo a `acciones_test.db` antes de copiarlo.
5. Ruta final: `\\192.168.1.68\addon_configs\cartera_test\acciones_test.db`

> **Si no existe la carpeta cartera_test:** Inicia el addon una vez, deténlo, y vuelve a buscar. Home Assistant la crea al arrancar.

---

## Paso 5: Iniciar el addon

1. En **Complementos** → **Cartera TEST**, haz clic en **Iniciar**.
2. Activa **Iniciar al arrancar** si quieres que se inicie con Home Assistant.

---

## Paso 6: Acceder a la aplicación

- **URL directa:** `http://192.168.1.68:8502`
- **O:** `http://homeassistant.local:8502`

### Añadir al panel de Home Assistant

1. Edita tu Panel y añade una tarjeta **iframe** o **enlace**.
2. URL: `http://192.168.1.68:8502` (o `http://localhost:8502` si estás en el mismo host).

> Si usas HTTPS en HA, el iframe puede bloquearse. Usa un **enlace** que abra en nueva pestaña.

---

## Resumen de diferencias con la versión real

| | Cartera Inversiones (real) | Cartera TEST |
|---|---------------------------|--------------|
| Puerto | 8501 | **8502** |
| Base de datos | acciones.db | **acciones_test.db** |
| Slug | cartera_inversiones | cartera_test |
| Carpeta addon | addons/cartera_inversiones | addons/cartera_test |
| Carpeta datos | addon_configs/cartera_inversiones | addon_configs/cartera_test |

---

## Resolución de problemas

| Problema | Solución |
|----------|----------|
| El addon no aparece | Comprueba que los 6 archivos estén en `addons\cartera_test\`. Reinicia el Supervisor. |
| Error al instalar | Revisa los logs. En Raspberry Pi 4 usa arquitectura `aarch64`. |
| No se guardan los datos | Verifica que la carpeta `addon_configs\cartera_test` exista y que el addon tenga permisos. |
| Puerto 8502 en uso | Cambia el puerto en `config.yaml` (ej. 8503) y en `run.sh`. |
| No encuentro addon_configs | En algunas instalaciones la carpeta de datos está en `config\addon_data\cartera_test`. Prueba ambas rutas. |

---

## Actualizar el addon

1. Sustituye los archivos en `addons\cartera_test\` por las nuevas versiones.
2. En **Complementos** → **Cartera TEST** → **Reconstruir**.
3. Tus datos en `addon_configs\cartera_test\` se conservan.
