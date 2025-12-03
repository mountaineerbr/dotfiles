# dotfiles
Shell, terminal, and other configuration files


## SystemD

These are kept at
`~/.config/systemd/user/` or
`/etc/systemd/system/`.


### User

Contains [user services](user/) managed via `systemctl --user`, including:

*   **Wallpaper:** [_Timer_](user/wallpaper.timer) / [_Service_](user/wallpaper.service) pair to run the background update [script](user/wallpaper.sh).
*   **Conky:** [_Service file_](user/conky-session.service) to launch conkies and [_timer_](user/conky-restart.timer) hack for periodic restarts.



### System

Contains [system-wide services](system/), such as a [_tmux service file_](system/tmux@.service)
for launching it as a server, as described in the
[Tmux Arch Wiki](https://wiki.archlinux.org/title/Tmux#Autostart_with_systemd).



<!--
<br/>

![ScreenShot](https://gitlab.com/mountaineerbr/etc/-/raw/main/gfx/git_screenshot2.jpg)
  <br/>
  Fig 1. *My current desktop with conkies and the changing wallpaper of the Sun (from GOES).*
-->


<br/>

---

<!--

    :::::::-.      ...   ::::::::::::.-:::::'::: :::    .,:::::: .::::::. 
     ;;,   `';, .;;;;;;;.;;;;;;;;'''';;;'''' ;;; ;;;    ;;;;'''';;;`    ` 
     `[[     [[,[[     \[[,   [[     [[[,,== [[[ [[[     [[cccc '[==/[[[[,
      $$,    $$$$$,     $$$   $$     `$$$"`` $$$ $$'     $$""""   '''    $
      888_,o8P'"888,_ _,88P   88,     888    888o88oo,.__888oo,__88b    dP
      MMMMP"`    "YMMMMMP"    MMM     "MM,   MMM""""YUMMM""""YUMMM"YMmMY" 

-->

                   __  ___                  
     _______ ____ / /_/ _ |_    _____ ___ __
    / __/ _ `(_-</ __/ __ | |/|/ / _ `/ // /
    \__/\_,_/___/\__/_/ |_|__,__/\_,_/\_, / 
                                     /___/  
                            __       _                  ___     
      __ _  ___  __ _____  / /____ _(_)__  ___ ___ ____/ _ )____
     /  ' \/ _ \/ // / _ \/ __/ _ `/ / _ \/ -_) -_) __/ _  / __/
    /_/_/_/\___/\_,_/_//_/\__/\_,_/_/_//_/\__/\__/_/ /____/_/   
                                                            

