function vundle-update -d "Update my Vundle-Installation"
    vundle-init
    vim -c "execute \"PluginInstall!\" | q | q"
end
