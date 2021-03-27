
# Helper to convert color strings into usable color numbers.
# Well… many many colors are missing, but, what the hell? As long as we’re
# not using them, …
# FIXME: Need something more declarative, here.
function color {
	case "$1" in
		black)
			echo "16";;
		white)
			echo "253";;
		gr[ae]y)
			echo "240";;
		dark-gr[ae]y)
			echo "236";;
		light-gr[ae]y)
			echo "247";;
		darkest-red)
			echo "52";;
		red)
			echo "160";;
		bright-red)
			echo "196";;
		pink)
			echo "199";;
		cyan)
			echo "45";;
		bright-cyan)
			echo "51";;
		darkest-green)
			echo 22;;
		green)
			echo "118";;
		bright-green)
			echo "120";;
		brightest-green)
			echo "148";;
		dark-green)
			echo "70";;
		yellow)
			echo "220";;
		bright-yellow)
			echo "227";;
		orange)
			echo "166";;
		bright-orange)
			echo "209";;
		brightest-orange)
			echo "214";;
		blue)
			echo "69";;
		bright-blue)
			echo "75";;
		darkest-magenta)
			echo "57";;
		magenta)
			echo "141";;
		bright-magenta)
			echo "147";;
		*)
			echo "$1";;
	esac
}

# Displays a 256color color code. One for foregrounds, one for backgrounds.
function f { echo -e "\033[38;5;$(color ${1})m" }
function b { echo -e "\033[48;5;$(color ${1})m" }
function fb { echo -e "\033[1m\033[38;5;$(color ${1})m" }

# vim: set ts=4 sw=4 cc=80 :
