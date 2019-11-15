Sample init scripts and service configuration for quartercoind
==========================================================

Sample scripts and configuration files for systemd, Upstart and OpenRC
can be found in the contrib/init folder.

    contrib/init/quartercoind.service:    systemd service unit configuration
    contrib/init/quartercoind.openrc:     OpenRC compatible SysV style init script
    contrib/init/quartercoind.openrcconf: OpenRC conf.d file
    contrib/init/quartercoind.conf:       Upstart service configuration file
    contrib/init/quartercoind.init:       CentOS compatible SysV style init script

Service User
---------------------------------

All three Linux startup configurations assume the existence of a "quartercoin" user
and group.  They must be created before attempting to use these scripts.
The OS X configuration assumes quartercoind will be set up for the current user.

Configuration
---------------------------------

At a bare minimum, quartercoind requires that the rpcpassword setting be set
when running as a daemon.  If the configuration file does not exist or this
setting is not set, quartercoind will shutdown promptly after startup.

This password does not have to be remembered or typed as it is mostly used
as a fixed token that quartercoind and client programs read from the configuration
file, however it is recommended that a strong and secure password be used
as this password is security critical to securing the wallet should the
wallet be enabled.

If quartercoind is run with the "-server" flag (set by default), and no rpcpassword is set,
it will use a special cookie file for authentication. The cookie is generated with random
content when the daemon starts, and deleted when it exits. Read access to this file
controls who can access it through RPC.

By default the cookie is stored in the data directory, but it's location can be overridden
with the option '-rpccookiefile'.

This allows for running quartercoind without having to do any manual configuration.

`conf`, `pid`, and `wallet` accept relative paths which are interpreted as
relative to the data directory. `wallet` *only* supports relative paths.

For an example configuration file that describes the configuration settings,
see `contrib/debian/examples/quartercoin.conf`.

Paths
---------------------------------

### Linux

All three configurations assume several paths that might need to be adjusted.

Binary:              `/usr/bin/quartercoind`  
Configuration file:  `/etc/quartercoin/quartercoin.conf`  
Data directory:      `/var/lib/quartercoind`  
PID file:            `/var/run/quartercoind/quartercoind.pid` (OpenRC and Upstart) or `/var/lib/quartercoind/quartercoind.pid` (systemd)  
Lock file:           `/var/lock/subsys/quartercoind` (CentOS)  

The configuration file, PID directory (if applicable) and data directory
should all be owned by the quartercoin user and group.  It is advised for security
reasons to make the configuration file and data directory only readable by the
quartercoin user and group.  Access to quartercoin-cli and other quartercoind rpc clients
can then be controlled by group membership.

### Mac OS X

Binary:              `/usr/local/bin/quartercoind`  
Configuration file:  `~/Library/Application Support/Quartercoin/quartercoin.conf`  
Data directory:      `~/Library/Application Support/Quartercoin`  
Lock file:           `~/Library/Application Support/Quartercoin/.lock`  

Installing Service Configuration
-----------------------------------

### systemd

Installing this .service file consists of just copying it to
/usr/lib/systemd/system directory, followed by the command
`systemctl daemon-reload` in order to update running systemd configuration.

To test, run `systemctl start quartercoind` and to enable for system startup run
`systemctl enable quartercoind`

### OpenRC

Rename quartercoind.openrc to quartercoind and drop it in /etc/init.d.  Double
check ownership and permissions and make it executable.  Test it with
`/etc/init.d/quartercoind start` and configure it to run on startup with
`rc-update add quartercoind`

### Upstart (for Debian/Ubuntu based distributions)

Drop quartercoind.conf in /etc/init.  Test by running `service quartercoind start`
it will automatically start on reboot.

NOTE: This script is incompatible with CentOS 5 and Amazon Linux 2014 as they
use old versions of Upstart and do not supply the start-stop-daemon utility.

### CentOS

Copy quartercoind.init to /etc/init.d/quartercoind. Test by running `service quartercoind start`.

Using this script, you can adjust the path and flags to the quartercoind program by
setting the QTCD and FLAGS environment variables in the file
/etc/sysconfig/quartercoind. You can also use the DAEMONOPTS environment variable here.

### Mac OS X

Copy org.quartercoin.quartercoind.plist into ~/Library/LaunchAgents. Load the launch agent by
running `launchctl load ~/Library/LaunchAgents/org.quartercoin.quartercoind.plist`.

This Launch Agent will cause quartercoind to start whenever the user logs in.

NOTE: This approach is intended for those wanting to run quartercoind as the current user.
You will need to modify org.quartercoin.quartercoind.plist if you intend to use it as a
Launch Daemon with a dedicated quartercoin user.

Auto-respawn
-----------------------------------

Auto respawning is currently only configured for Upstart and systemd.
Reasonable defaults have been chosen but YMMV.
