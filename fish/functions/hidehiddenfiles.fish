function hidehiddenfiles --description 'Alias to hide hidden files in Finder.'
	defaults write com.apple.finder AppleShowAllFiles NO
    killall Finder
end
