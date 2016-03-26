find $(dirname $0) -path "*/.git/*" -prune -o -not -type d -a -not -name "LICENSE" -a -not -name "deploy.sh" -a -print | while read config; do
	target=$(echo "$config" | sed 's,^[^/]*/,,')
	if [ -e "$HOME/$target" ]; then
		echo "$HOME/$target file already exists, skipping"
	else
		echo "$HOME/$target"
		mkdir -p "$HOME/$(dirname $target)"
		if [ -h $config ]; then
			cp -P "$config" "$HOME/$target"
		else
			ln -s "$(readlink -f $config)" "$HOME/$target"
		fi
	fi
done


if [ -d "$HOME/.tmux/plugins/tpm/.git" ]; then
	echo "$HOME/.tmux/plugins/tpm/.git already exists, skipping"
else
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
