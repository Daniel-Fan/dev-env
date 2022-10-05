# DEV-ENV

## Configuration on local machine

### Configuring key based authentication to your remote machine
Reference: https://code.visualstudio.com/docs/remote/troubleshooting#_quick-start-using-ssh-keys

#### 1. Create your local SSH key pair
**NOTE:** Check to see if you already have an SSH key on your local machine.

This is typically located at `~/.ssh/id_ed25519.pub` on macOS / Linux, and the `.ssh` directory in your user profile folder on Windows (for example `C:\Users\your-user\.ssh\id_ed25519.pub`).

If you do not have a key, run the following command in a local terminal / PowerShell to generate an SSH key pair:

```
ssh-keygen -t rsa -b 4096
```

#### 2. Authorize your macOS or Linux machine to connect

Run one of the following commands, replacing `user` and `hostname` as appropriate to copy your local public key to the SSH host.

- Connecting to a macOS or Linux SSH host:

    ```
    export USER_AT_HOST="your-user-name-on-host@hostname"
    export PUBKEYPATH="$HOME/.ssh/id_ed25519.pub"

    ssh-copy-id -i "$PUBKEYPATH" "$USER_AT_HOST"
    ```

- Connecting to a Windows SSH host:

    ```
    export USER_AT_HOST="your-user-name-on-host@hostname"
    export PUBKEYPATH="$HOME/.ssh/id_ed25519.pub"

    ssh $USER_AT_HOST "powershell New-Item -Force -ItemType Directory -Path \"\$HOME\\.ssh\"; Add-Content -Force -Path \"\$HOME\\.ssh\\authorized_keys\" -Value '$(tr -d '\n\r' < "$PUBKEYPATH")'"
    ```

## Configuration on remote host

### Prerequisite
1. In your terminal window or VScode window, connect to your remote host through `ssh`
2. Have `python3` installed in cluster, it is default for Linux system. To check if `python3` is installed.
    ```
    python3 -V
    ```

### Set up initial tool

1. Install `git` tool, run one of the following command based on your system
    - System Debian/Ubuntu/Mint
        ```
        sudo apt-get install git
        ```
    - System Fedora
        ```
        su -c 'yum install git'
        ```
    - System openSUSE
        ```
        sudo zypper in git
        ```

2. Clone this directory and navigate to the folder
    ```
    git clone https://github.com/Daniel-Fan/dev-env.git
    cd dev-env
    ```

3. Run the initial setup script to install `pip` and `ansible` under the `dev-env` folder
    ```
    sudo init-setup.sh
    ```

### Fill up the host file

Open `inventory/hosts` file to fill up with host information

- `name-of-vm`: remote host alias
- `host-ip-address`: remote host ip address
- `shh-user`: host user which you are using, usually `root`
- `password`: password for login to the user on this host

### Run the ansible playbook
- Run the playbook as below

```
ansible-playbook -i inventory/hosts -K playbooks/dev-vm.yml
```
