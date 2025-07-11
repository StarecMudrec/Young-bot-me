#!/bin/bash


python -m venv env
source env/Scripts/activate
pip install -r app/data/sys/req.txt

read -p "Press any key..."
