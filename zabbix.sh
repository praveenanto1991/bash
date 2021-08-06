#!/usr/bin/env bash
set -eu -o pipefail
RED='\033[0;31m'
GREEN='\033[0;32m'
NOCOLOR='\033[0m'
#host=$1
domains=/var/vcap/jobs/zabbix-server/helpers/domains.txt
expired=()
valid=()
function output(){
  if [[ ${expired[@]} ]]
  then
    echo "${expired[*]}"
  else
    echo "$valid"
  fi
}
while read line; do
   #echo "checking if certificate of $line expires in less than 7 days"
   expires=$(date -d "$(echo | openssl s_client -connect "$line":443 -servername "$line" 2>/dev/null | openssl x509 -text | grep -i 'Not After' | awk '{print $4,$5,$7}')" '+%s')
   target=$(date -d "+7 days" '+%s')
   #target=1721714966
   #echo "target is $target"
   #echo $expires
   if [ "$target" -gt "$expires" ]
   then
     expired+=("\"Certficate expires on ${line}\"")
   else
     valid+=("\"Certficate is ok on ${line}\"")
   fi
done<$domains
output

