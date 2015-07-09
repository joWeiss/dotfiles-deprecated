function git
	if test -z $argv
        command git $argv
    else
        set -l git_command $argv[1]
        switch $git_command
        case clone
            if test 1 -le (echo $argv[2] | grep -c https://) -o (echo $argv | wc -w) -gt 2
                command git $argv
            else
                set -l git_url (echo $argv[2] | sed -e 's#\(.*\)/\(.*\)#https://github.com/\1/\2\.git#g')
                command git clone $git_url
            end
        case '*'
            command git $argv
        end
	end
end
