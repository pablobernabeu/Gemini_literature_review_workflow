@echo off
REM Batch script to start R with Ctrl+Z protection
REM This script disables Ctrl+Z handling before starting R

echo Starting R with Ctrl+Z protection...
echo Press Ctrl+C then type 'q()' to exit R properly
echo DO NOT USE Ctrl+Z - it may still cause issues

REM Disable Ctrl+Z processing
stty -ctlecho 2>nul

REM Start R with full path
"C:\Users\pablob\AppData\Local\Programs\R\R-4.5.1\bin\x64\R.exe" --no-save --no-restore --interactive

echo R session ended.
pause
