alias activate="source venv/bin/activate"

alias vlc="/Applications/VLC.app/Contents/MacOS/VLC -I rc"

alias ws='/Applications/Wireshark.app/Contents/MacOS/Wireshark "$@"&'

alias jp="jq '.'"

function scurl { curl -s -w "\nhttp status: %{http_code}\n" "$@" | awk '
    /^http status: [45][0-9]+/ {print "\033[31m" $0; next}
    /^http status: [0-9]+/ {print "\033[32m" $0; next}
    1 {print}
'; }
function jcurl { curl -s "$@" | jq '.'; }
function jcs { curl -s -w "\n%{http_code}\n" "$@" | jq '.' --color-output -C | awk '
    /^\033\[0m[45][0-9]+/ {sub(/\033\[0m/,""); print "\033[31m" $0; next}
    /^\033\[0m[0-9]+/ {sub(/\033\[0m/,""); print "\033[32m" $0; next}
    1 {print}
'; }

function venv() {
    if [ ! -d "venv" ]; then virtualenv venv; fi
    source venv/bin/activate
}

alias global='owl vpn add-global-routes "$@"'

alias fuck='$(thefuck $(fc -ln -1))'

# Set origin/HEAD with `git remote set-head origin [-a|<branch>]` if needed
function gpu() {
    current_branch=$(git rev-parse --abbrev-ref HEAD);
    default_branch=$(git rev-parse --abbrev-ref origin/HEAD | awk -F "/" '{print $NF}');
    if [ $current_branch != $default_branch ]; then
        git checkout $default_branch;
    fi
    git pull upstream $default_branch;
}

# Shows which files have changed compared to default branch
function gcf() {
    default_branch=$(git rev-parse --abbrev-ref origin/HEAD | awk -F "/" '{print $NF}');
    git --no-pager diff --name-only $default_branch;
}

# Git interactive rebase with default branch
function grb() {
    default_branch=$(git rev-parse --abbrev-ref origin/HEAD | awk -F "/" '{print $NF}');
    git rebase -i $default_branch;
}

# Git diff default branch
function gdm() {
    default_branch=$(git rev-parse --abbrev-ref origin/HEAD | awk -F "/" '{print $NF}');
    git diff $default_branch;
}

# Checkout last git branch
alias gcl="git checkout -"

# Clone repo and cd immediately
function gcd() {
    git clone "$@" && cd `basename "$1" .git`
}

function calc() {
    bc -l <<< "$@";
}

function change-realm() {
    export `owl change-realm "$@" | cut -d ' ' -f 2-`
    env=$(awk -F '-' '{print $NF}' <<< "$AWS_REALM")
    color=37
    if [[ $env == "dev" ]] ; then
        color=36
    elif [[ $env == "stage" ]] ; then
        color=33
    elif [[ $env == "prod" ]] ; then
        color=31
    fi
    echo -e "Changed realm to \033[0;${color}m$AWS_REALM"
}

function loadaws() {
    export `gpg -d ~/.credentials/$1.aws.gpg`
}

function unloadaws() {
    unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
}
