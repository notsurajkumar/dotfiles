#!/usr/bin/env fish

set -g ENCRYPTED_DIR "$HOME/Personal/.vault-encrypted"
set -g MOUNT_DIR "$HOME/Personal/vault"

function check_status
    if test -n "$MOUNT_DIR"; and mountpoint -q "$MOUNT_DIR" 2>/dev/null
        echo "unlocked"
    else
        echo "locked"
    end
end

function do_unlock
    if test (check_status) = "unlocked"
        gum style --foreground 212 "Vault is already unlocked!"
        return
    end

    mkdir -p "$MOUNT_DIR"
    gum style --foreground 51 "Unlocking vault..."
    gocryptfs "$ENCRYPTED_DIR" "$MOUNT_DIR"

    if test $status -eq 0
        gum style --foreground 46 "Vault successfully unlocked!"
    else
        gum style --foreground 196 "Failed to unlock vault."
    end
end

function do_lock
    if test (check_status) = "locked"
        gum style --foreground 212 "Vault is already locked!"
        return
    end

    fusermount3 -u "$MOUNT_DIR"
    if test $status -eq 0
        gum style --foreground 46 "Vault successfully locked!"
    else
        gum style --foreground 196 "Failed to lock vault. Ensure no files or applications are accessing it."
    end
end

set -l current_status (check_status)

if test "$current_status" = "unlocked"
    set -l choice (gum choose "Check Status" "Lock Vault" "Exit")
    switch "$choice"
        case "Lock Vault"
            do_lock
        case "Check Status"
            gum style --foreground 51 "Vault status: UNLOCKED"
    end
else
    set -l choice (gum choose "Check Status" "Unlock Vault" "Exit")
    switch "$choice"
        case "Unlock Vault"
            do_unlock
        case "Check Status"
            gum style --foreground 214 "Vault status: LOCKED"
    end
end
