#!/bin/bash

#Usage ./hammerUP.sh {sessions ammount} {total requests to make} {delay between requests in s} {endpoint} {method - PUT,GET, etc..}
#Example ./hammerUP.sh 5 50 0.5 http://ratings/api/rate/RD-10/3 PUT

screens=$1
times=$2
sleeptime=$3
endpoint=$4
method=$5
i=0
while [ $i -le $screens ]
do
        screen -d -m -s $i ./hammer.sh $times $sleeptime $endpoint $method
        i=$(($i+1))
done
