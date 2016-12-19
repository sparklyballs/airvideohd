![Air Video Server HD Logo](http://inmethod.com/airvideohd/images/icon@2x.png)

This is an Unofficial Docker container for InMethod's Air Video Server HD based on freely available Linux binaries at [http://www.inmethod.com](http://www.inmethod.com)

# madcatsu/airvideohd

[![](https://images.microbadger.com/badges/version/madcatsu/airvideohd.svg)](https://microbadger.com/images/madcatsu/airvideohd "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/madcatsu/airvideohd.svg)](https://microbadger.com/images/madcatsu/airvideohd "Get your own image badge on microbadger.com")[![](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://hub.docker.com/r/madcatsu/airvideohd/builds/)

Air Video HD allows you to watch videos streamed instantly from your computer on your iPhone, iPad, iPod touch or Apple TV.

### Usage

```
docker create --name=<container name> \
-e PUID=<host user ID> \
-e PGID=<host group ID> \
-v </path/to/your/videos>:/media \
-v </path/to/your/persistent/config/folder>:/config \
-v </path/to/your/scratch/disk/for/transcoding>:/transcode \
-p 5353:5353/udp \
-p 45633:45633 \
-p 45633:45633/udp
```

**Transcoding:** It's worthwhile noting that if you expect ideal performance for transcoding of videos from one format to those natively supported on your iOS device, the transcoding folder should be placed on storage that is suitable for this purpose. Flash or RAM disk are ideal but not necessary, so expect your mileage to vary depending on the source video quality.

### User / Group Environment Variables
As this Docker container is built on the existing Ubuntu Xenial image created by the [Linuxserver.io](https://www.linuxserver.io/) team, the built in s6-overlay supervisor and init system allows users to specify a user and group from the Docker host machine to run the in-container processes and access any bind mounts on the host without messing up permissions which can easily occur when processes in a container run as "root".

The container avoids this issue by allowing users to specify an existing Docker host user account and group with the `PUID` and `PGID` environment variables. To lookup the User and Group ID of the Docker host user account, enter the following command in the CLI on the Docker host as below:

```
    $ id <username>
    uid=1000(username) gid=1000(usergroup) groups=1000(usergroup),27(sudo) ... etc
```

### Configuration
After the container has run for the first time, a configuration file `Server.properties` is created in the `/config` bind mounted folder on the Docker host. Using a text editor of choice, the default settings can be modified to allow multiple authenticated users to connect to Air Video Server HD with password security and if desired, folder isolation. Once changes to the file are saved, the container should be restarted to commit these to the running container configuration.

Also, note that during service init, the Server properties are updated to set the name of the Air Video Server to the container name.

**Caution:** _This properties file could be opened by anyone unless you set the appropriate umask on the file so that only the account that the container runs the service as has access. Passwords here are stored in clear text, you have been warned._

#### Example Configuration - Single User with no password

Edit Server.properties and replace the Sharing section with the following entries:

```
#
# Sharing settings
#

# First shared folder
sharedFolders1.displayName = Movies
sharedFolders1.path = /media/Movies

# Second shared folder
sharedFolders2.displayName = TV Shows
sharedFolders2.path = /multimedia/TV\ Shows

# multiuser mode (true/false)
multiUserMode = false

# single user mode password
singleUserPassword =
```

#### Example Configuration - Single User with password

Edit Server.properties and replace the Sharing section with the following entries:

```
#
# Sharing settings
#

# First shared folder
sharedFolders1.displayName = Movies
sharedFolders1.path = /media/Movies

# Second shared folder
sharedFolders2.displayName = TV Shows
sharedFolders2.path = /multimedia/TV\ Shows

# multiuser mode (true/false)
multiUserMode = false

# single user mode password
singleUserPassword = 1q2w3e4r <---- change this!
```

#### Example Configuration - Multiple Users with password

Edit the Server.properties and replace the Sharing section with the following entries:

```
#
# Sharing settings
#

# First shared folder
sharedFolders1.displayName = Movies
sharedFolders1.path = /media/Movies

# Second shared folder
sharedFolders2.displayName = TV Shows
sharedFolders2.path = /multimedia/TV\ Shows

# Third shared folder
sharedFolders3.displayName = Training
sharedFolders3.path = /multimedia/Training

# multiuser mode (true/false)
multiUserMode = true

# First user account (can access all folders)
userAccounts1.accessAllFolders = true
# userAccounts1.allowedFolders =
userAccounts1.userName = tom
userAccounts1.password = cat <---- change this!

# Second user account (can access selected folders)
userAccounts2.accessAllFolders = false
userAccounts2.allowedFolders1 = 1
# userAccounts2.allowedFolders2 = 2
userAccounts2.userName = richard
userAccounts2.password = third <---- change this!

# Third user account (can access selected folders)
userAccounts3.accessAllFolders = false
userAccounts3.allowedFolders1 = 2
userAccounts3.allowedFolders2 = 3
userAccounts3.userName = harry
userAccounts3.password = potter <---- change this!
```

### TODO
We'd like to improve this container further so we've listed here a couple of future Roadmap items under consideration:

+ Version specification - Choose the latest or a specific numbered version of the Air Video Server HD binary to run
+ Share creation via ENV - Setup one or more media folders with open or limited access using environment vars

#### Thanks
This work is largely based off the existing projects put together by the Linuxserver.io guys. Go buy them a beer!
