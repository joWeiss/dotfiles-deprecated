function vundle-init -d "Installs the Vundle plugin for vim"
    if test ! -d ~/.vim/bundle/Vundle.vim/
        mkdir -p ~/.vim/bundle/Vundle.vim/
    end

    if test ! \( -d ~/.vim/bundle/Vundle.vim/.git \) -a ! \( -f ~/.vim/bundle/Vundle.vim/.git \)
        git clone http://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
        echo "\n\tRead about vim configuration for vundle at https://github.com/VundleVim/Vundle.vim\n"
    end
end
