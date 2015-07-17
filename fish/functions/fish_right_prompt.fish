function fish_right_prompt
	set multiplexer (_is_multiplexed)
    switch $multiplexer
        case tmux
            printf '‹%s›' $status
        case '*'
            printf '‹%s›:%s' $status (battery -p)
    end
end
