alias activate="source venv/bin/activate"

alias vlc="/Applications/VLC.app/Contents/MacOS/VLC -I rc"

alias jp="jq '.'"

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

alias global=". ~/git/btarricone/global-vpn-routing/venv/bin/activate && ~/git/btarricone/global-vpn-routing/add-global-routes.py && deactivate"
