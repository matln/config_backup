# config_backup

* `$ git clone git@github.com:matln/config_backup.git ~/config_backup`

* vim
    ```shell
    $ mv  ~/.vimrc ~/.vimrc.backup
    $ cp ~/config_backup/vimrc ~/.vimrc
    ```

* neovim
    ```shell
    $ cp ~/config_backup/init.vim ~/.init.vim
    $ ln -s ~/.init.vim ~/.config/nvim/init.vim
    ```

* coc-settings.json
    ```shell
    $ cp ~/vimrc_backup/coc-settings.json ~/.config/nvim/coc-settings.json
    ```

* dracula.vim 
    ```shell
    # directory:
    # For neovim, stdpath('data') . '/plugged/dracula/autoload/lightline/colorscheme/dracula.vim'
    # e.x: ~/.local/share/nvim/plugged/...
    ```
