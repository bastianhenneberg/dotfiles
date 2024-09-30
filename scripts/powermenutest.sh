#!/usr/bin/env bash

if [ x"$@" = x"Lock Screen" ]; then
  coproc (hyprlock >/dev/null 2>&1)
  exec 1>&-
  exit
fi

if [ x"$@" = x"Reboot" ]; then
  coproc (reboot >/dev/null 2>&1)
  exec 1>&-
  exit
fi

if [ x"$@" = x"Suspend" ]; then
  coproc (systemctl suspend-then-hibernate >/dev/null 2>&1)
  exec 1>&-
  exit
fi

if [ x"$@" = x"Log Out" ]; then
  coproc (hyprctl dispatch exit >/dev/null 2>&1)
  exec 1>&-
  exit
fi

if [ x"$@" = x"Shutdown" ]; then
  coproc (poweroff >/dev/null 2>&1)
  exec 1>&-
  exit
fi

echo -en "Lock Screen\0icon\x1ffolder\x1finfo\x1ftest\n"
echo -en "Suspend\0icon\x1ffolder\x1finfo\x1ftest\n"
echo -en "Log Out\0icon\x1ffolder\x1finfo\x1ftest\n"
echo -en "Reboot\0icon\x1ffolder\x1finfo\x1ftest\n"
echo -en "Shutdown\0icon\x1ffolder\x1finfo\x1ftest\n"
