#!/bin/sh
##---------------------
## This script restores the original state of /opt/activemq-02,
## copies all files and directories from /execution-core-container-02 to /opt/activemq-02
## and starts Apache ActiveMQ with configuration file /opt/activemq-02/conf/activemq.xml.
##---------------------

print_usage() {
    echo "Usage" `basename "$0"` "[OPTIONS]"
    echo
    echo "Options:"
    echo "  -d, --delete-activemq-02-data   If set all content of the data directory of"
    echo "                                 ActiveMQ (e.g. /opt/activemq-02/data) will be"
    echo "                                 removed on startup."
    echo "  -h --help                   display this help text and exit"
}

set -e #Exit immediately if a command exits with a non-zero status.

if [ $# -gt 1 ] ; then
    echo "Too many arguments (max 1)!"
    exit 1
elif [ "$1" = "--help" ] || [ "$1" = "-h" ] ; then
    print_usage
    exit
else
    #restore original state of activemq home directory but keep data and copy activemq config files
    rsync -a --checksum --force --exclude=data /execution-core-container-02/ /opt/.activemq-02_bak/ /opt/activemq-02/
    if [ "$1" = "--delete-activemq-02-data" ] || [ "$1" = "-d" ] ; then
        #restore original state of activemq data directory
        rsync -a --checksum --delete --force /opt/.activemq-02_bak/data/ /opt/activemq-02/data/
    fi
fi

#run activemq
exec /opt/activemq-02/bin/activemq console xbean:conf/activemq.xml