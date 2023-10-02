@echo off

SET COMPILER="E:\Programs\bin\cfencode.exe"

SET PH=%~dp0..
SET BLD=%PH%\build
SET PRJ=%BLD%\link-to-project

del /s /q %PRJ%\*
call %COMPILER% %PH%\*.html %PRJ%\*.cfm /v 2

for %%d in (fonts image script style) do (
    for %%f in ("%%d\*") do (
        copy "%%f" "%PRJ%/%%d"
    )
)

for %%f in ("*.cfc" "*.css" "*.md") do (
    copy "%%f" "%PRJ%\"
)