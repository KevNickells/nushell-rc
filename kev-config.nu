# this file needs to be referenced in ~/.config/nushell/config.nu, eg source ~/.nu_config.nu

# TODO - functions in a separate file
# TODO https://www.nushell.sh/book/coloring_and_theming.html - styling shell

$env.EDITOR = /usr/bin/nvim

# this probably doesn't belong here

def search_history [search_for] {
  history | get 'command' | where ($it | str contains $search_for)
}

def command_complete [] {
  notify-send "Command exited"
}

def docker_clean [] {
  docker ps -a -q | lines | each {|it| docker stop $it}
  docker ps -a -q | lines | each {|it| docker rm $it}
  docker images -a -q | lines | each {|it| docker rmi $it -f}
  docker network prune -f
  # Would make sense to disinclude generic images - see zshrc
}

def taylor_business [] {
  cd ~/ts/in_progress/
  vim Kev_Nickells_-_Taylor_Swift_for_adults.tex
}

def jenkins [] {
  vivaldi-stable http://localhost:8080 | ignore
  ssh -L 8080:localhost:8080 jenkins
}

def git_add_commit_push [message: string] {
  let status = (git status -z | into string)
  echo $"adding / committing / pushing \n($status)"
  git add .
  git commit -m $message
  git push
}

def list_by_project [project: string] {
  ultralist list | ^grep $project
}

# show todo on startup
ultralist l

# show available updates on startup
# echo $"(ansi y)(checkupdates | length) updates available(ansi reset)"

# you know what it is
alias vim = nvim

# nu-specific
alias nuconf = vim ~/.nu_config.nu

# alias update_nu = source ~/.nu_config.nu
alias showconf = open ~/.nu_config.nu
alias nunotes = vim ~/nu_shell_stuff/notes.nu

# for angular local server with latest ssl

#let-env NODE_OPTIONS = --openssl-legacy-provider;

# copied from zsh config

alias work = cd ~/RAP
alias Z = exit
alias gst = git status
alias ngs = ng serve
alias ngso = ng serve --open
alias gb = git branch -a
alias gc = git_add_commit_push # hoisting!

# new to nu

alias ts = taylor_business
alias dcl = docker_clean
alias dcu = docker-compose up
alias dps = docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}'

#notify when command is complete
alias cmpl = command_complete
alias hist = search_history
alias killl = shutdown now
alias restart = reboot
alias flash = vim ~/flash-card/terms.json
alias gbr = ~/branches.sh


# show todos
alias td = ultralist list

# add to do
alias tda = ultralist add

# annotate todo
alias tdan = ultralist addnote

# delete from list
alias tdd = ultralist delete

# mark complete
alias tdc = ultralist complete

# prioritise down
alias tdo = ultralist up

# prioritise up
alias tdu = ultralist prioritize

# list by project
alias tdp = list_by_project
