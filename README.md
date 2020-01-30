From [this Stack Overflow post](https://stackoverflow.com/questions/18197705/adding-your-vim-vimrc-to-github-aka-dot-files)

I have my ~/.vim directory under version control and my "real" vimrc (the one with all my settings) inside that directory, at ~/.vim/vimrc:

```
~/
---- .vim/
---- ---- (plugins and stuff)
---- ---- vimrc
---- .vimrc
```

My regular ~/.vimrc has only one line:
```

runtime vimrc
```
No need to create symlinks or whatever.

This is how I would push my config on a new machine where Git has already been installed:

```
$ cd
$ git clone git@github.com:romainl/dotvim.git .vim
$ echo "runtime vimrc" > .vimrc
```

What follows is the whole creation process. I assume that you have created an account and a repo named "vimconfig" on Github and tht you already have a lovingly crafted ~/.vimrc and a well organized ~/.vim/.

```
$ cd
$ mv .vimrc .vim/vimrc
$ echo "runtime vimrc" > .vimrc
$ cd .vim
$ git init
$ echo "This is my Vim config." > README
$ git add *
$ git commit -m "My Vim config is versioned."
$ git remote add origin https://github.com/username/vimconfig.git
$ git push origin master
```

At that point, you should have the same content on Github and in your local repository.

You manage that repository normally and push your commits when you are ready. Simple.

Note that the whole Github thing is only useful if you need/want to sync your config on multiple machines or, somehow need/want to share it with others. If you don't, there's no real point using GitHub at all.

(edit)

Vim 7.4 introduced a new, very useful, scheme: it looks for the usual ~/.vimrc and also for ~/.vim/vimrc so that's even less work for you:

```
$ cd .vim
$ git init
$ echo "This is my Vim config." > README
$ git add *
$ git commit -m "My Vim config is versioned."
$ git remote add origin https://github.com/username/vimconfig.git
$ git push origin master
```

Of course, the strategy I suggested initially is still valid if you have to deal with mixed Vim versions: Vim knows what to do and won't crap out in an endless loop.
a
