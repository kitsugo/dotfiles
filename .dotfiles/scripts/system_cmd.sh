#!/bin/sh
# Portable system commands with timeout, notifications and naive locking capability
. "$HOME/.dotfiles/scripts/utils.sh"

if mkdir "/tmp/system_cmd.lock.d"; then
	case "$1" in
	"lock-notifier") # Notify that system will lock shortly
		dunstify -i "$HOME"/.dotfiles/extra/images/lock.* -u low -a "Locker" "Session will be locking soon..."
		;;
	"lock") # Lock system via swaylock or xsecurelock. Remove lockfile to allow subsequent suspension
		rmdir "/tmp/system_cmd.lock.d/"
		if is_wayland; then
			swaylock -e -k -s fill -i "$XSECURELOCK_IMAGE_PATH" &
		else
			echo "Locking x " >>/tmp/debug.log
			xsecurelock
		fi
		;;
	"suspend-lock") # Lock and suspend / hibernate system after short timeout. Remove lockfile to allow subsequent suspension. swaylock will lock implicitly
		dunstify -i "$HOME"/.dotfiles/extra/images/sleep.* -u low -a "Locker" "Suspending in just a moment..."
		sleep 2
		rmdir "/tmp/system_cmd.lock.d/"
		(xsecurelock -- system_cmd.sh suspend) || system_cmd.sh suspend
		;;
	"hibernate-lock")
		dunstify -i "$HOME"/.dotfiles/extra/images/sleep.* -u low -a "Locker" "Hibernating in just a moment..."
		sleep 2
		rmdir "/tmp/system_cmd.lock.d/"
		(xsecurelock -- system_cmd.sh hibernate) || system_cmd.sh hibernate
		;;
	"reboot")
		dunstify -i "$HOME"/.dotfiles/extra/images/action.* -u low -a "Locker" "Rebooting in just a moment..."
		sleep 2
		systemctl reboot || shutdown -r now
		;;
	"poweroff")
		dunstify -i "$HOME"/.dotfiles/extra/images/action.* -u low -a "Locker" "Shuting down in just a moment..."
		sleep 2
		systemctl poweroff || shutdown -P now
		;;
	"suspend")
		echo "suspending.. " >>/tmp/debug.log
		systemctl suspend || loginctl suspend || zzz -z
		;;
	"hibernate")
		systemctl hibernate || loginctl hibernate || zzz -Z
		;;
	esac
	rmdir "/tmp/system_cmd.lock.d/"
fi
