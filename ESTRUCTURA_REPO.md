# Estructura del repositorio ha-cartera-addons

Para que Home Assistant reconozca el add-on, el repositorio debe tener esta estructura exacta:

```
ha-cartera-addons/
├── repository.yaml          ← Obligatorio: define el repo
├── README.md                ← Opcional
├── .gitattributes           ← Opcional
│
└── cartera_test/            ← Carpeta = slug del add-on (config.yaml)
    ├── config.yaml         ← Obligatorio: nombre, descripción, slug, puertos
    ├── build.yaml          ← Obligatorio: imágenes base por arquitectura
    ├── Dockerfile          ← Obligatorio: cómo construir la imagen
    ├── run.sh              ← Obligatorio: script de arranque
    ├── app.py              ← Obligatorio: aplicación Streamlit
    ├── requirements.txt    ← Obligatorio: dependencias Python
    └── INSTALACION.md      ← Opcional: documentación
```

---

## Reglas importantes

1. **`repository.yaml`** debe estar en la **raíz** del repo.
2. La **carpeta del add-on** (`cartera_test`) debe llamarse igual que el **slug** en `config.yaml`.
3. No uses una carpeta `addons/` intermedia: el add-on va directo en la raíz.

---

## Contenido mínimo de cada archivo

### repository.yaml (raíz)
```yaml
name: Cartera Filios - Add-ons
url: https://github.com/aupacheca/ha-cartera-addons
maintainer: aupacheca <aupacheca@gmail.com>
```

### cartera_test/config.yaml
```yaml
name: Cartera TEST
slug: cartera_test
description: Aplicación de cartera de inversiones...
version: "1.0.0"
arch: [aarch64, armv7, armhf, amd64, i386]
ports:
  "8502/tcp": 8502
# ... resto de config
```

---

## Cómo subir a GitHub

1. Crea el repo `ha-cartera-addons` en GitHub (si no existe).
2. Copia todo el contenido de la carpeta `ha-addons-repo` local.
3. La raíz del repo en GitHub debe tener `repository.yaml` y la carpeta `cartera_test`.
4. Haz commit y push.

---

## Verificación

Tras subir, en Home Assistant:
- **Configuración** → **Complementos** → **Repositorios**
- Añade: `https://github.com/aupacheca/ha-cartera-addons`
- Debería aparecer **Cartera TEST** en la lista de add-ons.
