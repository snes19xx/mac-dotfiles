#!/bin/zsh
# How do mac users deal with this horribly designed, piece of crap, unintuitive, and user-hostile operating system? 

# Dock: hidden, shows as soon as the pointer reaches the bottom edge
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.3
defaults write com.apple.dock mineffect -string scale
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock launchanim -bool false

# Mission Control: workspaces keep their order, windows grouped by app, no drag-to-top,
# no hot corners 
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock expose-group-apps -bool true
defaults write com.apple.dock enterMissionControlByTopWindowDrag -bool false
for c in tl tr bl br; do
  defaults write com.apple.dock wvous-$c-corner -int 1
  defaults write com.apple.dock wvous-$c-modifier -int 0
done
killall Dock

# Windows: drag-to-edge tiling stays on; the Option-drag variant is off because
# Option+drag moves windows (Easy Move+Resize); clicking the wallpaper leaves windows in place
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false
defaults write com.apple.WindowManager EnableTilingByEdgeDrag -bool true
defaults write com.apple.WindowManager EnableTopTilingByEdgeDrag -bool true
defaults write com.apple.WindowManager EnableTilingOptionAccelerator -bool false
defaults write com.apple.spaces spans-displays -bool true
defaults write NSGlobalDomain NSCloseAlwaysConfirmsChanges -bool true

# Finder: full path in the title, path and status bars, extensions shown,
# folders first, list view, new windows open home, search the current folder
# finder still sucks ass even after these tweaks. 
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
defaults write com.apple.finder NewWindowTarget -string PfHm
defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/"
defaults write com.apple.finder FXDefaultSearchScope -string SCcf

# I like my desktop clean: no file or drive icons
defaults write com.apple.finder CreateDesktop -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
defaults write com.apple.WindowManager StandardHideDesktopIcons -bool true
killall Finder

# Saved screenshots (Shift+PrtScr) go to ~/Pictures/Screenshots, not the Desktop
# why do mac users like cluttering their desktop so much? It's a terrible idea.
mkdir -p ~/Pictures/Screenshots
defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"
killall SystemUIServer

# Fast key repeat (~33/s after 375 ms); held letters repeat, no accent popup
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 25
defaults write -g ApplePressAndHoldEnabled -bool false

# No ._ files on USB/exFAT drives
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Spotlight on Option+R (SUPER + R after the Karabiner swap)
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>114</integer><integer>15</integer><integer>524288</integer></array><key>type</key><string>standard</string></dict></dict>"
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

# Easy Move+Resize: Option [SUPER(win) key] + drag moves, + right-drag resizes
defaults write org.dmarcotte.Easy-Move-Resize ModifierFlags -string "ALT"

# Never sleep
sudo pmset -a sleep 0 disksleep 0 autorestart 1 womp 1
