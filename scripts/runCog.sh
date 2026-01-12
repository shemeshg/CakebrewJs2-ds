#!/bin/zsh
script_dir=$(dirname $(realpath "$0"))

cd "$script_dir/.."
if [ ! -d ".venv" ]; then
    python3 -m venv .venv
    source .venv/bin/activate
    pip install cogapp
    pip install Jinja2
else
    source .venv/bin/activate
fi

cd "$script_dir/.."
cd Bal
cog -r BrewDataPrivate.h BrewDataPrivate.cpp

cd "$script_dir/.."
cog -r CMakeLists.txt
