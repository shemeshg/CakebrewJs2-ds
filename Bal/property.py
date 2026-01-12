import sys
import os
from typing import Optional

def find_scripts_folder(start_path: str) -> str:
    current_path: str = start_path
    while True:
        scripts_path: str = os.path.join(current_path, 'scripts')
        if os.path.isdir(scripts_path):
            return scripts_path
        parent_path: str = os.path.dirname(current_path)
        if parent_path == current_path:
            raise FileNotFoundError("scripts folder not found")
        current_path = parent_path

# Get the directory of the current script
script_dir: str = os.path.dirname(os.path.realpath(__file__))

# Find the scripts folder
scripts_folder: str = find_scripts_folder(script_dir)

# Add the scripts folder to sys.path
sys.path.append(scripts_folder)

# Now you can import modules from the scripts folder
import property

# Now you can import your script
from propertyLib import *

