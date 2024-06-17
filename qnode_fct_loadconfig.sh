#!/bin/bash

#read a config file

load_config() {
    local config_file="$1"
    if [[ -f "$config_file" ]]; then
        while IFS='=' read -r key value; do
            # Ignore empty or commented lines
            [[ "$key" =~ ^#.*$ || -z "$key" ]] && continue
            export "$key"="$value"
        done < "$config_file"
    else
        echo "Le fichier de configuration $config_file n'existe pas."
        return 1
    fi
}
