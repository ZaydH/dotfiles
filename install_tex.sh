source .functions

# Install mactex - TeX distribution for MacOS
function install_mactex() {
    printf "Installing mactex - this may take a while..."
    brew tap caskroom/cask > /dev/null
    # brew cask install mactex > /dev/null
    brew install --cask  mactex > /dev/null
    printf "COMPLETED"
}

function install_tex_linux() {
    if is_debian; then
        PKG_NAME="texlive-full"
    elif is_manjaro; then
        PKG_NAME="texlive-most"
    else
        printf "Unknown platform for installing tex...Exiting\n" >&2
        return 1
    fi
    install_cli_package ${PKG_NAME}
}

function install_tex() {
    if is_mac; then
        install_mactex
    elif is_linux; then
        install_tex_linux
    else
        printf "Unknown platform...";
    fi
}
