# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/data/lijianchen/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="honukai"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions fzf)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# --------------------------------------------------------------------------------------- #
# added by Anaconda3 2018.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/data/lijianchen/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/data/lijianchen/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/data/lijianchen/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/data/lijianchen/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
conda activate pytorch

export XKB_DEFAULT_RULES=base
export QT_XKB_CONFIG_ROOT="/usr/share/X11/xkb:$QT_XKB_DEFAULT_ROOT"

alias pycharm='nohup /data/lijianchen/pycharm/pycharm-2018.3.3/bin/pycharm.sh >/dev/null 2>&1 &'
# export PATH="/usr/local/MATLAB/R2017a/bin:$PATH"
alias matlab="/usr/local/MATLAB/R2019b/bin/matlab"
# .. -r <matlabfile>: matlabfile dont't add suffix ".m"
alias mrun="/usr/local/MATLAB/R2019b/bin/matlab -nodesktop -nosplash -r"
alias vim="/home/lijianchen/neovim/nvim0.5.0.appimage"
alias tmux="/data/lijianchen/tmux/bin/tmux"

# If the last character of the alias value is a space or tab character, then the next command word following the alias is also checked for alias expansion.
alias sudo='sudo '

# alias rm="rm -i"
# 使用 /usr/bin/safe_rm.sh
# alias rm="~/config_backup/safe_rm.sh"
alias rm="/usr/bin/safe_rm.sh"

cdls() {
  \cd $1
  ls
}
alias cd="cdls"

[[ -s /data/lijianchen/.autojump/etc/profile.d/autojump.sh ]] && source /data/lijianchen/.autojump/etc/profile.d/autojump.sh

export TERM=xterm-256color

stty -ixon

export EDITOR=vim
export VISUAL=vim

export NODE_OPTIONS=--max_old_space_size=4096

# clang + llvm
export PATH="$PATH:$HOME/clang+llvm-9.0.0-x86_64-linux-gnu-ubuntu-16.04/bin"
# clangd is a language server that provides IDE-like features to editors.
export PATH="$PATH:$HOME/clangd_10.0.0/bin"

# http_proxy=127.0.0.1:10809
# https_proxy=127.0.0.1:10809
