#!/usr/bin/env bash
#https://naftuli.wtf/2017/12/28/systemd-user-environment/
#https://wiki.archlinux.org/title/Systemd/User#Environment_variables

dbus-update-activation-environment --systemd --all ||
	systemctl --user import-environment

systemctl --user start user-graphical-login.target
