#!/usr/bin/env bash

xdrip_value_string="@xdrip_value_string"
xdrip_icon_string="@xdrip_icon_string"

data_value=0

slope_single_down_icon="󰁅"
slope_double_down_icon="󰁅󰁅"
slope_forty_five_down_icon="󰁃"
slope_forty_five_up_icon="󰁜"
slope_flat_icon="󰁔"
slope_single_up_icon="󰁝"
slope_double_up_icon="󰁝󰁝"
slope_none_icon="󱫃"
slope_icon=""

threshold_low="4"
threshold_high="9"

select_color="#a6da95"

# show_xdrip() {
#   local index=$1
#   local icon
#   local color
#   local result
#   local text
#   local module
#   local c
#   result="$(get_status)"
#   c="$(get_color)"
#
#   icon="$(get_tmux_option "@catppuccin_xdrip_icon" "")"
#   text="$(get_tmux_option "@catppuccin_xdrip_text" "$result")"
#   color="$(get_tmux_option "@catppuccin_xdrip_color" "$select_color")"
#
#   module=$( build_status_module "$index" "$icon" "$color" "$text" )
#
#   echo "$module"
# }

get_status() {
  local xdrip_local_server="$(echo $XDRIP_SERVER)"
  local xdrip_local_key="$(echo $XDRIP_SERVER_KEY)"
  local data=$(curl -s $xdrip_local_server --header "api-secret: $xdrip_local_key")
  data_value=$(echo $data | jq -r .bgs[].sgv)
  data_value=$(printf '%.*f\n' 0 $data_value)

  local slope=$(echo $data | jq -r .bgs[].direction)
  slope_icon=""

  case $slope in
    SingleUp)
      slope_icon=$slope_single_up_icon
      ;;
    DoubleUp)
      slope_icon=$slope_double_up_icon
      ;;
    FortyFiveUp)
      slope_icon=$slope_forty_five_up_icon
      ;;
    FortyFiveDown)
      slope_icon=$slope_forty_five_down_icon
      ;;
    Flat)
      slope_icon=$slope_flat_icon
      ;;
    SingleDown)
      slope_icon=$slope_single_down_icon
      ;;
    DoubleDown)
      slope_icon=$slope_double_down_icon
      ;;
  esac

  # echo "$(echo $data | jq -r .bgs[].sgv) $slope_icon"
}

print_status() {
  if $(get_status); then
    printf "$(get_tmux_option "$xdrip_value_string" "$(data_value)") $(get_tmux_option "$xdrip_icon_string" "$(slope_icon)")"
  fi
}

main() {
  get_status
  print_status
}
main

# get_color() {
#   local xdrip_local_server="$(echo $XDRIP_SERVER)"
#   local xdrip_local_key="$(echo $XDRIP_SERVER_KEY)"
#   local data=$(curl -s $xdrip_local_server --header "api-secret: $xdrip_local_key")
#   data_value=$(echo $data | jq -r .bgs[].sgv)
#   data_value=$(printf '%.*f\n' 0 $data_value)
#
#   if [[ $data_value -gt $threshold_high ]]
#   then
#     select_color=$thm_yellow
#   elif [[ $data_value -le $threshold_low ]]
#   then
#     select_color=$thm_red
#   else
#     select_color=$thm_green
#   fi
# }
