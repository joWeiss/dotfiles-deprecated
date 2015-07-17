function vundle -d "Install new plugins"
    vundle-init
    vim -c "execute \"PluginInstall\" | q | q"
end
