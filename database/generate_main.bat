@echo off
SET "DB_DIR=%~dp0"
SET "MAIN_FILE=%DB_DIR%main.sql"

echo -- Archivo principal de la base de datos > "%MAIN_FILE%"

:: Agregar contenido de tables.sql
echo. >> "%MAIN_FILE%"
echo -- Tablas >> "%MAIN_FILE%"
type "%DB_DIR%tables.sql" >> "%MAIN_FILE%"

:: Agregar contenido de todos los procedimientos almacenados
echo. >> "%MAIN_FILE%"
echo -- Procedimientos almacenados >> "%MAIN_FILE%"
for %%F in ("%DB_DIR%procedures\*.sql") do (
    type "%%F" >> "%MAIN_FILE%"
    echo. >> "%MAIN_FILE%"
)

:: Agregar contenido de todas las funciones
echo. >> "%MAIN_FILE%"
echo -- Funciones >> "%MAIN_FILE%"
for %%F in ("%DB_DIR%functions\*.sql") do (
    type "%%F" >> "%MAIN_FILE%"
    echo. >> "%MAIN_FILE%"
)

:: Agregar contenido de todas las vistas
echo. >> "%MAIN_FILE%"
echo -- Vistas >> "%MAIN_FILE%"
for %%F in ("%DB_DIR%views\*.sql") do (
    type "%%F" >> "%MAIN_FILE%"
    echo. >> "%MAIN_FILE%"
)

:: Agregar contenido de todos los triggers
echo. >> "%MAIN_FILE%"
echo -- Triggers >> "%MAIN_FILE%"
for %%F in ("%DB_DIR%triggers\*.sql") do (
    type "%%F" >> "%MAIN_FILE%"
    echo. >> "%MAIN_FILE%"
)

echo Archivo main.sql generado con éxito.
