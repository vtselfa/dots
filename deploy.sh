find $(dirname $0) -path "*/.git/*" -prune -o -not -type d -a -not -name "LICENSE" -a -not -name "deploy.sh" -a -print | while read config; do
	target=$(echo "$config" | sed 's,^[^/]*/,,')
	if [ -e "$HOME/$target" ]; then
		echo "$HOME/$target file already exists, skipping"
	else
		echo "$HOME/$target"
		mkdir -p "$HOME/$(dirname $target)"
		ln -s "$(readlink -f $config)" "$HOME/$target"
	fi
done
