# NixOS Hyprland Configuration

This repository contains a complete, flake-based NixOS configuration for a Hyprland desktop environment. It is designed to be minimal, stable, and easily reproducible.

## Features

*   **Window Manager**: Hyprland (with XWayland support)
*   **Display Manager**: `greetd` with `tuigreet` (lightweight and secure)
*   **Bar**: Waybar
*   **Launcher**: Rofi
*   **Notifications**: SwayNC
*   **Terminal**: Wezterm
*   **Editor**: Neovim (with pre-configured plugins)
*   **Shell**: Bash with a managed `tmux` environment

## Installation Guide

Follow these steps to perform a fresh installation of NixOS using this configuration.

### Step 1: Create a Bootable USB

1.  **Download the NixOS Minimal ISO.**
    *   Go to the [NixOS downloads page](https://nixos.org/download.html) and download the "Minimal Installation Image" for the latest stable release (e.g., 24.05 or 25.05).

2.  **Write the ISO to a USB drive.**
    *   First, identify your USB drive's device name (`/dev/sdX`) using `lsblk`.
    *   Use the `dd` command to create the bootable drive.

    ```bash
    # WARNING: This will completely erase the target device.
    # Replace /dev/sdX with your actual USB device name.
    sudo dd if=~/Downloads/nixos-minimal-....iso of=/dev/sdX bs=4M status=progress oflag=sync
    ```

### Step 2: Boot and Connect to the Internet

1.  **Boot from the USB drive** you just created. You will land in a command-line interface.

2.  **Connect to your Wi-Fi network.**

    ```bash
    # Start the interactive tool
    iwctl

    # Find your device name (usually wlan0)
    [iwd]# device list

    # Scan for networks
    [iwd]# station wlan0 scan

    # List available networks
    [iwd]# station wlan0 get-networks

    # Connect to your network (use quotes if the name has spaces)
    [iwd]# station wlan0 connect "Your WiFi SSID"

    # Enter your password when prompted, then exit
    [iwd]# exit
    ```

3.  **Verify the connection.**

    ```bash
    ping nixos.org
    ```
    Press `Ctrl+C` to stop.

### Step 3: Partition and Format Drives

This guide assumes a standard UEFI system.

1.  **Partition your drive** (e.g., `/dev/sda`).

    ```bash
    sudo parted /dev/sda -- mklabel gpt
    sudo parted /dev/sda -- mkpart ESP fat32 1MB 512MB
    sudo parted /dev/sda -- set 1 esp on
    sudo parted /dev/sda -- mkpart primary ext4 512MB 100%
    ```

2.  **Format the partitions.**

    ```bash
    sudo mkfs.fat -F 32 -n boot /dev/sda1
    sudo mkfs.ext4 -L nixos /dev/sda2
    ```

3.  **Mount the filesystems.**

    ```bash
    sudo mount /dev/disk/by-label/nixos /mnt
    sudo mkdir -p /mnt/boot
    sudo mount /dev/disk/by-label/boot /mnt/boot
    ```

### Step 4: Install NixOS from this Repository

1.  **Install Git.**

    ```bash
    nix-shell -p git
    ```

2.  **Clone this repository.**

    ```bash
    # Replace <your-repo-url> with the URL of your repository
    git clone <your-repo-url> /mnt/etc/nixos
    ```

3.  **Generate the hardware configuration.**

    ```bash
    # This command creates a file at /mnt/etc/nixos/hardware-configuration.nix
    nixos-generate-config --root /mnt

    # Move it into the correct directory within our cloned repo structure
    mv /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/nixos/
    ```

4.  **Run the installation.**
    The `#nixos` at the end points to the configuration defined in `flake.nix`.

    ```bash
    nixos-install --flake /mnt/etc/nixos#nixos
    ```

### Step 5: First Boot and Final Setup

1.  **Reboot the system.**

    ```bash
    reboot
    ```
    Remove the installation USB when prompted.

2.  **Log in.**
    *   At the text-based login prompt, enter the username `h3cth0r`.
    *   You will be logged directly into the Hyprland desktop.

3.  **Set your password.**
    *   Open a terminal by pressing `Super + Q`.
    *   Run the `passwd` command and follow the prompts to set a password for your user.

    ```bash
    passwd
    ```

Your system is now ready to use!

## Post-Installation

To modify your system configuration:
1.  Navigate to your configuration directory: `cd /etc/nixos/`
2.  Edit the desired files.
3.  Apply the changes by running: `sudo nixos-rebuild switch --flake .#nixos`
