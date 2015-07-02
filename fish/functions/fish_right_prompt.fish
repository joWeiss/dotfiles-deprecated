function fish_right_prompt
	if test $TERM != "screen-256color"
		battery -p
	end
end
