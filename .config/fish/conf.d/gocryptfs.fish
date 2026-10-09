# ==========================================
# gocryptfs Folder Locker
# ==========================================

function unlock-folder
    if test (count $argv) -ne 1
        echo "Usage: unlock-folder <folder>"
        return 1
    end

    set folder (string trim -r -c "/" -- "$argv[1]")
    set parent (dirname "$folder")
    set name (basename "$folder")
    set vault "$parent/.$name.vault"

    if not test -d "$vault"
        echo "Creating new locked vault..."
        mkdir -p "$vault"
        gocryptfs -init "$vault"; or return 1
    end

    mkdir -p "$folder"
    chmod 700 "$folder"

    gocryptfs "$vault" "$folder"
end

function lock-folder
    if test (count $argv) -ne 1
        echo "Usage: lock-folder <folder>"
        return 1
    end

    set folder (string trim -r -c "/" -- "$argv[1]")

    if command fusermount3 -u "$folder" >/dev/null 2>&1
        echo "Locked: $folder"
        chmod 500 "$folder"
    else if command fusermount -u "$folder" >/dev/null 2>&1
        echo "Locked: $folder"
        chmod 500 "$folder"
    else
        echo "Could not lock. Make sure:"
        echo "  - The folder is currently mounted"
        echo "  - You are not inside the folder"
        return 1
    end
end


# status checker and also locker
alias pstatus="bass source /home/rudra/scripts/vault-logic/locker.sh"
alias personal-s="bass source /home/rudra/scripts/vault-logic/locker.sh"
alias spersonal="bass source /home/rudra/scripts/vault-logic/locker.sh"
alias s-personal="bass source /home/rudra/scripts/vault-logic/locker.sh"


# status checker and opener
alias personal="bash /home/rudra/scripts/vault-logic/opener.sh"
