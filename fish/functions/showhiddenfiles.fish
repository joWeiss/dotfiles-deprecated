function showhiddenfiles --description 'Alias to show hidden files in Finder'
	defaults write com.apple.finder AppleShowAllFiles YES
killall Finder
end
