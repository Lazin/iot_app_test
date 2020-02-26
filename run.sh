AKUMULI_ENDPOINT=${AKUMULI_ENDPOINT:-"127.0.0.1"}


echo "Akumuli endpoint: $AKUMULI_ENDPOINT"

function wait_for_completion() {
    response=
    c=0
    printf "Waiting until write will be completed "
    until [ -n "$response" ]; do
        response=$(curl -s --url $AKUMULI_ENDPOINT:8181/api/query -d "{ \"select\": \"temperature_celsius\", \"where\" : { \"sensor_id\": \"$1\" }, \"range\": { \"from\": \"20191231T235800.000000\", \"to\": \"20200101T000000.000000\" }}")
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
 
wait_for_completion "sensor_124999"
wait_for_completion "sensor_249999"
wait_for_completion "sensor_374999"
wait_for_completion "sensor_499999"
wait_for_completion "sensor_624999"
wait_for_completion "sensor_749999"
wait_for_completion "sensor_874999"
wait_for_completion "sensor_999999"

timestamp=$(date +%Y%m%dT%H%M%S)
echo "Completed @ $timestamp"

# Aggregate everything using one thread
sleep 600
timestamp=$(date +%Y%m%dT%H%M%S)

echo "Run aggregate query 1-thread @ $timestamp"
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": { "temperature_celsius": "max" } }' | wc -c
wait

timestamp=$(date +%Y%m%dT%H%M%S)
echo "Completed @ $timestamp"

sleep 600

# Aggregate everything using all threads
timestamp=$(date +%Y%m%dT%H%M%S)

echo "Run aggregate query 1-thread @ $timestamp"

time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": "where": {"group":0}, { "temperature_celsius": "max" } }' | wc -c
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": "where": {"group":1}, { "temperature_celsius": "max" } }' | wc -c
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": "where": {"group":2}, { "temperature_celsius": "max" } }' | wc -c
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": "where": {"group":3}, { "temperature_celsius": "max" } }' | wc -c
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": "where": {"group":4}, { "temperature_celsius": "max" } }' | wc -c
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": "where": {"group":5}, { "temperature_celsius": "max" } }' | wc -c
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": "where": {"group":6}, { "temperature_celsius": "max" } }' | wc -c
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": "where": {"group":7}, { "temperature_celsius": "max" } }' | wc -c
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": "where": {"group":8}, { "temperature_celsius": "max" } }' | wc -c
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": "where": {"group":9}, { "temperature_celsius": "max" } }' | wc -c
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": "where": {"group":10}, { "temperature_celsius": "max" } }' | wc -c
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "aggregate": "where": {"group":11}, { "temperature_celsius": "max" } }' | wc -c
wait

timestamp=$(date +%Y%m%dT%H%M%S)
echo "Completed @ $timestamp"

sleep 600
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Run aggregate query @ $timestamp"
time curl -s -XPOST "http://$AKUMULI_ENDPOINT:8181/api/query" -d '{ "select": "cpu.user", "range": {"from": "20010101T000000", "to": "20300101T000000"}, "order-by": "series", "filter": { "gt": 10000 } }' | wc -c
timestamp=$(date +%Y%m%dT%H%M%S)
echo "Completed @ $timestamp"
