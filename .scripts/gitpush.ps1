# gitpush.ps1 - PitayaCore (Fuente de Verdad + Sync Local INSTANTÁNEO)
# Script para actualizar el núcleo y sincronizar LOCALMENTE de forma inmediata.

Write-Host "Iniciando Push en PitayaCore (Fuente de Verdad)..." -ForegroundColor Cyan

# 1. Paso: Actualizar PitayaCore en GitHub
git add .
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
git commit -m "chore(core): update core files $timestamp"
Write-Host "Sincronizando con GitHub..." -ForegroundColor Yellow
git pull origin main --rebase
git push origin main
Write-Host "[OK] PitayaCore actualizado en la nube." -ForegroundColor Green

# 2. Paso: Sincronización Local INSTANTÁNEA
# Copiamos directamente de la carpeta de PitayaCore a los subdominios locales
Write-Host "`nSincronizando copias locales (Mirroring)..." -ForegroundColor Cyan

$carpetas = @("core", "docs", ".agent")
$subdominios = @(
    "..\api.batidospitaya.com",
    "..\erp.batidospitaya.com",
    "..\talento.batidospitaya.com"
)

foreach ($repo in $subdominios) {
    if (Test-Path $repo) {
        Write-Host "Copiando a $repo..." -ForegroundColor Yellow
        foreach ($carpeta in $carpetas) {
            $origen = "..$([IO.Path]::DirectorySeparatorChar)PitayaCore$([IO.Path]::DirectorySeparatorChar)$carpeta"
            $destino = "$repo$([IO.Path]::DirectorySeparatorChar)$carpeta"
            
            # robocopy /MIR mantiene las carpetas idénticas (espejo)
            # /R:0 /W:0 evita reintentos si un archivo está bloqueado
            if (Test-Path $origen) {
                robocopy $origen $destino /MIR /NJH /NJS /NDL /NC /NS /NP /R:0 /W:0 | Out-Null
            }
        }
    }
}

Write-Host "`n[OK] Sincronización local completada al instante." -ForegroundColor Green
