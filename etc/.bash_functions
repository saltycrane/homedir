echo "sourcing ~/etc/.bash_functions..." 1>&2

function virt() {
    set -e
    virtualenv venv;
    # this is for emacs projectile
    pushd venv; git init; popd;
    . venv/bin/activate;
}
