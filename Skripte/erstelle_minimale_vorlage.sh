#!/usr/bin/env bash

# https://devhints.io/bash
set -euo pipefail
IFS=$'\n\t'

# Ein simples Skript, um die minimale Vorlage zu erstellen.
# Kopiert wichtige Inhalte und löscht nicht benötigtes raus.

SKRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
PROJECT_ROOT="${SKRIPT_DIR}/.."

echo "Erstelle minimale Vorlage"

# Lösche die evtl. bereits existierende minimale Vorlage
rm -rf "${PROJECT_ROOT}/Vorlage_Minimal"

mkdir -p "${PROJECT_ROOT}/Vorlage_Minimal/Bilder"
mkdir -p "${PROJECT_ROOT}/Vorlage_Minimal/Quellcode"
mkdir -p "${PROJECT_ROOT}/Vorlage_Minimal/Inhalt/03_Verzeichnisse/"
mkdir -p "${PROJECT_ROOT}/Vorlage_Minimal/Inhalt/04_Inhalt"

# Kopiere wichtige Bilder (Titelseite)
cp -R "${PROJECT_ROOT}/Vorlage/Bilder/Logos" "${PROJECT_ROOT}/Vorlage_Minimal/Bilder/Logos"

# Kopiere die "minimierte" Praxisvorlage
grep -v \
	-e "04_Inhalt" \
	-e "formelgroessen" \
	-e "Inhalt/Quellcode" \
	"${PROJECT_ROOT}/Vorlage/Praxisbericht.tex" > "${PROJECT_ROOT}/Vorlage_Minimal/Praxisbericht.tex"

# Kopiere Verzeichnisse mit "must have" Inhalten
cp -R "${PROJECT_ROOT}/Vorlage/Inhalt/00_Latex" "${PROJECT_ROOT}/Vorlage_Minimal/Inhalt/"
cp -R "${PROJECT_ROOT}/Vorlage/Inhalt/01_Standard" "${PROJECT_ROOT}/Vorlage_Minimal/Inhalt/"
cp -R "${PROJECT_ROOT}/Vorlage/Inhalt/02_Abstract" "${PROJECT_ROOT}/Vorlage_Minimal/Inhalt/"

# Abkürzungen kopieren. Dabei alles rauslöschen bis auf ein \acro (das mit W startet)
grep -v -e "acro{[^W]" "${PROJECT_ROOT}/Vorlage/Inhalt/03_Verzeichnisse/abkuerzungen.tex" > \
	"${PROJECT_ROOT}/Vorlage_Minimal/Inhalt/03_Verzeichnisse/abkuerzungen.tex"

# Fülle Beispiel-Dateien mit minimalem Text
echo "% Hier dein Text" 1> "${PROJECT_ROOT}/Vorlage_Minimal/Inhalt/04_Inhalt/Inhalt.tex"
echo "% Hier deine Quellen. Citavi empfiehlt sich." 1> "${PROJECT_ROOT}/Vorlage_Minimal/Inhalt/literatur.bib"

echo "Fertig!"
