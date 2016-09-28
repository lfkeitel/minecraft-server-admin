#Minecraft Server Admin

This is a framework/toolset to manage multiple Minecraft server instances. The purpose was to make management relatively painless and provide each server with customization. Everything is handled through a single script called `minecraftctl`. This command could be wrapped and exposed through a web interface for people to manage their own servers.

##Setup

By default, the script expects everything to reside in `/srv/minecraft`. This can be overridden by setting an environment variable named `MCCTL_BASE_DIR`.

1. Install Java
2. Install Screen
2. Clone this repo in `/srv/minecraft` (or what ever directory you want)
3. Download a Minecraft Server jar file into the `jars` folder
4. Create a new server
5. Start the new server

```
$ mkdir -p /srv/minecraft
$ cd /srv/minecraft
$ git clone git@github.com:lfkeitel/minecraft-server-admin.git .
$ ./bin/minecraftctl create ServerName
$ ./bin/minecraftctl start ServerName
```

##Usage

`minecraftctl` has the following commands:

- `minecraftctl create [servername]`
- `minecraftctl backup [servername] daily|hourly`
- `minecraftctl start [servername]`
- `minecraftctl stop [servername]`
- `minecraftctl restart [servername]`
- `minecraftctl send [servername] "command to send to server"`

##What's say-time.sh?

`say-time.sh` is a script that will send the current time to the given Minecraft server and print it in the chat. I find it helpful because I typically play in fullscreen and can't see the time on my computer. You can setup a cron job that will call `say-time.sh [servername]` at regular intervals. I have mine set to every half hour.

##TODO

- [ ] Add a `status` command that will show the status of a given server, or all servers.
- [ ] Provide the ability to op, whitelist, and configure a server without manually editing the server files.
- [ ] Use a template for server.properties.
- [ ] Ask if the user wishes to accept the EULA.
- [ ] Add a `delete` command.
- [ ] Add a `download` command to get a Minecraft server version.
- [ ] Clean up the `backup_server` function.
