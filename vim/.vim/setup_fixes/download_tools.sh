get_latest_release() {
    wget  $(curl "https://api.github.com/repos/$1/releases/latest" | \
        awk -F\" '/x86_64-unknown-linux-musl/{if($0 ~ "browser_download_url") print $4}')
}

get_latest_release BurntSushi/ripgrep
get_latest_release sharkdp/fd

tar xf ripgrep-*.tar.gz
tar xf fd-*.tar.gz

mkdir -p $HOME/bin
ln -s $(pwd)/ripgrep-*/rg $HOME/bin
ln -s $(pwd)/fd-*/fd $HOME/bin
ln -s $HOME/.fzf/bin/fzf $HOME/bin
