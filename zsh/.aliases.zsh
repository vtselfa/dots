function vpcs()
{
    ag --color-match "1;31" --color-line-number "1;35" --color-path "1;34" --cpp --python --shell --mako --make -g "" $vp_source_dirs | grep $*
}

function vpcs()
{
    ag $* --color-match "1;31" --color-line-number "1;35" --color-path "1;34" --cpp --python --shell --mako --make $vp_source_dirs --pager less
}


# Use a sane git
alias git="/usr/intel/bin/git"


alias currbranch="ct catcs | head -1 | cut -f 2 -d \'"

alias cdtop="cd $WORKAREA/top/units/top/source/sc/tb/top_tb"
function gmake_lsf() {
    iwsubmit -eh_dispatch LS_INTERACTIVE_EXEC -eh_queue hwbatch -eh_os $($SWYTLM/etc/hostinfo) "/bin/bash -c 'gmake $*' "
}
alias ct="cleartool"
alias lsco="cleartool lsco -avob -cview"

function render_file() {
    ecdp render -v -c $WORKAREA/${1}/units/${1}_spec/source/xml/ecdp_cfg/ecdp_${1}_vp.cfg ${*:2}
}

#function vp_code_search() {
#    tcsh -c "code_search_vp $*"
#}

alias man="/usr/intel/bin/tman $* || /usr/bin/man $*"


# Checkin list of files with the same comment
function ctci() {
    for f in "${@:2}"; do
        cleartool ci -comment $1 $f
    done
}

# Checkout list of files with the same comment
function ctco() {
    for f in "${@:2}"; do
        cleartool co -comment $1 $f
    done
}

function ctdiff() {
    filename=$(basename -- "$1")
    extension="${filename##*.}"
    vimdiff -c 'windo set ft=$extension' $1@@/main/$INTEGRATION_BRANCH/LATEST $1 
}

function ctdiffco() {
    if [[ $# -eq 0 ]]; then
        files1=($(lsco | awk -F\" '/checkout/{printf("%s ", $2)}; END{printf("\n")}'))
    else
        files1=("${@:1}")
    fi
    files2=()

    for file in $files1; do
        files2+="${file}@@/main/$INTEGRATION_BRANCH/LATEST"
    done

    TEMP=$(mktemp)
    echo ":set diffopt=filler,vertical" > $TEMP
    echo ":edit ${files1[1]}" >> $TEMP
    echo ":diffsplit ${files2[1]}" >> $TEMP 
    echo ":wincmd w" >> $TEMP
    for ((i=1; i<${#files1}; i++)); do
        # Skip files that are equal
        cmp --silent ${files1[i]} ${files2[i]}
        if [ $? -eq 0 ]; then continue; fi
        echo ":tabe ${files1[i]}" >> $TEMP
        echo ":diffsplit ${files2[i]}" >> $TEMP
        echo ":wincmd w" >> $TEMP
    done
    cat  $TEMP
    gvim -s $TEMP
}

function ctdiffb() {
    filename=$(basename -- "$1")
    extension="${filename##*.}"
    vimdiff -c 'windo set ft=$extension' $1@@/main/$INTEGRATION_BRANCH/$(curr_branch)/LATEST $1 
}

function ctbranch() {
    scwa -acs "VP_DEVELOP#HEAD" ${USER}_${SUBPROJECTNAME}_vp_$(date +%Y%m%d)_$1
}


