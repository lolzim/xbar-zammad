#!/bin/bash

#  <xbar.title>Zammad notifications counter</xbar.title>
#  <xbar.version>v1.0</xbar.version>
#  <xbar.author>Lol Zimmerli</xbar.author>
#  <xbar.author.github>lolzim</xbar.author.github>
#  <xbar.desc>Count zammad notifications and show green 0 if none, red + counter beep if more </xbar.desc>
#  <xbar.image></xbar.image>
#  <xbar.dependencies></xbar.dependencies>
#  <xbar.abouturl>b</xbar.abouturl>

# vars
URL='https://YOUR_ZAMMAD_FQDN/api/v1/online_notifications'
TOKEN='YOUR_ZAMMAD_TOKEN'

# API call & work on output
curl -s -H "Authorization: Token token=$TOKEN" $URL > /tmp/xbar.zammad.out
cat /tmp/xbar.zammad.out | jq '.[].seen' | grep -v true > /tmp/xbar.zammad.out.jq
NUM=`cat /tmp/xbar.zammad.out.jq | wc -l | xargs`

# Check for number, choosing color & system beep if red
if [ $NUM -lt 1 ]
then
    COLOR='✅'
else
    COLOR='$NUM ❌'
    say "Zammade"
    echo -en "\007"
fi

echo "Zam $COLOR"
