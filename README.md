Scripts for https://akumuli.org/akumuli/2020/03/10/analyzing-500B-rows/

### Setup

Clone the repository, install python2.7.

### Generate the data

```
bash gen.sh
```

### Running the benchmark

You need to add environment variable `AKUMULI_ENDPOINT` with IP-address of the host that runs `akumulid` instance.

```
export AKUMULI_ENDPOINT=xx.xx.xx.xx
bash run.sh
```

Optionally, you can bounce `akumulid` instance on the remote host and re-run queries using `flt.sh` 
to get the compacted storage results.

### Grafana

Repository contains Grafana dashboard that can be used to monitor DO droplet using `netdata` as a data collector and Akumuli 
as a backend. To use it, install `akumuli-datasource` and import `Droplet.json`. To connect `netdata` to Akumuli instance, 
set up `OpenTSDB` backend in netdata configuration file and set destination field using IP of your Akumuli instance (the one that you're
using for monitoring). Also, note that you have to specify both IP and port in netdata confguration (<ip>:4242 in case of
Akumuli OTSDB endpoint).

```
[backend]
        host tags = 
        enabled = yes
        data source = average
        type = opentsdb
        destination = 10.131.37.63:4242
        prefix = netdata
        hostname = my-hostname
        update every = 10
        buffer on failures = 10
        timeout ms = 20000
        send names instead of ids = yes
        send charts matching = *
        send hosts matching = localhost *
```
