#!/bin/sh
now=$(date +"%d.%m.%Y")
host= "yourhost"
user="youruser"
password="yourpassword"
port="23"
zippw="yourzippassword"
DockerID="yourdockerid"
deldate=$(date -d "14 days ago" +"%d.%m.%Y")
backupdir="yourbackupdir"

# Stopt Docker Container
docker stop $DockerID
#Create ZIP Archive
zip -P $zippw -r $now.zip $backupdir
#Move ZIP Archive to Backup Server
sshpass -p $password scp -r $now.zip $user@$host:/$now.zip
#Delete ZIP Archive on Server and Host
sshpass -p $password ssh -p $port $user@$host rm $deldate.zip
rm $now.zip
# Startet Docker Container
docker start $DockerID