#bash

# install pip
python3 get-pip.py

# Ensuring pip is availab
python3 -m pip -V

# install ansible
python3 -m pip install --user ansible

# add ansible to PATH
export PATH="$PATH:~/.local/bin"