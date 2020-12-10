#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    42recovery.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: abarthel <abarthel@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/02/14 13:56:36 by abarthel          #+#    #+#              #
#    Updated: 2019/02/14 13:56:36 by abarthel         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

function display_header ()
{
	printf "\e[38;5;22m                       .8 \n"
	printf "\e[38;5;28m                     .888\n"
	printf "\e[38;5;2m                   .8888\'\n"
	printf "\e[38;5;40m                  .8888\'\n"
	printf "\e[38;5;82m                  888\'\n"
	printf "\e[38;5;154m                  8\'\n"
	printf "\e[38;5;190m     .88888888888. .88888888888.\n"
	printf "\e[38;5;226m   .8888888888888888888888888888888.\n"
	printf "\e[38;5;220m .8888888888888888888888888888888888.\n"
	printf "\e[38;5;214m.&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&\'          \e[38;5;118m42 SESSION RECOVERING\n"
	printf "\e[38;5;208m&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&\'\n"
	printf "\e[38;5;202m&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&\'            \e[38;5;7mSet back user environment,\n"
	printf "\e[38;5;196m@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:             \e[38;5;7mincluding: \e[38;5;118m.vimrc\e[38;5;7m,\n"
	printf "\e[38;5;196m@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:             \e[38;5;118mBash\e[38;5;7m and \e[38;5;118mMacOS graphical\n"
	printf "\e[38;5;196m@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:             \e[38;5;118menvironment\e[38;5;7m.\n"
	printf "\e[38;5;197m%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.\n"
	printf "\e[38;5;198m%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.           \e[38;5;26mauthor: \e[38;5;7mabarthel  \e[38;5;26mupdate: \e[38;5;7m2020-02-18\n"
	printf "\e[38;5;201m\`%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.\n"
	printf "\e[38;5;129m \`00000000000000000000000000000000000\'\n"
	printf "\e[38;5;93m  \`000000000000000000000000000000000\'\n"
	printf "\e[38;5;57m   \`0000000000000000000000000000000\'\n"
	printf "\e[38;5;21m     \`###########################\'\n"
	printf "\e[38;5;18m       \`#######################\'\n"
	printf "\e[38;5;17m         \`#########\'\'########\'\n"
	printf "           \`\"\"\"\"\"\"\'  \`\"\"\"\"\"\'\n"
	printf "\n\e[38;5;7m"
}

function update_bash ()
{
	rm -rf $HOME/.brew \
	&& git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew \
	&& export PATH=$HOME/.brew/bin:$PATH \
	&& brew update \
	&& brew install bash
}

function restore_settings ()
{
	# Require password
	defaults write com.apple.screensaver askForPassword -bool true

	# Change wallpaper
	#printf "Please enter the pathname of your Wallpaper: "
	#read wall_path
	#osascript -e 'tell application "Finder" to set desktop picture to POSIX file "'$wall_path'"'

	# Dark style
	defaults write -globalDomain AppleInterfaceStyle -string Dark

	# Show hidden files
	defaults write com.apple.finder AppleShowAllFiles -string YES

	# Mouse
	defaults write com.apple.driver.AppleHIDMouse Button2 -int 2 && defaults write com.apple.driver.AppleHIDMouse ButtonDominance -int 1
	defaults write -g com.apple.mouse.scaling -float 2
	defaults write -g com.apple.mouse.doubleClickThreshold -float 0.8
	defaults write -g com.apple.scrollwheel.scaling -float 0.75

	# Keyboard repeat speed and delay
	defaults write -g KeyRepeat -int 2 && defaults write -g InitialKeyRepeat -int 15

	# Dock size & Magnification
	defaults write com.apple.dock tilesize -int 45
	defaults write com.apple.dock magnification -bool true
	defaults write com.apple.dock largesize -int 55
	defaults write com.apple.dock autohide -bool true

	# WIFI disable
	networksetup -setairportpower $(networksetup -listallhardwareports | sed -n /Wi-Fi/,/Ethernet/p | grep "Device" | cut -d " " -f2) off

	# Bluetooth enable if you are using a Bluetooth Headphone
	#defaults write com.apple.systemuiserver NSStatusItem\ Visible\ com.apple.menuextra.bluetooth -bool false
	#defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"

	# iTerm in Dock Icons
	defaults write com.apple.dock persistent-apps -array "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/iTerm.app/</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
	for app in "Dock" "Finder"
	do
		killall "${app}" > /dev/null 2>&1
	done
}

function setall ()
{
	cat .vimrc >> ~/.vimrc
	update_bash && echo 'PS1="\e[38;5;227m\s\v \e[38;5;44m\W \e[38;5;7m"' >> ~/.bashrc && cat setuser.sh >> ~/.bashrc
	restore_settings
}

display_header
setall

printf "\e[38;5;185mDone.\e[38;5;7m\n"
