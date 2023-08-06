#!/bin/bash

# DESCRIPTION
#   Enable VMs connection right away.
#   Useful after recreating VMs in test environments.
#   Note that you first need to create the ssh keys.
# USAGE
#   ./vm_connect.sh <vm_1> <vm_2> ... <vm_n>

set -euo pipefail

user=vagrant
ssh_port=22

remove_from_know_hosts() {
    ssh-keygen -f "${HOME}/.ssh/known_hosts" -R "$1"
}

await_ssh_port() {
    until nc -z -w2 "$1" "$ssh_port"; do
        echo "Awaiting $1..."
        sleep 2
    done
}

# -n: Dry run
# -o StrictHostKeyChecking=accept-new: Skips prompt to accept connection
accept_ssh_connection() {
    ssh -n -o StrictHostKeyChecking=accept-new "${user}@$1" >/dev/null 2>&1
}

for vm in "$@"; do
    remove_from_know_hosts "$vm"
    await_ssh_port "$vm"
    accept_ssh_connection "$vm"
    echo "$vm is ready!"
    echo ""
done

exit 0
