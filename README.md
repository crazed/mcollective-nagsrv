This is an mcollective version of the nagsrv tool provided in [ruby-nagios](https://github.com/ripienaar/ruby-nagios). The command line options for selecting hosts should be the same with the addition of finding services that have been acknowledged.


## Configuration

You need the following added to your server.cfg:

    plugin.nagsrv.status_log = /var/icinga/status.dat
    plugin.nagsrv.command_file = /var/icinga/rw/icinga.cmd

Of course these need to be set to where your status file and command file are located.

## Examples

List out acknowledged services:

    $ mco nagsrv show-acknowledged

     * [ ============================================================> ] 1 / 1

    ops-monitor01.ma01.foo.net       OK
    prod-wordpress02.ma01.foo.net
      Puppet
        ggalitz: need to migrate shared storage to coraid

    ops-oscontroller01.nyc02.foo.net
      OpenStack Nova Services
        afeid: this is in beta mode

Acknowledge all services with puppet in the name:

    $ mco nagsrv acknowledge some reason --with-service /Puppet/
    Determining the amount of hosts matching filter for 2 seconds .... 1

     * [ ============================================================> ] 1 / 1

    ops-monitor01.ma01.foo.net       OK
    [1349990190] ACKNOWLEDGE_SVC_PROBLEM;prod-mogilefstracker02.tx01.foo.net;Puppet;1;0;1;afeid;some reason
