# gitpush.ps1 - PitayaCore
# Script para hacer commit y push rápido con timestamp para la fuente de verdad (PitayaCore)

Write-Host "Iniciando Push en PitayaCore (Fuente de Verdad)..." -ForegroundColor Cyan

# Agregar cambios
git add .

# Commit con fecha y hora actual
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
git commit -m "chore(core): update core files $timestamp"

# Pull previo por si hubo cambios desde subdominios
Write-Host "Sincronizando con cambios remotos..." -ForegroundColor Yellow
git pull origin main --rebase

# Push a GitHub (disparará sync-to-subdomains.yml)
git push origin main

Write-Host "[OK] PitayaCore actualizado y sincronización disparada!" -ForegroundColor Green
