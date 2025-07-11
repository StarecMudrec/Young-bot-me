#!/bin/bash

# Check if python is available
if ! command -v python &>/dev/null; then
    echo "Python is not installed or not in PATH"
    echo "Please install Python from https://www.python.org/downloads/"
    echo "And make sure to check 'Add Python to PATH' during installation"
    sleep 5
    exit 1
fi

# First ensure pip is available
echo "Making sure pip is available..."
python -m ensurepip --upgrade || {
    echo "Failed to set up pip"
    echo "Try manually running: python -m ensurepip --upgrade"
    sleep 5
    exit 1
}

# Create virtual environment
echo "Creating virtual environment..."
python -m venv env || {
    echo "Failed to create virtual environment"
    echo "Trying alternative approach..."
    python -m venv --without-pip env && {
        echo "Created venv without pip, now bootstrapping pip..."
        source env/Scripts/activate
        curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
        python get-pip.py
        rm get-pip.py
    } || {
        echo "Completely failed to create virtual environment"
        sleep 5
        exit 1
    }
}

# Activate virtual environment
echo "Activating virtual environment..."
source env/Scripts/activate || {
    echo "Failed to activate virtual environment"
    sleep 5
    exit 1
}

# Install requirements if requirements file exists
if [ -f "app/data/sys/req.txt" ]; then
    echo "Installing requirements..."
    pip install -r app/data/sys/req.txt || {
        echo "Failed to install some requirements"
        sleep 3
    }
else
    echo "Requirements file not found at app/data/sys/req.txt"
    sleep 2
fi

echo "Setup completed successfully!"
read -p "Press any key to continue..."