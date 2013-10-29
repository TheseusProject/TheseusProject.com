rem build.bat


git checkout gh-pages


if %errorlevel% neq 0 exit /b %errorlevel%


REM ATTRIB +H ./output/
REM FOR /D %%i IN (".\*") DO RD /S /Q "%%i" DEL /Q ".\*.*"
REM ATTRIB -H ./output/

REM robocopy ./output/ . /E

REM RD ./output