#!/bin/bash

all_tabs="$(
    kitty @ ls | jq -r '
        .[].tabs.[] |
        [.title, .id] |
        @tsv
    ' | column -ts $'\t'
)"

new_tab_id="$(fzf --header "Select tab:" --header-first --reverse <<<"$all_tabs" | awk '{ print $NF }')"
kitty @ focus-tab --match "id:$new_tab_id"