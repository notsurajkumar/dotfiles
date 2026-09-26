# uploaded from git cli
#hellow world
#source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
# Overwrite default greeting to disable fastfetch
function fish_greeting
end
#    # smth smth
#end
set -gx STARSHIP_CONFIG ~/.config/starship/mocha.toml
#set -gx STARSHIP_CONFIG ~/.config/starship/minimal.toml
#set -gx STARSHIP_CONFIG ~/.config/starship/personal.toml
starship init fish | source

function vlc
    set -lx QT_SCALE_FACTOR 1.5
    command vlc $argv
end

# aliases
alias chromium="echo"
alias cfish="nvim ~/.config/fish/config.fish"
alias sfish="source ~/.config/fish/config.fish && fish"
alias historyc="rm ~/.local/share/fish/fish_history && exec fish"
alias chistory="rm ~/.local/share/fish/fish_history && exec fish"


alias lls="ls -lh"
alias lsl="ls -lh"
alias lse="ls --sort=extension"
alias cl="clear"
alias sup="fastfetch"


alias cbw="cliphist wipe"
alias cbl="cliphist list | head -n 1 | cliphist delete"
alias runit="python main.py"
alias run="bash compiler"
alias health="bash /home/rudra/scripts/battery-health/battery-health.sh"


alias vpn="protonvpn"


alias runit="python main.py"
alias ss="cd $(echo $HYPRSHOT_DIR)"
alias wall="cd ~/Pictures/wallpapers"
alias exp="dolphin . & disown"


alias dev="cd /mnt/E/Code/"
alias acad="cd /home/rudra/Documents/academics"
alias tools="bash /home/rudra/scripts/tools-selector/new.sh"
alias ntools="bash /home/rudra/scripts/new-tools-selector/tools.sh"
alias todo="nvim ~/notes/todo.md"
alias routine="nvim ~/notes/routine.md"
alias daily="nvim ~/notes/routine.md"
alias study="nvim ~/notes/study.md"
alias expenses="nvim ~/notes/expenses.md"
alias database="nvim ~/notes/database.md"
alias links="nvim ~/scripts/bookmarks-manager/links.md"
alias sites="nvim ~/scripts/bookmarks-manager/links.md"
alias watchlist="nvim ~/notes/watchlist.md"
alias epacman="nvim ~/scripts/post-install/pacman.md"
alias eyay="nvim ~/scripts/post-install/yay.md"







# Default ls (hide hidden files)
alias ls="eza -l --color=always --group-directories-first --icons=always"

# Show all files, including hidden ones
alias lsa="eza -al --color=always --group-directories-first --icons=always"




# power tools
alias poweredit="nvim ~/.local/bin/battery-extreme"
alias powersaver="sudo ~/.local/bin/battery-extreme"
alias powercheck="cat /sys/devices/system/cpu/intel_pstate/{min_perf_pct,max_perf_pct,no_turbo} && cat /sys/firmware/acpi/platform_profile"







# new tools selector
function ntools
    set -l action (bash /home/rudra/scripts/new-tools-selector/tools.sh)

    if test -n "$action"
        eval "$action"
    end
end


alias dotfiles "git --git-dir=$HOME/tmp/dotfiles-git/.cfg/ --work-tree=$HOME"
funcsave dotfiles
