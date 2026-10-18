#!/bin/bash

# ============================================================
# CONFIGURATION
# ============================================================

# Absolute path to your database
DATABASE="/home/rudra/scripts/snippets/database.md"

# Rofi settings
#ROFI_THEME=""

# ============================================================
# DATABASE PARSING
# ============================================================

# Extract:
#   searchable_name<TAB>actual_value
#
# Each entry starts with:
#   ### heading
#
# Everything after that heading, until the next ### heading,
# is treated as the value.

get_snippets() {
    awk '
    /^### / {
        if (name != "") {
            printf "%s\t%s", name, value
        }

        name = substr($0, 5)
        value = ""
        first_line = 1
        next
    }

    {
        if (!first_line)
            value = value "\n"

        value = value $0
        first_line = 0
    }

    END {
        if (name != "")
            printf "%s\t%s", name, value
    }
    ' "$DATABASE"
}

# ============================================================
# ROFI
# ============================================================

show_rofi() {
    rofi \
        -dmenu \
        -theme-str 'listview { columns : 3; }' -theme-str 'element-icon { enabled : false; }'  \
        -i \
        -matching fuzzy \
        -p "Snippets   " \
        $ROFI_THEME
}

# ============================================================
# MAIN LOGIC
# ============================================================

# Get all snippets and give them to rofi.
#
# cut -f1 means rofi only sees the searchable names.
#
# After the user selects something, we use the selected name
# to find the corresponding value again.

choice=$(
    get_snippets |
    cut -f1 |
    show_rofi
)

# If Escape was pressed or nothing was selected, exit.
[[ -z "$choice" ]] && exit 0


# ============================================================
# GET THE ACTUAL VALUE
# ============================================================

value=$(
    awk -v wanted="$choice" '
    /^### / {
        if (name == wanted) {
            print value
            found = 1
            exit
        }

        name = substr($0, 5)
        value = ""
        first_line = 1
        next
    }

    {
        if (!first_line)
            value = value "\n"

        value = value $0
        first_line = 0
    }

    END {
        if (!found && name == wanted)
            print value
    }
    ' "$DATABASE"
)


# ============================================================
# COPY TO CLIPBOARD
# ============================================================

printf '%s' "$value" | wl-copy
