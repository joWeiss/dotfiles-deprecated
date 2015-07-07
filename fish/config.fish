# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Path to your custom folder (default path is ~/.oh-my-fish/custom)
set fish_custom $HOME/.oh-my-fish/custom

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

# Load custom configurations
. $fish_custom/custom_config.fish

# Custom plugins and themes may be added to ~/.oh-my-fish/custom
# Plugins and themes can be found at https://github.com/oh-my-fish/
# Theme 'integral'
# Theme 'jacaetevha'
# Theme 'krisleech'
# Theme 'mtahmed'
# Theme 'nai'
# Theme 'numist'
# Theme 'ocean'
Theme "sn3rd"

Plugin 'theme'

# needed for vi_mode plugin
# function my_key_bindings
#     fish_user_key_bindings
#     bind \cr 'peco_select_history (commandline -b)'
# end
#
# set -g fish_key_bindings my_key_bindings
