alias currbranch="ct catcs | head -1 | cut -f 2 -d \'"

alias lsbranches='(cd $WORKAREA; cleartool lstype -kind brtype -fmt "%[owner]p %[ACS]NSa %n %[TASK_STATE]NSa\n" | grep $USER | sort)'

alias cdtop="cd $WORKAREA/top/units/top/source/sc/tb/top_tb"

alias ct="cleartool"

alias lsco="cleartool lsco -avob -cview"

alias man="/usr/intel/bin/tman $* 2> /dev/null || /usr/bin/man $*"

alias updatedb_vp='updatedb --localpaths="$VP_SRC_DIRS" --output=$HOME/.vp.$SUBPROJECTNAME.$WORKSPACEID.db'

alias updatedb_as='updatedb --localpaths="$AS_SRC_DIRS" --output=$HOME/.as.$SUBPROJECTNAME.$WORKSPACEID.db'

alias locate_vp="locate -d $HOME/.vp.$SUBPROJECTNAME.$WORKSPACEID.db $*"

alias locate_as="locate -d $HOME/.as.$SUBPROJECTNAME.$WORKSPACEID.db $*"


function locate_as_vim {
    SELECTION=$(locate_as $* | grep '\.as' | fzf)
    if [ "x${SELECTION}" != "x" ]; then
        vim ${SELECTION}
    fi
}

function locate_vp_vim {
    SELECTION=$(locate_vp $* | fzf)
    if [ "x${SELECTION}" != "x" ]; then
        vim ${SELECTION}
    fi
}


# Functions to cd to unit, beh or tb
function cdunit() {
    cd $(locate_vp  -r ".*/units/$1/.*" | head -1 | cut -d/ -f 1-6)/$2
}
compdef '_arguments "1: :($(_cdunit))"' cdunit
function _cdunit() {
    locate_vp  "" | cut -d/ -f 6 | uniq
}

function cdbeh() {
    cdunit $1 "source/sc/beh/"
}
compdef cdbeh=cdunit

function cdtb() {
    cdunit $1 "source/sc/tb/"
}
compdef cdtb=cdunit


function gmake_lsf() {
    iwsubmit -eh_dispatch LS_INTERACTIVE_EXEC -eh_queue hwbatch -eh_os $($SWYTLM/etc/hostinfo) "/bin/bash -c 'gmake $*' "
}


function render_file() {
    ecdp render -v -c $WORKAREA/${1}/units/${1}_spec/source/xml/ecdp_cfg/ecdp_${1}_vp.cfg ${*:2}
}


function ctdiff() {
    filename=$(basename -- "$1")
    extension="${filename##*.}"
    vimdiff -c "windo set ft=${extension}" $1@@/main/$INTEGRATION_BRANCH/LATEST $1
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
    vimdiff -c 'windo set ft=$extension' $1@@/main/$INTEGRATION_BRANCH/$(currbranch)/LATEST $1
}


function ctbranch() {
    scwa -acs "VP_DEVELOP#HEAD" ${USER}_${SUBPROJECTNAME}_vp_$(date +%Y%m%d)_$1
}