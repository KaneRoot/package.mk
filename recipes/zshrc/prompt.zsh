
# Removes the empty space at the right of the right prompt.
ZLE_RPROMPT_INDENT=0

# Others prompts
PS2="%{$fg_no_bold[yellow]%}%_>%{${reset_color}%} "
PS3="%{$fg_no_bold[yellow]%}?#%{${reset_color}%} "

function precmd {
	local r=$?

	local path_color user_color host_color return_code user_at_host
	local cwd sign branch vcs vcs_color diff remote deco branch_color chroot_info
	local base_color

	title

	if [[ ! -e "$PWD" ]]; then
		path_color="${fg_no_bold[black]}"
	elif [[ -O "$PWD" ]]; then
		path_color="${fg_no_bold[white]}"
	elif [[ -w "$PWD" ]]; then
		path_color="${fg_no_bold[blue]}"
	else
		path_color="${fg_no_bold[red]}"
	fi

	base_color=${PS1_HOST_COLOR:=green}

	sign=">"

	case ${USER%%.*} in
		root)
			user_color="%{$(f bright-red)%}"
			host_color="%{$(f red)%}"
			sign="%{${fg_bold[red]}%}$sign"
		;;
		*)
			host_color="%{$(f ${host_color:-$base_color})%}"
			user_color="%{$(f ${user_color:-bright-$base_color})%}"
			sign="%{${fg_bold[$base_color]}%}$sign"
		;;
	esac

	deco="%{${fg_bold[blue]}%}"

	chroot_info=
	if [[ -e /etc/chroot ]]; then
		chroot_color="${host_color:-$base_color}"
		chroot_info="%{${fg_bold[white]}%}(${chroot_color}$(< /etc/chroot)%{${fg_bold[white]}%})"
	fi

	return_code="%(?..${deco}-%{${fg_no_bold[red]}%}%?${deco}- )"
	#user_at_host="%{${user_color}%}%n%{${fg_bold[white]}%}/%{${host_color}%}%m"
	user_at_host="%{${host_color}%}%m%{${fg_bold[white]}%}/%{${user_color}%}%n"
	cwd="%{${path_color}%}%48<...<%~"

	PS1="${return_code}${user_at_host}"
	PS1="${chroot_info:+$chroot_info }$PS1 ${cwd} ${sign}%{${reset_color}%} "

	RPS1=
}

function zle-line-init zle-keymap-select {
	local MODE

	case "$KEYMAP" in
		vicmd)
			MODE="NORMAL"
			color="$(b orange)$(fb darkest-red)"
		;;
		main|viins)
			case "$ZLE_STATE" in
				"globalhistory overwrite")
					MODE="REPLACE"
					color="$(b red)$(fb white)"
				;;
				"globalhistory insert")
					MODE="INSERT"
					color="$(b brightest-green)$(fb darkest-green)"
				;;
				*)
				;;
			esac
		;;
		vivis)
			MODE="VISUAL"
			color="$(b magenta)$(fb darkest-magenta)"
		;;
		vivli)
			MODE="V-LINE"
			color="$(b magenta)$(fb darkest-magenta)"
		;;
		*)
			MODE="$KEYMAP" # Will be lowercase.
			color="$(b pink)$(fb black)"
		;;
	esac

	precmd

	RPS1="${RPS1:+$RPS1}%{${color}%} ${MODE} %{${reset_color}%}"

	zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# vim: set ts=4 sw=4 cc=80 :
