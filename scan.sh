AKUMULI_ENDPOINT=${AKUMULI_ENDPOINT:-"127.0.0.1"}


echo "Akumuli endpoint: $AKUMULI_ENDPOINT"


# Filter by value 1 thread
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Run scan query in one thread @ $timestamp"
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp0", "range": {"from": "20190501T000000", "to": "20190601T000000"}, "order-by": "series" }' | wc -l
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Completed @ $timestamp"
sleep 600


# Filter by value 10 threads
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Run filter query in 10 threads @ $timestamp"
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp0", "range": {"from": "20190501T000000", "to": "20190601T000000"}, "order-by": "series" }' | wc -l &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp1", "range": {"from": "20190501T000000", "to": "20190601T000000"}, "order-by": "series" }' | wc -l &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp2", "range": {"from": "20190501T000000", "to": "20190601T000000"}, "order-by": "series" }' | wc -l &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp3", "range": {"from": "20190501T000000", "to": "20190601T000000"}, "order-by": "series" }' | wc -l &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp4", "range": {"from": "20190501T000000", "to": "20190601T000000"}, "order-by": "series" }' | wc -l &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp5", "range": {"from": "20190501T000000", "to": "20190601T000000"}, "order-by": "series" }' | wc -l &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp6", "range": {"from": "20190501T000000", "to": "20190601T000000"}, "order-by": "series" }' | wc -l &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp7", "range": {"from": "20190501T000000", "to": "20190601T000000"}, "order-by": "series" }' | wc -l &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp8", "range": {"from": "20190501T000000", "to": "20190601T000000"}, "order-by": "series" }' | wc -l &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp9", "range": {"from": "20190501T000000", "to": "20190601T000000"}, "order-by": "series" }' | wc -l &
wait
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Completed @ $timestamp"
