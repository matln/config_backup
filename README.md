# vimrc_backup

* `git clone git@github.com:matln/vimrc_backup.git ~/vimrc_backup`

* vim
    ```shell
    cp ~/vimrc_backup/vimrc ~/.vimrc
    ```

* neovim
    ```shell
    cp ~/vimrc_backup/init.vim ~/.init.vim
    ln -s ~/.init.vim ~/.config/nvim/init.vim
    ```

* coc-settings.json
    ```shell
    cp ~/vimrc_backup/coc-settings.json ~/.config/nvim/coc-settings.json
    ```

* dracula.vim 
    ```shell
    # directory:
    # For neovim, stdpath('data') . '/plugged/dracula/autoload/lightline/colorscheme/dracula.vim'
    # e.x: ~/.local/share/nvim/plugged/...
    ```
