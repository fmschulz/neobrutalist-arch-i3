#!/bin/bash

# i3 Neobrutalist Configuration Installer
# This script sets up the complete i3 neobrutalist environment

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Header
echo -e "${BLUE}"
echo "╔══════════════════════════════════════════╗"
echo "║     i3 Neobrutalist Configuration        ║"
echo "║           Installer Script               ║"
echo "╚══════════════════════════════════════════╝"
echo -e "${NC}"

# Check if running on Arch Linux
if [ -f /etc/arch-release ]; then
    print_info "Detected Arch Linux"
else
    print_warning "This script is optimized for Arch Linux. Some packages might have different names on your distribution."
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Function to check if package is installed
is_installed() {
    pacman -Qi "$1" &> /dev/null
}

# Function to install packages
install_packages() {
    local packages=()
    
    print_info "Checking required packages..."
    
    # Core packages
    local core_packages=(
        "i3-gaps"
        "polybar"
        "alacritty"
        "rofi"
        "picom"
        "nitrogen"
        "ttf-jetbrains-mono"
        "otf-font-awesome"
        "dunst"
        "network-manager-applet"
        "blueman"
        "xorg-xsetroot"
        "redshift"
        "pulseaudio"
        "pavucontrol"
        "playerctl"
        "light"
        "maim"
        "xclip"
        "ranger"
    )
    
    # Recommended packages
    local recommended_packages=(
        "zathura"
        "zathura-pdf-poppler"
        "highlight"
        "w3m"
        "glow"
        "openssh"
        "github-cli"
        "firefox"
        "code"
        "docker"
        "docker-compose"
        "npm"
        "uv"
        "quarto"
    )
    
    # Optional packages
    local optional_packages=(
        "lightdm"
        "lightdm-webkit2-greeter"
        "tlp"
        "tlp-rdw"
        "powertop"
    )
    
    # Check core packages
    print_info "Checking core packages..."
    for pkg in "${core_packages[@]}"; do
        if ! is_installed "$pkg"; then
            packages+=("$pkg")
        else
            print_success "$pkg is already installed"
        fi
    done
    
    # Install missing core packages
    if [ ${#packages[@]} -gt 0 ]; then
        print_info "Installing missing core packages: ${packages[*]}"
        sudo pacman -S --noconfirm "${packages[@]}"
    else
        print_success "All core packages are already installed"
    fi
    
    # Ask about recommended packages
    print_info "Would you like to install recommended packages? (enhances the experience)"
    echo "Packages: ${recommended_packages[*]}"
    read -p "Install recommended packages? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        local rec_packages=()
        for pkg in "${recommended_packages[@]}"; do
            if ! is_installed "$pkg"; then
                rec_packages+=("$pkg")
            fi
        done
        if [ ${#rec_packages[@]} -gt 0 ]; then
            sudo pacman -S --noconfirm "${rec_packages[@]}"
        fi
    fi
    
    # Ask about optional packages
    print_info "Would you like to install optional packages?"
    echo "- LightDM: Graphical login manager"
    echo "- TLP: Power management for laptops"
    read -p "Install optional packages? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Check if it's a laptop
        if [ -d "/sys/class/power_supply/BAT0" ] || [ -d "/sys/class/power_supply/BAT1" ]; then
            print_info "Laptop detected. Installing power management tools..."
            local power_packages=()
            for pkg in "tlp" "tlp-rdw" "powertop"; do
                if ! is_installed "$pkg"; then
                    power_packages+=("$pkg")
                fi
            done
            if [ ${#power_packages[@]} -gt 0 ]; then
                sudo pacman -S --noconfirm "${power_packages[@]}"
                sudo systemctl enable tlp.service
            fi
        fi
        
        # LightDM
        read -p "Install LightDM display manager? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if ! is_installed "lightdm"; then
                sudo pacman -S --noconfirm lightdm lightdm-webkit2-greeter
                sudo systemctl enable lightdm.service
            fi
        fi
    fi
    
    # Check for AUR helper
    if command -v yay &> /dev/null; then
        print_info "Installing AUR packages..."
        local aur_packages=("libinput-gestures" "pixi-bin")
        local aur_to_install=()
        
        for pkg in "${aur_packages[@]}"; do
            if ! is_installed "$pkg"; then
                aur_to_install+=("$pkg")
            fi
        done
        
        if [ ${#aur_to_install[@]} -gt 0 ]; then
            yay -S --noconfirm "${aur_to_install[@]}"
        fi
    else
        print_warning "AUR helper (yay) not found. Please install these AUR packages manually:"
        print_warning "- libinput-gestures (touchpad gestures)"
        print_warning "- pixi-bin (Python environment manager)"
    fi
    
    # Docker post-install
    if is_installed "docker"; then
        print_info "Setting up Docker..."
        if ! groups | grep -q docker; then
            sudo usermod -aG docker $USER
            print_warning "Added user to docker group. Please log out and back in for changes to take effect."
        fi
    fi
}

# Function to backup existing configs
backup_configs() {
    local backup_dir="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
    local configs_to_backup=(
        "i3"
        "polybar"
        "alacritty"
        "rofi"
        "picom"
        "nitrogen"
    )
    
    local need_backup=false
    
    # Check if any configs exist
    for config in "${configs_to_backup[@]}"; do
        if [ -d "$HOME/.config/$config" ]; then
            need_backup=true
            break
        fi
    done
    
    if [ "$need_backup" = true ]; then
        print_info "Backing up existing configurations to $backup_dir"
        mkdir -p "$backup_dir"
        
        for config in "${configs_to_backup[@]}"; do
            if [ -d "$HOME/.config/$config" ]; then
                cp -r "$HOME/.config/$config" "$backup_dir/"
            fi
        done
        
        print_success "Backup completed"
    fi
}

# Function to copy configuration files
copy_configs() {
    print_info "Copying configuration files..."
    
    # Create .config directory if it doesn't exist
    mkdir -p "$HOME/.config"
    
    # Copy all config directories
    cp -r .config/* "$HOME/.config/"
    
    # Make scripts executable
    chmod +x "$HOME/.config/i3"/*.sh 2>/dev/null || true
    chmod +x "$HOME/.config/polybar"/*.sh 2>/dev/null || true
    
    print_success "Configuration files copied"
}

# Function to set up fonts
setup_fonts() {
    print_info "Setting up fonts..."
    
    # Rebuild font cache
    fc-cache -fv
    
    # Verify fonts
    if fc-list | grep -qi "jetbrains"; then
        print_success "JetBrains Mono font detected"
    else
        print_warning "JetBrains Mono font not found. Please install ttf-jetbrains-mono"
    fi
    
    if fc-list | grep -qi "awesome"; then
        print_success "Font Awesome detected"
    else
        print_warning "Font Awesome not found. Please install otf-font-awesome"
    fi
}

# Function to set up additional services
setup_services() {
    print_info "Setting up services..."
    
    # Enable NetworkManager if not already enabled
    if ! systemctl is-enabled NetworkManager &> /dev/null; then
        print_info "Enabling NetworkManager..."
        sudo systemctl enable NetworkManager
        sudo systemctl start NetworkManager
    fi
    
    # Enable Bluetooth if not already enabled
    if ! systemctl is-enabled bluetooth &> /dev/null; then
        print_info "Enabling Bluetooth..."
        sudo systemctl enable bluetooth
        sudo systemctl start bluetooth
    fi
}

# Main installation flow
main() {
    # Check if running from correct directory
    if [ ! -f "README.md" ] || [ ! -d ".config" ]; then
        print_error "Please run this script from the i3-neobrutalist-config directory"
        exit 1
    fi
    
    print_info "Starting installation process..."
    
    # Step 1: Install packages
    install_packages
    
    # Step 2: Backup existing configs
    backup_configs
    
    # Step 3: Copy configuration files
    copy_configs
    
    # Step 4: Set up fonts
    setup_fonts
    
    # Step 5: Set up services
    setup_services
    
    # Success message
    echo
    print_success "Installation completed!"
    echo
    echo -e "${GREEN}Next steps:${NC}"
    echo "1. Log out and select i3 from your display manager"
    echo "2. Or add 'exec i3' to ~/.xinitrc and run startx"
    echo "3. Press Mod+d to launch rofi"
    echo "4. Press Mod+Return to open a terminal"
    echo "5. Use nitrogen to set your wallpaper"
    echo
    echo -e "${YELLOW}Tips:${NC}"
    echo "- Mod key is the Windows/Super key"
    echo "- Press Mod+Shift+r to reload i3 configuration"
    echo "- Check the README.md for keybindings and customization"
    echo
}

# Run main function
main "$@"