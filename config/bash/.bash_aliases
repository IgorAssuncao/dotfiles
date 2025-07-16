if [[ $commands[eza] ]]; then
    alias l='eza -lhgaa --group-directories-first'
else
    echo "eza is not installed"
fi
