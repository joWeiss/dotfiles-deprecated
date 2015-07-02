function fish_right_prompt
    set multiplexer (_is_multiplexed)
    switch $multiplexer
        case tmux
            printf '‹%s›' $vi_mode
        case '*'
            printf '‹%s›:%s' $vi_mode (battery -p)
    end
end
