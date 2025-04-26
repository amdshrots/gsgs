# Disable Spotlight indexing
sudo mdutil -i off -a

# Create new user
sudo dscl . -create /Users/runneradmin
sudo dscl . -create /Users/runneradmin UserShell /bin/bash
sudo dscl . -create /Users/runneradmin RealName "Runner Admin"
sudo dscl . -create /Users/runneradmin UniqueID 1001
sudo dscl . -create /Users/runneradmin PrimaryGroupID 80
sudo dscl . -create /Users/runneradmin NFSHomeDirectory /Users/runneradmin
sudo dscl . -passwd /Users/runneradmin kaiden
sudo createhomedir -c -u runneradmin > /dev/null

# Enable VNC
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -specifiedUsers
echo -n "kaiden" | perl -we 'BEGIN { @k = unpack "C*", pack "H*", "1734516E8BA8C5E2FF1C39567390ADCA"}; $_ = <>; chomp; s/^(.{8}).*/$1/; @p = unpack "C*", $_; foreach (@k) { printf "%02X", $_ ^ (shift @p || 0) }; print "\n"' | sudo tee /Library/Preferences/com.apple.VNCSettings.txt
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -users runneradmin -access -on -privs -all -clientopts -setvnclegacy -vnclegacy yes -clientopts -setvncpw -vncpw kaiden

# Enable Remote Management
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -users runneradmin -privs -all -restart -agent -menu

# Install Brave Browser
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew install --cask brave-browser

# Create a reverse SSH tunnel
ssh -p 443 -R0:localhost:5900 -o StrictHostKeyChecking=no -o ServerAliveInterval=30 gtcxZbEfnfR+tcp@us.free.pinggy.io &

# Get the PINGGY URL
PINGGY_URL=$(ps aux | grep '[s]sh -p 443 -R0:localhost:5900' | awk '{print $NF}' | xargs -I{} curl -s {})
echo "Connect via: $PINGGY_URL"
