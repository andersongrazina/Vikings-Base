@echo off
@title Auto Restart CMD - Para Bases FIVEM - Nego2K
cls
color 0c
:start

timeout /t 2 >null

rd /s /q cache 
echo -- Cache foi deletada com sucesso...
echo ... %time% - Espere um Instante...

rd /s /q crashes
echo -- Pasta crashes foi deletada com sucesso...
echo ... %time% - Espere um Instante...

rd /s /q SavedVehicles
echo -- Pasta de Veiculos foi deletada com sucesso...
echo ... %time% - Espere um Instante...

timeout /t 3 >null

start "Server" C:\FXServer\run.cmd +exec server.cfg
echo ... %time% - Iniciando servidor...

timeout /t 2 >null
echo ... %time% - Carregando resources...

timeout /t 8 >null
echo ... %time% - Servidor rodara por 6 horas...

timeout /t 14400 >null
echo ... %time% - 4 horas se passaram. Faltam 2 hora para reiniciar.

timeout /t 3600 >null
echo ... %time% - 5 horas se passaram. Falta 1 hora para reiniciar.

timeout /t 1800 >null
echo ... %time% - Falta 30 minutos para reiniciar.

timeout /t 1200 >null
echo ... %time% - Falta 10 minutos para reiniciar.

timeout /t 300 >null
echo ... %time% - Falta 5 minutos para reiniciar.

timeout /t 300 >null
echo ... %time% - Servidor esta reiniciando.

timeout /t 2 >null

taskkill /f /fi "WindowTitle eq Server*"
taskkill /f /im FXServer.exe >nul

timeout /t 1 >null
goto start