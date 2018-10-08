THIS_DIR=$(dirname $(readlink -f "$0"))

for target_path in $THIS_DIR/home/*; do
  link_path=~/.$(basename $target_path)

  if [[ $target_path == *"install"* ]]; then
    echo "skipping $target_path"
    continue
  fi

  if [ -f $link_path ]; then
    echo "renaming $link_path -> $link_path.bak"
    mv $link_path $link_path.bak
  fi

  echo "symlink $link_path -> $target_path"
  ln -s $target_path $link_path

done

for target_path in $THIS_DIR/.config/*; do
  link_path=~/.config/$(basename $target_path)

  if [ -d $link_path ]; then
    echo "renaming $link_path -> $link_path.bak"
    mv $link_path $link_path.bak
  fi

  echo "symlink $link_path -> $target_path"
  ln -s $target_path $link_path
done

if [ ! -f $THIS_DIR/.config/nvim/init.vim ]; then
  echo "symlink $THIS_DIR/.config/nvim/init.vim -> $THIS_DIR/vimrc"
  ln -s $THIS_DIR/vimrc $THIS_DIR/.config/nvim/init.vim
fi

