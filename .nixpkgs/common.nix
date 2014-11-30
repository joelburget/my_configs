{pkgs}:
with pkgs; rec {
  vimrcConfig = {
        vam.knownPlugins = vimPlugins; # optional
        vam.pluginDictionaries = [
#check ftdetect bug
            { names = [ 
                "ghcmod" 
                "haskellconceal"
                "hoogle"
                "lushtags"
                "neco-ghc"

                "idris-vim"

                "vim-addon-nix"

                "rust"
                "racer"

                "a"
                "airline"
                "calendar"
                "colors-solarized"
                "ctrlp"
                "easy-align"
                "easymotion"
                "fugitive"
                "gist-vim"
                "gitgutter"
                "hardtime"
                "hier"
                "latex-box"
                "latex-live-preview"
                "nerdcommenter"
                "nerdtree"
                "quickfixstatus"
                "quickrun"
                "rainbow_parentheses"
                "shabadou"
                "signature"
                "surround"
                "table-mode"
                "tabmerge"
                "tagbar"
                "taglist"
                "thumbnail"
                "undotree"
                "vimproc"
                "vim-snippets"
                "vundle"
                "watchdogs"
                "webapi-vim"
                "YUNOcommit"
                "youcompleteme"
            ];}
        ];

        customRC = ''
            set history=700
            set confirm
            set cindent
            set t_Co=256

            autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

            set hidden
            vmap <Enter> <Plug>(EasyAlign)
            nmap s <Plug>(easymotion-s2)
            map  / <Plug>(easymotion-sn)
            omap / <Plug>(easymotion-tn)
            map  n <Plug>(easymotion-next)
            map  N <Plug>(easymotion-prev)

            let g:calendar_google_calendar = 1
            let g:calendar_google_task = 1

            let g:gist_clip_command = 'xclip -selection clipboard'
            let g:gist_detect_filetype = 1
            let g:gist_use_password_in_gitconfig = 1

            let NERDTreeShowHidden=1
            let NERDTreeQuitOnOpen=1
            let g:necoghc_enable_detailed_browse = 1

            let g:YUNOcommit_after = 20

            au VimEnter * RainbowParenthesesToggle
            au Syntax * RainbowParenthesesLoadRound
            au Syntax * RainbowParenthesesLoadSquare
            au Syntax * RainbowParenthesesLoadBraces

            let g:airline_enable_branch=1
            let g:airline_enable_syntastic=1
            let g:airline_theme='dark'
            let g:airline_left_sep = '▶'
            let g:airline_right_sep = '◀'
            let g:airline_linecolumn_prefix = '¶ '
            let g:airline_branch_prefix = '⎇ '
            let g:airline_paste_symbol = 'ρ'
            let g:airline_detect_modified=1
            let g:airline_detect_paste=1

            " How many lines should be searched for context
            let g:hasksyn_indent_search_backward = 100

            " Should we try to de-indent after a return
            let g:hasksyn_dedent_after_return = 1

            " Should we try to de-indent after a catchall case in a case .. of
            let g:hasksyn_dedent_after_catchall_case = 1

            let tagbar_autofocus=1
            let tagbar_autoclose=1

            let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
            autocmd FileType c let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/c/ycm/.ycm_extra_conf.py'
            let g:ycm_semantic_triggers =  {
            \   'c' : ['->', '.'],
            \   'cpp' : ['->', '.', '::'],
            \   'objc' : ['->', '.'],
            \   'ocaml' : ['.', '#'],
            \   'cpp,objcpp' : ['->', '.', '::'],
            \   'perl' : ['->'],
            \   'php' : ['->', '::'],
            \   'cs,java,javascript,d,vim,python,perl6,scala,vb,elixir,go' : ['.'],
            \   'ruby' : ['.', '::'],
            \   'lua' : ['.', ':'],
            \   'erlang' : [':'],
            \ }
            nnoremap <C-E> <ESC>:YcmCompleter GoToDefinitionElseDeclaration<CR>
            let g:ctrlp_map = '<c-p>'
            let g:ctrlp_cmd = 'CtrlPMixed'
            let g:ctrlp_working_path_mode = 'ra'
            set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

            autocmd BufRead,BufNewFile ~/.xmonad/* call s:add_xmonad_path()
            function! s:add_xmonad_path()
            if !exists('b:ghcmod_ghc_options')
                let b:ghcmod_ghc_options = []
            endif
            call add(b:ghcmod_ghc_options, '-i' . expand('~/.xmonad/lib'))
            endfunction

            let g:solarized_termcolors=256
            colorscheme solarized "desert
            "colorscheme desert
            set background=dark

            let g:racer_cmd = "racer"
            let g:racer_experimental_completer = 1

            exec 'source '.fnameescape($HOME.'/.vimrc')
        '';
        };
        my_vim = vim_configurable.customize { name = "vim"; inherit vimrcConfig; };
      vimEnv = buildEnv { 
        name = "vim-env";
        ignoreCollisions = true;
        paths = [
            my_vim
            racerRust
            haskellPackages.stylishHaskell
            astyle
          ];
      };

      emacsEnv = buildEnv {
        name = "emacs-env";
        ignoreCollisions = true;
        paths = [
            emacs
            emacs24Packages.colorThemeSolarized
            emacs24Packages.haskellMode
            emacs24Packages.structuredHaskellMode
        ];
      };

      hugeEnv = buildEnv {
        name = "huge-env";
        ignoreCollisions = true;
        paths = [
            chromiumDev
            gimp
            inkscape
            libreoffice
        ];
      };

      steamEnv = buildEnv {
        name = "steam-env";
        ignoreCollisions = true;
        paths = [
            steam
            steamChrootEnv
        ];
      };

      baseEnv = buildEnv {
        name = "base-env";
        ignoreCollisions = true;
        paths = [ 
            aspell
            aspellDicts.en
            aspellDicts.ru
            bc
            defaultStdenv
            djview4
            dropbox
            dwb
            evince
            file
            flac
            flashplayer
            freetype
            gajim
            dejavu_fonts
            gnome.zenity
            gnupg
            gparted
            iftop
            lastfmsubmitd
            libnotify
            lm_sensors
            mirage
            moc
            mutt
            p7zip
            skype
            telnet
            termite
            tmux
            traceroute
            tree
            unrar
            vlc
            weechat
            wine
            winetricks
            wmname
            xclip
            xlibs.xev
            xlibs.xprop
            xfce.xfce4notifyd
            xfce.xfce4terminal
        ];
      };

      myHs = haskellPackages.ghcWithPackagesOld (
        pkgs: with pkgs; [ 
            /*lushtags*/
            Agda
            cabal2nix
            cabalInstall
            ghcMod
            haddock
            hlint
            hoogle
            hoogleLocal
            taffybar
            xmobar
            xmonad
            xmonadContrib
        ]);

      hsEnv = buildEnv {
        name = "haskell-env";
        ignoreCollisions = true;
        paths = [
            myHs
        ];
      };

      develEnv = pkgs.buildEnv {
        name = "development-env";
        ignoreCollisions = true;
        paths = [
            /*ctags*/
            /*zlib*/
            androidsdk_4_4
            automake
            cargoSnapshot
            clang
            cmake
            freeglut
            gcc
            gnumake
            idea.idea-community
            jdk
            manpages
            mercurial
            mesa
            mysql
            mysqlWorkbench
            pciutils
            pkgconfig
            python
            python27
            python33
            rustc
            smartmontools
            sqlite
            subversion
            wireshark
            xlibs.libX11
        ];
      };
}