#!/usr/bin/env bash

xdrip_value_string="@xdrip_value_string"
xdrip_icon_string="@xdrip_icon_string"

data_value=0
data_value_float=0.0

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

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CURRENT_DIR/shared.sh

xdrip() {
  local xdrip_local_server="$(echo $XDRIP_SERVER)"
  local xdrip_local_key="$(echo $XDRIP_SERVER_KEY)"
  local data=$(curl -s $xdrip_local_server --header "api-secret: $xdrip_local_key")
  data_value=$(echo $data | jq -r .bgs[].sgv)
  data_value_float=$data_value
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
}

print_icon() {
  printf "$data_value_float $slope_icon"
}

main() {
  xdrip
  print_icon
}
main
