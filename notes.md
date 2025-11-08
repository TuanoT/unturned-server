# Install dependencies
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install -y steamcmd screen unzip lib32gcc-s1 lib32stdc++6

# Create Folders
mkdir -p ~/server ~/steamcmd
cd ~/steamcmd

# Install unturned in ~/servers
steamcmd +force_install_dir ~/server +login anonymous +app_update 1110390 validate +quit

# Link steam to where unturned expects it
mkdir -p ~/.steam/sdk64
ln -sf /usr/lib/steamcmd/linux64/steamclient.so ~/.steam/sdk64/steamclient.so

# Start server for the first time
./Unturned_Headless.x86_64 -logfile 2>&1 -batchmode -nographics +secureserver/"Test Server"

# Error
dlopen failed trying to load:
steamclient.so
with error:
steamclient.so: cannot open shared object file: No such file or directory
dlopen failed trying to load:
/home/tom/.steam/debian-installation/linux64/steamclient.so
with error:
/home/tom/.steam/debian-installation/linux64/steamclient.so: cannot open shared object file: No such file or directory
[S_API] SteamAPI_Init(): Sys_LoadModule failed to load: /home/tom/.steam/debian-installation/linux64/steamclient.so
