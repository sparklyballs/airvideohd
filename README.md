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
-v </path/to/your/videos>:/multimedia \
-v </path/to/your/persistent/config/folder>:/config \
-v </path/to/your/scratch/disk/for/transcoding>:/transcode \
-p 5353:5353/udp \
-p 45633:45633 \
-p 45633:45633/udp
```

### User / Group Environment Variables
As this Docker container is built on the existing Ubuntu Xenial image created by the [Linuxserver.io](https://www.linuxserver.io/) team, the built in s6-overlay supervisor and init system allows users to specify a user and group from the Docker host machine to run the in-container processes and access any bind mounts on the hosts without messing up permissions which can easily occur when processes in a container run as "root".

The container avoids this issue by allowing users to specify an existing Docker host user account and group with the `PUID` and `PGID` environment variables. To lookup the User and Group ID of the Docker host user account, enter the following command in the CLI on the Docker host as below:

```
    $ id <username>
    uid=1000(username) gid=1000(usergroup) groups=1000(usergroup),27(sudo) ... etc
```

### Configuration
After the container has run for the first time, a configuration file `Server.properties` is created in the `/config` bind mounted folder on the Docker host. Using a text editor of choice, the default settings can be modified to allow multiple authenticated users to connect to Air Video Server HD with password security and if desired, folder isolation. Once changes to the file are saved, the container should be restarted to commit these to the running container configuration.

### TODO
We'd like to improve this container further so we've listed here a couple of future Roadmap items under consideration:
+ Version specification - Choose the latest or a specific numbered version of the Air Video Server HD binary to run
+ Share creation via ENV - Setup one or more multimedia folders with open or limited access using environment vars

#### Thanks
This work is largely based off the work already put together by the Linuxserver.io guys. Without their existing efforts I would have had a much harder time hacking this together. All praise to them for bringing Docker into the world of home and hobbyist computing.
