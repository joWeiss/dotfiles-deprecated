function netstat --description 'No netstat on OSX'
	sudo lsof -i | grep LISTEN
end
