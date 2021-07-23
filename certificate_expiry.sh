#!/usr/bin/env bash
set -eu -o pipefail
RED='\033[0;31m'
domains=/path-to/domains.txt

while read line; do
   echo "checking if $line expires in less than 7 days"
   expires=$(date -d "$(curl -ILkv --stderr - "$line" | grep  "expire date" | awk '{print $5 $6 $7}')" '+%s')
   target=$(date -d "+7 days" '+%s')
   #target=1721714966
   #echo "target is $target"
   #echo $expires
   if [ "$target" -gt "$expires" ]
   then
     echo "$RED certificate expires in lees than 7 days on $(date -d @$expires '+%Y-%m-%d') $NOCOLOR";
   fi
done<$domains
