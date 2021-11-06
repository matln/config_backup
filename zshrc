# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/lijianchen/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="honukai"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
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
# DISABLE_MAGIC_FUNCTIONS="true"

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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# alias rm="rm -i"
# alias rm="/usr/bin/safe_rm.sh"
alias rm='echo "This is not the command you are looking for. Use: Trash"; false'
alias trash-put='/data/lijianchen/miniconda3/envs/pytorch/bin/trash-put --trash-dir=/data/lijianchen/.Trash --force-volume=/data'
alias trash-list='/data/lijianchen/miniconda3/envs/pytorch/bin/trash-list --trash-dir=/data/lijianchen/.Trash'
alias trash-empty='/data/lijianchen/miniconda3/envs/pytorch/bin/trash-empty --trash-dir=/data/lijianchen/.Trash'
alias trash-restore='/data/lijianchen/miniconda3/envs/pytorch/bin/trash-restore --trash-dir=/data/lijianchen/.Trash'

cdls() {
  \cd $1
  ls
}
alias cd="cdls"

# true color
export TERM=xterm-256color

# ctrl + s 与 ctrl + q 在 linux 系统下分别为锁定屏幕和复原。
# 在系统中禁用这两个按键，然后在 vim 中利用起来
stty -ixon

# 用 vim 编辑命令行长命令
# 使用 `<CTRL-x><CTRL-e>` 打开 vim 编辑当前行
export EDITOR=vim
export VISUAL=vim

downloads="/data/lijianchen/Downloads"
data="/data/lijianchen"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/data/lijianchen/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/data/lijianchen/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/data/lijianchen/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/data/lijianchen/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda activate pytorch

[[ -s /home/lijianchen/.autojump/etc/profile.d/autojump.sh ]] && source /home/lijianchen/.autojump/etc/profile.d/autojump.sh

alias vim="~/neovim/nvim.appimage"
alias sudo='sudo '

# https://www.cnpython.com/qa/115981
export MKL_THREADING_LAYER=GNU

alias docker="sudo docker"

http_proxy=192.168.11.211:10809
https_proxy=192.168.11.211:10809
