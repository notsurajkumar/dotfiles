function dotfiles --wraps='git --git-dir=/home/rudra/tmp/dotfiles-git/.cfg/ --work-tree=/home/rudra' --description 'alias dotfiles git --git-dir=/home/rudra/tmp/dotfiles-git/.cfg/ --work-tree=/home/rudra'
    git --git-dir=/home/rudra/tmp/dotfiles-git/.cfg/ --work-tree=/home/rudra $argv
end
