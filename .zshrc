# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# sonicradish jnrowe agnoster nebirhos blinks sunrise
# ZSH_THEME="random"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=("af-magic" "robbyrussell" "agnoster" "sonicradish" "jnrowe" "nebirhos" "blinks" "jonathan" "muse")
ZSH_THEME_RANDOM_IGNORED=("empty")

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# 关闭自动转义
DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# 可选的 colored-man-pages git (也就一些 git 的 alias)
# plugins=(zsh-autosuggestions zsh-syntax-highlighting sudo vi-mode aliases command-not-found fzf-tab)
plugins=(
	fast-syntax-highlighting
	sudo
	vi-mode
	extract
	fzf-tab
)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# source ~/.oh-my-zsh/custom/plugins/fzf-tab-completion/zsh/fzf-zsh-completion.sh
# source ./.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

FPATH=/usr/share/zsh/site-functions:$FPATH
FPATH="/home/linuxbrew/.linuxbrew/share/zsh/site-functions:${FPATH}"
source $ZSH/oh-my-zsh.sh

# User configuration

##############################
#### EVAL
# Set PATH, MANPATH, etc., for Homebrew.
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(zoxide init zsh)"
# eval "$(zoxide init --cmd cd zsh)"
# eval "$(atuin init zsh)"
#### EVAL
##############################

##############################
#### fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
# show systemd unit status
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
# show file contents
# zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
zstyle ':fzf-tab:complete:*:*' fzf-preview '$HOME/.lessfilter ${(Q)realpath}'
# To disable or override preview for command options and subcommands, use following
# zstyle ':fzf-tab:complete:*:options' fzf-preview
# zstyle ':fzf-tab:complete:*:argument-1' fzf-preview
# environment variable
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	fzf-preview 'echo ${(P)word}'
# git
# it is an example. you can change it
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
	'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
	'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
	'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'

# Homebrew
zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview 'brew info $word'
# tldr
zstyle ':fzf-tab:complete:tldr:argument-1' fzf-preview 'tldr --color always $word'
# Commands
zstyle ':fzf-tab:complete:-command-:*' fzf-preview \
  '(out=$(tldr --color always "$word") 2>/dev/null && echo $out) || (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word") 2>/dev/null && echo $out) || (out=$(which "$word") && echo $out) || echo "${(P)word}"'
zstyle ':fzf-tab:*' fzf-flags --height 50%
#### fzf-tab
##############################

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
# export RANGER_LOAD_DEFAULT_RC=FALSE

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ranger with neovim
export VISUAL=nvim
export EDITOR=nvim
export VI_MODE_SET_CURSOR=true

# zoxide
export _ZO_ECHO=1

# Atuin
export ATUIN_NOBIND="true"

export GO111MODULE=on
export GOPROXY=https://goproxy.cn

export LESSOPEN='|$HOME/.lessfilter %s'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# zsh 某些操作的记录防忘记
# 输入 d 回车可以查看当前会话访问过的所有目录

alias update="sudo apt update -y && sudo apt upgrade -y"
alias ls="lsd"
alias ll="lsd -l"
alias la="lsd -lAh"
alias ff="fastfetch"
alias cf="cpufetch"
alias jo="joshuto"
# alias df="duf"
# alias du="ncdu"
alias path='tr ":" "\n" <<< $PATH'
# alias top="glances"
# alias vim="nvim"
alias nvimconf="nvim ~/.config/nvim/init.vim"
alias vimconf="nvim ~/.vimrc"
alias zshconf="nvims ~/.zshrc"
alias setbrew='eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'
alias gz='tar -xzvf'
alias tgz='tar -xzvf'
alias txz='tar -xvf'
alias zip='unzip'
alias bz2='tar -xjvf'
alias gcid="git log | head -1 | awk '{print substr(\$2,1,7)}' | pbcopy"
alias cfg='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cfgui='gitui -d $HOME/.cfg/ -w $HOME'
alias pip="python -m pip"
alias ra="ranger"
alias so="exec zsh"
alias rg="rg --hidden --glob '!.git'"
alias brewupdate="brew update && brew upgrade"
# alias code-insiders="/mnt/d/scoop/apps/vscode-insiders/current/bin/code-insiders"
alias neo="neofetch"
alias neolol="ff | lolcat"
alias pacman="sudo pacman"
alias systemctl="sudo systemctl"
alias fdisk="sudo fdisk"
# alias updatedb="sudo updatedb"
alias zshhist="nvims ~/.zsh_history"
alias che='chezmoi'
# alias tree='lsd --tree'

function mkcd {
  command mkdir $1 && cd $1
}

bindkey '^H' backward-kill-word
bindkey '^Z' undo
bindkey '^Y' redo
# bindkey '^V' paste
bindkey '5~' kill-word
bindkey '^U' backward-kill-line

# 允许多用户使用相同zsh配置
# ZSH_DISABLE_COMPFIX=true

######################## brew begin ########################
# tsinghua
# export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
# export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
# export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

# tencent
# export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.cloud.tencent.com/homebrew/brew.git/"
# export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.cloud.tencent.com/homebrew/homebrew-core.git/"
# export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.cloud.tencent.com/homebrew-bottles/"

# aliyun
# export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/brew.git/"
# export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/homebrew-core.git/"
# export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.aliyun.com/homebrew/homebrew-bottles/"

# ustc
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"

# export HOMEBREW_NO_AUTO_UPDATE=1

######################## brew end ########################

# rustup
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

######################## proxy begin ########################
setwslgitproxy() {
  host_ip=$(cat /etc/resolv.conf |grep "nameserver" |cut -f 2 -d " ")
  # [ -d .git/ ] && git config http.https://github.com.proxy socks5://$host_ip:7890
  git config --global http.https://github.com.proxy socks5://$host_ip:7890
}

unwslgitproxy() {
  host_ip=$(cat /etc/resolv.conf |grep "nameserver" |cut -f 2 -d " ")
  [ -d .git/ ] && git config --unset http.https://github.com.proxy
  git config --unset --global http.https://github.com.proxy
}

setwslproxy() {
  host_ip=$(cat /etc/resolv.conf |grep "nameserver" |cut -f 2 -d " ")
  # export all_proxy="socks://$host_ip:10810"
  # export http_proxy="socks://$host_ip:10810"
  # export https_proxy="socks://$host_ip:10810"
  export all_proxy="http://$host_ip:7890"
  export http_proxy="http://$host_ip:7890"
  export https_proxy="http://$host_ip:7890"
  # 以下是成功的
  # git config http.proxy socks5://$host_ip:7890
  # 以下没有试过
  # [ -d .git/ ] && git config http.https://github.com.proxy socks5://$host_ip:7890
  # git config --global http.https://github.com.proxy socks5://$host_ip:7890
}

unproxy() {
  unset all_proxy
  unset http_proxy
  unset https_proxy
  # [ -d .git/ ] && git config --unset http.https://github.com.proxy
  # git config --unset --global http.https://github.com.proxy
}

setsshproxy() {
  host_ip=$(echo $SSH_CONNECTION | awk '{print $1}')
  # host_ip=$(echo $SSH_CONNECTION | choose 0)
  export all_proxy="http://$host_ip:7890"
  export http_proxy="http://$host_ip:7890"
  export https_proxy="http://$host_ip:7890"
  git config --global http.https://github.com.proxy socks5://$host_ip:7890
}

sethostproxy() {
  export http_proxy=http://gtr-host:7890
  export https_proxy=$http_proxy
  export ftp_proxy=$http_proxy
  export rsync_proxy=$http_proxy
  export all_proxy=$http_proxy
  export HTTP_PROXY=$proxy
  export HTTPS_PROXY=$proxy
  export FTP_PROXY=$proxy
  export RSYNC_PROXY=$proxy
  export ALL_PROXY=$http_proxy
  export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
  git config --global http.https://github.com.proxy socks5://gtr-host:7890
}

######################## proxy end ########################

########
#### fzf
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git --exclude .local/state/nvim/ -I'
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border --inline-info -m --preview "$HOME/.lessfilter {}"'
# export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border --inline-info -m'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
# export FZF_ALT_C_COMMAND="fd --t d --hidden --follow --exclude .git"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow -I"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/share/fzf/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/share/fzf/key-bindings.zsh"

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1" -I
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1" -I
}

# (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fzf "$@" ;;
  esac
}

#### fzf
########

##############################
#### PATH

# https://stackoverflow.com/questions/62873982/linux-check-if-path-exists
appendpath () {
  case ":$PATH:" in
    *:"$1":*)
      ;;
    *)
      PATH="${PATH:+$PATH:}$1"
  esac
}

appendpath "$HOME/.cargo/bin"
# appendpath "$HOME/bin"
appendpath "$HOME/.local/bin"
appendpath "$HOME/go/bin"
appendpath "/opt/alist"
appendpath "/opt/riscv/bin"
appendpath "$HOME/repo/depot_tools"

# https://unix.stackexchange.com/questions/124444/how-can-i-cleanly-add-to-path
prependpath () {
  case ":${PATH:=$1}:" in
    *:"$1":*)
      ;;
    *)
      PATH="$1:$PATH"
      ;;
    esac
}

prependpath "$HOME/venv/bin"
prependpath "$HOME/bin"

#### PATH
##############################

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

##############################
# function

setup_samba() {
  sudo pacman -S samba
  sudo wget "https://git.samba.org/samba.git/?p=samba.git;a=blob_plain;f=examples/smb.conf.default;hb=HEAD" -O /etc/samba/smb.conf
  TMP_SMB_CONF="/tmp/smb.conf"
  SMB_CONF="/etc/samba/smb.conf"
  cp -f $SMB_CONF $TMP_SMB_CONF
  cat >> $TMP_SMB_CONF << EOF
[${USER}]
  comment = Home Driectory
  path = /home/${USER}
  read only = no
  writeable = yes
  browseable = no
  create mask = 0644
  force create mask = 0644
  directory mode = 0755
  force directory mask = 0755
  valid users = ${USER}
EOF
  sudo cp -f $TMP_SMB_CONF $SMB_CONF
  sudo smbpasswd -a gtr # 创建一个 smb 账户
  sudo systemctl enable --now smb.service
}

# function
##############################


##############################
# neovim
# https://www.youtube.com/watch?v=LkHjJlSgKZY

alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"

function nvims() {
  items=("default" "kickstart" "LazyVim" "NvChad" "AstroNvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config="LazyVim"
    # config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

bindkey -s ^n "nvims\n"
#
##############################
##############################
# source
[[ ! -f ~/.config/broot/launcher/bash/br ]] || source ~/.config/broot/launcher/bash/br
# source
##############################

setsshproxy

[ -f ~/.inshellisense/key-bindings.zsh ] && source ~/.inshellisense/key-bindings.zsh

export SAVEHIST=1000000 # 保留 100000 条历史记录
# setopt hist_save_no_dups # 让 zsh 在保存历史记录到文件时删除所有重复的命令，只保留最新的命令。只会忽略和最后一条历史命令相同的命令，不把它们保存到历史记录中。
# setopt hist_ignore_all_dups # 让 zsh 在保存历史记录时删除所有重复的命令，只保留最新的命令。会忽略所有和之前任何一条历史命令相同的命令，不把它们保存到历史记录中。
# setopt share_history # 让 zsh 在每次执行命令后自动保存和读取历史记录，这样可以在多个 zsh 会话中共享历史记录。
# setopt hist_expire_dups_first # 让 zsh 在达到历史记录的最大数量时，优先删除重复的命令，保留不重复的命令。
