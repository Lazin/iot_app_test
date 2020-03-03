AKUMULI_ENDPOINT=${AKUMULI_ENDPOINT:-"127.0.0.1"}


echo "Akumuli endpoint: $AKUMULI_ENDPOINT"



# Aggregate using one thread
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Run aggregate query in one thread @ $timestamp"
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp0": "max" } }' | wc -c
wait
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Completed @ $timestamp"
sleep 600

# Filter by value 1 thread
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Run filter query in one thread @ $timestamp"
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp0", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 95 } }' | wc -c
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Completed @ $timestamp"
sleep 600

# Aggregate using 10 threads
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Run aggregate query in 10 threads @ $timestamp"
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp0": "max" } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp1": "max" } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp2": "max" } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp3": "max" } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp4": "max" } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp5": "max" } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp6": "max" } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp7": "max" } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp8": "max" } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp9": "max" } }' | wc -c &
wait
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Completed @ $timestamp"
sleep 600

# Aggregate using 10 threads
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Run aggregate query in 5 threads @ $timestamp"
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp0": "max" } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp1": "max" } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp2": "max" } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp3": "max" } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp4": "max" } }' | wc -c &
wait
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp5": "max" } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp6": "max" } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp7": "max" } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp8": "max" } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temp9": "max" } }' | wc -c &
wait
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Completed @ $timestamp"
sleep 600



# Filter by value 10 threads
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Run filter query in 10 threads @ $timestamp"
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp0", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 95 } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp1", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 95 } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp2", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 95 } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp3", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 95 } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp4", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 95 } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp5", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 95 } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp6", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 95 } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp7", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 95 } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp8", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 95 } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp9", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 95 } }' | wc -c &
wait
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Completed @ $timestamp"
sleep 600
