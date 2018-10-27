PLUGGED=$HOME/.config/nvim/plugged

# Fix YouCompleteMe
YCM_DIR=$PLUGGED/YouCompleteMe
cp systemlibclang.patch  $YCM_DIR/third_party/ycmd/cpp/ycm
pushd $YCM_DIR/third_party/ycmd/cpp/ycm
patch < systemlibclang.patch 
pushd $YCM_DIR
CC=gcc CXX=g++ /usr/intel/pkgs/python2/2.7.14/bin/python ./install.py --clang-completer
popd
popd

# Fix fonts
cp fonts.patch $PLUGGED/fonts
pushd $PLUGGED/fonts
patch < fonts.patch
./install.sh
popd
