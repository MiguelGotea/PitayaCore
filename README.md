# PitayaCore — Sistema de Sincronización de Hierro (Iron Sync v3)

Este repositorio actúa como la **"Fuente de Verdad" (Source of Truth)** definitiva para todos los componentes compartidos del ecosistema Pitaya (API, ERP, Talento).

## 🛡️ Arquitectura Iron Sync v3

El sistema ha sido evolucionado hacia un modelo de **Alta Estabilidad y Descentralización**, diseñado para eliminar inconsistencias, retrasos de propagación y colisiones de archivos.

### Componentes Sincronizados:
- `/core`: Lógica de negocio, controladores PDO, y librerías globales.
- `/docs`: Estándares de desarrollo, esquemas de BD y manuales.
- `/.agent`: Inteligencia y Skills para los agentes de programación.

### Pilares de Estabilidad:
1. **Iron Sync (Manual Clone)**: Las acciones no usan caché; descargan una copia limpia de `PitayaCore` y validan el SHA para asegurar que el código sea exactamente el que acabas de subir.
2. **Cola de Seguridad (Concurrency)**: GitHub encola las actualizaciones. Si haces varios pushes rápidos, se procesan uno por uno en orden, evitando que se "pisen" entre sí.
3. **Validación Flexible**: El sistema detecta si la versión en la nube ya es más reciente que la solicitada y permite que la sincronización avance sin errores.
4. **Escudo de Credenciales**: Validación automática de secretos de Hostinger (`HOSTINGER_PATH`, etc.) con soporte para nombres personalizados (`HOSTINGER_PATH_API`, etc.).

---

## 🚀 Flujo de Trabajo (Desarrollo AI/Humano)

### 1. Desarrollo en el Núcleo
Todo cambio global debe realizarse en este repositorio (`PitayaCore`). Para desplegar los cambios a toda la red:
```powershell
# Desde PitayaCore/
.\.scripts\gitpush.ps1
```
*Esto dispara el envío masivo a los repositorios remotos de la API, ERP y Talento.*

### 2. Sincronización Local
Para que tus cambios en `PitayaCore` se reflejen en tus carpetas locales de trabajo en `VisualCode/`, utiliza la herramienta unificada:
```powershell
# Desde la raíz de VisualCode/
.\gitsync-local.ps1
```
*Este script actualiza quirúrgicamente las carpetas `/core`, `/docs` y `/.agent` de todos tus repositorios locales.*

---

## 💻 Agregar un nuevo Subdominio

Para integrar un nuevo repositorio al ecosistema:

1. **GitHub Secrets**: Configura `SYNC_TOKEN` y las credenciales de Hostinger (`HOSTINGER_HOST`, `HOSTINGER_USER`, `HOSTINGER_SSH_KEY` y `HOSTINGER_PATH`). El sistema soporta el sufijo del subdominio en el path (ej: `HOSTINGER_PATH_TIENDA`).
2. **Workflow de Recepción**: Copia el archivo `.github/workflows/receive-core-sync.yml` de cualquier subdominio al nuevo repositorio.
3. **Registro en PitayaCore**: Agrega el nombre del repo a la lista `matrix` en `.github/workflows/sync-to-subdomains.yml` de este repositorio.

---

## 🛠️ Herramientas Locales
- `PitayaCore/.scripts/gitpush.ps1`: El disparador global.
- `VisualCode/gitsync-local.ps1`: El sincronizador local de alta precisión.

**Nota**: Se ha eliminado el uso de `robocopy` y scripts centralizados forzados para garantizar que el desarrollador nunca pierda trabajo local por sobrescrituras accidentales.
