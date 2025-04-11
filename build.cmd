@echo off
setlocal
set BUILD_TARGET=%~1
if "%BUILD_TARGET%"=="" set /p BUILD_TARGET="Build Target: "
if not "%BUILD_TARGET%"=="" set BUILD_TARGET="/target:%BUILD_TARGET%"

:: Detecta automaticamente o MSBuild do VS2022
for /f "tokens=*" %%a in ('where /r "C:\Program Files\Microsoft Visual Studio\2022" MSBuild.exe ^| findstr "Current\Bin"') do (
    set MSBUILD="%%a"
    goto :found_msbuild
)

echo Não foi possível encontrar o MSBuild do VS2022. Verificando caminhos comuns...

:: Caminhos de fallback
if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" (
    set MSBUILD="C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
    goto :found_msbuild
)
if exist "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe" (
    set MSBUILD="C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe"
    goto :found_msbuild
)
if exist "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe" (
    set MSBUILD="C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe"
    goto :found_msbuild
)

echo ERRO: MSBuild do VS2022 não encontrado.
exit /b 1

:found_msbuild
echo Usando MSBuild: %MSBUILD%
%MSBUILD% build.xml %BUILD_TARGET% /p:ToolsVersion=Current /p:VisualStudioVersion=17.0 %2 %3 %4 %5 %6 %7 %8 %9
endlocal
if errorlevel 1 pause
