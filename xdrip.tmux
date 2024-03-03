#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

xdrip_status_icon="#($CURRENT_DIR/scripts/xdrip.sh)"
xdrip_status_interpolation_string="\#{xdrip}"

source $CURRENT_DIR/scripts/shared.sh

set_tmux_option() {
	local option="$1"
	local value="$2"
	tmux set-option -gq "$option" "$value"
}

do_interpolation() {
	local string="$1"
	local interpolated="${string/$xdrip_status_interpolation_string/$xdrip_status_icon}"
	echo "$interpolated"
}

update_tmux_option() {
	local option="$1"
	local option_value="$(get_tmux_option "$option")"
	local new_option_value="$(do_interpolation "$option_value")"
	set_tmux_option "$option" "$new_option_value"
}

main() {
  update_tmux_option "status-right"
  update_tmux_option "status-left"
}
main
