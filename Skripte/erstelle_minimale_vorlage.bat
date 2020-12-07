@ECHO OFF
REM A simple script to create the minimal Vorlage.
REM Copies important Inhalt and deletes unnecessary files.

SET SKRIPT_DIR=%~dp0
SET PROJECT_ROOT=%SKRIPT_DIR%..

ECHO Erstelle die minimale Vorlage

REM Delete any existing minimum Vorlage
DEL /F /S /Q %PROJECT_ROOT%\Vorlage_Minimal
RD /S /Q %PROJECT_ROOT%\Vorlage_Minimal

MD %PROJECT_ROOT%\Vorlage_Minimal\Bilder
MD %PROJECT_ROOT%\Vorlage_Minimal\Bilder\Logos
MD %PROJECT_ROOT%\Vorlage_Minimal\Quellcode
MD %PROJECT_ROOT%\Vorlage_Minimal\Inhalt\00_Latex\
MD %PROJECT_ROOT%\Vorlage_Minimal\Inhalt\01_Standard\
MD %PROJECT_ROOT%\Vorlage_Minimal\Inhalt\02_Abstract\
MD %PROJECT_ROOT%\Vorlage_Minimal\Inhalt\03_Verzeichnisse
MD %PROJECT_ROOT%\Vorlage_Minimal\Inhalt\04_Inhalt

REM Copy Important Bilder (Title Page)
COPY /Y %PROJECT_ROOT%\Vorlage\Bilder\Logos\* %PROJECT_ROOT%\Vorlage_Minimal\Bilder\Logos\

REM Copy minimized Vorlage
FINDSTR /V /R "(04_Inhalt|formelgroessen|Inhalt\\Quellcode)" %PROJECT_ROOT%\Vorlage\Praxisbericht.tex > %PROJECT_ROOT%\Vorlage_Minimal\Praxisbericht.tex

REM Copy "must have" Inhalt
COPY %PROJECT_ROOT%\Vorlage\Inhalt\00_latex\* %PROJECT_ROOT%\Vorlage_Minimal\Inhalt\00_latex\
COPY %PROJECT_ROOT%\Vorlage\Inhalt\01_standard\* %PROJECT_ROOT%\Vorlage_Minimal\Inhalt\01_standard\
COPY %PROJECT_ROOT%\Vorlage\Inhalt\02_abstract\* %PROJECT_ROOT%\Vorlage_Minimal\Inhalt\02_abstract\

REM Copy abbreviations. Deselect all, except for one \acro (which starts with W)
FINDSTR /V /R "acro{[^W]" %PROJECT_ROOT%\Vorlage\Inhalt\03_Verzeichnisse\abkuerzungen.tex > %PROJECT_ROOT%\Vorlage_Minimal\Inhalt\03_Verzeichnisse\abkuerzungen.tex

REM Fill sample files with minimum text
ECHO %% Hier ist dein Text 1> %PROJECT_ROOT%\Vorlage_Minimal\Inhalt\04_Inhalt\Inhalt.tex
ECHO %% Hier ist dein Literaturverzeichnis. Es wird Citavi empfohlen. 1> %PROJECT_ROOT%\Vorlage_Minimal\Inhalt\literatur.bib

ECHO Fertig!
PAUSE