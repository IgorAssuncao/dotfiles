backupOldConfig() {
    echo "Backing up old config in ~/.config"
    target=$1
    if [[ ! -e $target ]]; then
        mv ~/.config/$target ~/.config/${target}.bkp
    fi
}

createSymlink() {
    software=$1
    target=$2
    if [[ $2 == "" ]]; then
        target=$software
    fi
    echo "Creating symlink for $software"
    ln -s ~/system-config/config/$software ~/.config/$target
    echo "Created symlink for $t successfully"
}
