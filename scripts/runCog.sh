#!/bin/bash
# Get the directory of the script
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

cd "$script_dir/.."

# Check if .venv exists
if [ ! -d ".venv" ]; then
    # On Ubuntu, ensure python3-venv is installed if this fails

    python3 -m venv .venv || { echo "Error: python3-venv is required. Install it with: sudo apt update && sudo apt install python3-venv"; exit 1; }
    
    source .venv/bin/activate
    pip install --upgrade pip
    pip install cogapp Jinja2
else
    source .venv/bin/activate
fi

cd "$script_dir/.."
cd Bal
cog -r BrewDataPrivate.h BrewDataPrivate.cpp

cd "$script_dir/.."
cog -r CMakeLists.txt
