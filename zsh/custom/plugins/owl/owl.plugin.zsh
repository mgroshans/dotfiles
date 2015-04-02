export OWL=/Users/mgroshans/Projects/owl
function owl() {
    unset -f owl
    eval "$(/Users/mgroshans/Projects/owl/bin/owl init -)"
    owl "$@"
}
