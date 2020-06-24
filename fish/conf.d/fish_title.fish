function __git_prompt --description 'Our own git prompt'
    # If git isn't installed, there's nothing we can do
    # Return 1 so the calling prompt can deal with it
    if not command -sq git
        return 1
    end
    set -l repo_info (command git rev-parse --git-dir --is-inside-git-dir --is-bare-repository --is-inside-work-tree HEAD 2>/dev/null)
    test -n "$repo_info"
    or return

    set -l git_dir $repo_info[1]
    set -l inside_gitdir $repo_info[2]
    set -l bare_repo $repo_info[3]
    set -l inside_worktree $repo_info[4]

	# Fun starts here
	if test $inside_worktree
		set -l branch (command git rev-parse --symbolic-full-name --abbrev-ref HEAD)
		set -l git_status (command git status --porcelain)

		echo -n -s \
			(set_color white) "on git:" (set_color normal) \
			(set_color cyan) $branch (set_color normal) " "

		if test -z "$git_status"
			echo -n -s (set_color green) "o" (set_color normal)
		else
			echo -n -s (set_color red) "x" (set_color normal)
		end
	end
end

function __user --description 'Print user name'
	if test "$USER" = "root"
		echo -n -s (set_color --bold blue) (set_color --background yellow) "$USER" $normal
	else
		echo -n -s (set_color --bold cyan) "$USER" $normal
	end
end

function __return_code
	if test $argv[1] -ne 0
		echo -n -s (set_color white) "C:" (set_color --bold red) $argv[1]
	end
end

function fish_greeting
end

function fish_prompt --description 'Write out the prompt'
	set -l return_code $status
	# Helpers
	set -l normal (set_color normal)
	set -l s " "

	# Env info
    set -l realhome ~
    set -l pretty_pwd (string replace -r '^'"$realhome"'($|/)' '~$1' $PWD)

    # If we're running via SSH, change the host color.
    set -l color_host black 
    if set -q SSH_TTY
        set color_host yellow
    end

	# Add a newline first
	echo ""

	echo -s -e \
		(set_color --bold blue) "#" $normal " " \
		(__user) $normal " " \
		(set_color white) "@" $normal " " \
		(set_color green) (set_color --background $color_host) $hostname $normal " " \
		(set_color white) "in" $normal " " \
		(set_color --bold yellow) $pretty_pwd $normal " " \
		(__git_prompt) \
		(__return_code $return_code) 


	echo -n -s -e \
		(set_color --bold red) "\$ "

end		

function fish_right_prompt
  set_color $fish_color_autosuggestion 2> /dev/null; or set_color 555
  date "+%m-%d %H:%M:%S"
  set_color normal
end
