build.bat

git checkout gh-pages

ATTRIB +H ./output/
FOR /D %%i IN (".\*") DO RD /S /Q "%%i" DEL /Q ".\*.*"
ATTRIB -H ./output/

robocopy ./output/ . /E

RD ./output