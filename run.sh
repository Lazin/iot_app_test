AKUMULI_ENDPOINT=${AKUMULI_ENDPOINT:-"127.0.0.1"}


echo "Akumuli endpoint: $AKUMULI_ENDPOINT"

function wait_for_completion() {
    response=
    c=0
    printf "Waiting until write will be completed "
    until [ -n "$response" ]; do
        response=$(curl -s --url $AKUMULI_ENDPOINT:8181/api/query -d "{ \"select\": \"temp0\", \"where\" : { \"sensor_id\": \"$1\" }, \"range\": { \"from\": \"20191231T235800.000000\", \"to\": \"20200101T000000.000000\" }}")
        printf '.'
        sleep 1
        ((c++)) && ((c==20)) && break
    done
    printf "\n$response"
}

# Insert downloaded data
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Sending data in RESP format to $AKUMULI_ENDPOINT @ $timestamp"

cat 525K_points_125000_columns_60sec_step_0.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 525K_points_125000_columns_60sec_step_1.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 525K_points_125000_columns_60sec_step_2.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 525K_points_125000_columns_60sec_step_3.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 525K_points_125000_columns_60sec_step_4.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 525K_points_125000_columns_60sec_step_5.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 525K_points_125000_columns_60sec_step_6.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &
cat 525K_points_125000_columns_60sec_step_7.gz | gunzip > /dev/tcp/$AKUMULI_ENDPOINT/8282 &

wait

timestamp=$(date +%Y%m%dT%H%M%S)
echo "Wait for completion @ $timestamp"
 
wait_for_completion "sensor_12499"
wait_for_completion "sensor_24999"
wait_for_completion "sensor_37499"
wait_for_completion "sensor_49999"
wait_for_completion "sensor_62499"
wait_for_completion "sensor_74999"
wait_for_completion "sensor_87499"
wait_for_completion "sensor_99999"

timestamp=$(date +%Y%m%dT%H%M%S)
echo "Completed @ $timestamp"
sleep 600

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
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp0", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 90 } }' | wc -c
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

# Filter by value 10 threads
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Run filter query in 10 threads @ $timestamp"
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp0", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 90 } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp1", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 90 } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp2", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 90 } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp3", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 90 } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp4", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 90 } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp5", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 90 } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp6", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 90 } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp7", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 90 } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp8", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 90 } }' | wc -c &
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "temp9", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 90 } }' | wc -c &
wait
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Completed @ $timestamp"
sleep 600
