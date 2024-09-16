#!/bin/bash

# Source environment variables from external file
ENV_FILE="./setup_ansible_env.sh"

if [ -f "$ENV_FILE" ]; then
    echo "Loading environment variables from $ENV_FILE..."
    source "$ENV_FILE"
else
    echo "Environment file $ENV_FILE not found. Please create it before running this script."
    exit 1
fi

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL $BREW_INSTALL_URL)"
    # Add Homebrew to the PATH
    if [ -f ~/.bash_profile ]; then
        PROFILE_FILE=~/.bash_profile
    elif [ -f ~/.zshrc ]; then
        PROFILE_FILE=~/.zshrc
    else
        PROFILE_FILE=~/.profile
    fi
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $PROFILE_FILE
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew is already installed."
fi

# Install Ansible using Homebrew
echo "Installing Ansible..."
brew install ansible

echo "Ansible installation complete."

# Create inventory file using environment variables
cat <<EOF > "$INVENTORY_FILE"
[docker_instance]
$DOCKER_INSTANCE_IP ansible_user=$ANSIBLE_USER ansible_ssh_pass=$ANSIBLE_PASSWORD ansible_connection=ssh
EOF

echo "Inventory file '$INVENTORY_FILE' has been created."

# Instructions to run the Ansible playbook
echo ""
echo "To run your Ansible playbook, follow these steps:"
echo "1. Save your playbook to a file named '$ANSIBLE_PLAYBOOK_FILE'."
echo "2. Run the playbook using the command:"
echo "   ansible-playbook -i $INVENTORY_FILE $ANSIBLE_PLAYBOOK_FILE"