#!/bin/bash

# DESCRIPTION
#   Runs ansible playbooks twice and check if there are changes.
#   First argument is the inventory file. It needs to use ungrouped ini format.
#   All the others arguments are ansible-playbook arguments.
# USAGE
#   ./idempotency_check.sh inventory_file [ansible_opts] playbook

set -euo pipefail

play_count=2
log_file=play.log
hosts_count=$(wc --lines <"$1")
shift

remove_log() {
    if [ -e "$log_file" ]; then
        rm "$log_file"
    fi
}

# Runs playbook logging to file
play_and_log() {
    for _i in $(seq "$play_count"); do
        ANSIBLE_LOG_PATH="$log_file" ansible-playbook "$@"
    done
}

check_status_code() {
    local play_recap changed_code_list

    # Get lines equal to number of hosts after last "PLAY RECAP"
    play_recap=$(tail --lines "$hosts_count" "$log_file")

    # Get only "changed" result codes
    changed_code_list=$(echo "$play_recap" |
        grep -oE 'changed=.{,1}' |
        sed 's/changed=//')

    # Checks if there's a change code different than zero
    for code in $changed_code_list; do
        if [ "$code" -ne 0 ]; then
            echo "There are changes after $play_count plays. Not idempotent!"
            exit 0
        fi
    done

    echo "No changes after $play_count plays!"
}

remove_log
play_and_log "$@"
check_status_code
remove_log

exit 0
