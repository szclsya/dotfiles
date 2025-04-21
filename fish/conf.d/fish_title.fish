function __git_prompt -d 'Wrapper of the official git prompt'
    # Configure builtin VCS prompt
    set -g __fish_git_prompt_show_informative_status false
    set -g __fish_git_prompt_showcolorhints true
    set -g __fish_git_prompt_showdirtystate true
    set -g __fish_git_prompt_showuntrackedfiles true
    set -g __fish_git_prompt_shorten_branch_len 10

    set -g __fish_git_prompt_char_cleanstate " o" # Need a space here, what a hack
    set -g __fish_git_prompt_char_dirtystate "x"
    set -g __fish_git_prompt_char_stagedstate "x"
    set -g __fish_git_prompt_char_untrackedfiles "+"
    set -g __fish_git_prompt_char_invalidstate ""

    set -g __fish_git_prompt_color_cleanstate green
    set -g __fish_git_prompt_color_untrackedfiles red
    set -g __fish_git_prompt_color_dirtystate red
    set -g __fish_git_prompt_color_stagedstate FFA500
    set -g __fish_git_prompt_color_invalidstate red

    set -g __fish_git_prompt_color_branch cyan
    set -g __fish_git_prompt_color_branch_done normal
    set -g __fish_git_prompt_color_branch_dirty cyan
    set -g __fish_git_prompt_color_branch_dirty_done normal

    if set -f text (fish_git_prompt "%s")
        # Return a colorful version
        echo -s (set_color -d) "on " (set_color normal) "git:" $text
    end
end

function __return_code
	if test $argv[1] -ne 0
		echo -n -s (set_color normal) " C:" (set_color --bold brred) $argv[1]
	end
end

function fish_greeting
end

function __human_secs -d 'Generate human-readable time from miliseconds' -a ms
    if [ $ms -le 500 ]
        printf "%dms" $ms
    else if [ $ms -le (math 60000) ]
        printf "%.2fs" (math $ms/1000)
    else if [ $ms -le (math 3600000) ]
        printf "%.2fm" (math $ms/1000/60)
    else
        printf "%.2fh" (math $ms/1000/60/60)
    end
end

function __prompt_body -d 'Gen prompt body with a length limit' -a max_len -a _status
    # Helper
    set -f normal (set_color normal)
    set -f realhome ~
    set -f pretty_pwd (string replace -r '^'"$realhome"'($|/)' '~$1' $PWD)

    # Each part of the prompt body
    set -f start (echo -s (set_color -oi blue) "#")
    if [ $USER = "root" ]
        set -f user (echo -s (set_color -b yellow -o 01579b) $USER)
    else
        set -f user (echo -s (set_color cyan) $USER)
    end
    set -f at (echo -s (set_color -d) "@")
    if set -q SSH_TTY
        set -f pretty_hostname (echo -s (set_color -b yellow) (set_color 004d40) (prompt_hostname) $normal)
    else
        set -f pretty_hostname (echo -s (set_color -b black) (set_color green) (prompt_hostname) $normal)
    end
    set -f in (echo -s (set_color -d) "in")
    set -f working_dir (echo -s (set_color -o yellow) $pretty_pwd)
    set -f git (__git_prompt)
    if [ $_status -ne 0 ]
        set -f return_code (echo -s "C:" (set_color -o red) $_status)
    end

    # First try the whole length
    set -f prompt (string join "$normal " $start $user $at $pretty_hostname $in $working_dir $git $return_code)

    if [ (string length --visible $prompt) -gt $max_len ]
        set -l rest_len (string length --visible "$start $user $at $pretty_hostname $in $git $return_code")
        set -l prompt_working_dir (echo -s (set_color -o yellow) (prompt_pwd -d 5))
        # Still need to truncate it just in case
        set -l short_working_dir (string shorten -m (math $max_len - $rest_len) $prompt_working_dir)
        set -f prompt (string join "$normal " $start $user $at $pretty_hostname $in $short_working_dir $git $return_code)
    end

    echo -ne "$prompt$normal"
end

function fish_prompt --description 'Write out the prompt'
    # Protect return code from being overwritten by other commands
    set -f _status $status
    set -f time (echo -s (set_color $fish_color_autosuggestion) (date "+%m-%d %H:%M:%S") (set_color normal))
    set -f prompt_max_len (math $COLUMNS - (string length --visible $time) - 5)
    set -f prompt_body (__prompt_body $prompt_max_len $_status)
    set -f time_padded (string pad -w (math $COLUMNS - (string length --visible $prompt_body)) $time)

    # Line 0
    if [ $CMD_DURATION -ge 100 ]
        set -f last_command_time (echo -s (set_color $fish_color_autosuggestion) (__human_secs $CMD_DURATION) (set_color normal))
        echo (string pad -w $COLUMNS $last_command_time)
    else
        echo
    end
    # Line 1
    echo "$prompt_body$time_padded"
    # Line 2
	echo -n -s -e (set_color --bold red) "\$ "
end
