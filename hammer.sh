!/bin/bash

#Usage ./hammer {total requests to make} {delay between requests in s} {endpoint}
#Example ./hammer 50 0.5 http://ratings/api/rate/RD-10/3

times=$1
sleeptime=$2
endpoint=$3
i=0
while [ $i -le $times ]
do
        i=$(($i+1))
        curl -X PUT $endpoint
        sleep $sleeptime
done
