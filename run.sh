#!/bin/bash

source env/Scripts/activate
mkdir -p app/data/logs
python -m app.scripts.main -name YoungMouse

read -p "Press any key..."
