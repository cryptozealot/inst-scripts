#!/bin/bash

#Usage ./hammer {total requests to make} {delay between requests in s} {endpoint} {method - PUT,GET, etc..}
#Example ./hammer 50 0.5 http://ratings/api/rate/RD-10/3 PUT

times=$1
sleeptime=$2
endpoint=$3
method=$4
i=0
while [ $i -le $times ]
do
        i=$(($i+1))
        curl -X $method $endpoint
        sleep $sleeptime
done
