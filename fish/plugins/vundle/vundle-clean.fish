function vundle-clean -d "Clean unnecessary plugins"
    vundle-init
    vim -c "execute \"PluginClean!\" | q | q"
end
