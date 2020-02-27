from __future__ import print_function
import argparse
import datetime
import random
import sys
import itertools

def parse_timestamp(ts):
    """Parse ISO formatted timestamp"""
    try:
        return datetime.datetime.strptime(ts.rstrip('0').rstrip('.'), "%Y%m%dT%H%M%S.%f")
    except ValueError:
        return datetime.datetime.strptime(ts, "%Y%m%dT%H%M%S")

def parse_timedelta(delta):
    t = datetime.datetime.strptime(delta,"%H:%M:%S")
    return datetime.timedelta(hours=t.hour, minutes=t.minute, seconds=t.second)

def bulk_msg_with_dict(ts, id, val):
    ncol = 1
    sname = ":" + str(id)
    timestr = ts.strftime('+%Y%m%dT%H%M%S')
    lines = [sname, timestr, "+{0}".format(val)]
    return '\r\n'.join(lines) + '\r\n'

def generate_rows_dict(ts, delta, id):
    val = 21.5  # Starting temperature
    out = None
    upper = 35  # Normal temperature range
    lower = 19
    while True:
        val += random.gauss(0.0, 0.1)
        val = val if val > lower else lower
        val = val if val < upper else lower
        out = int(val)
        msg = bulk_msg_with_dict(ts, id, out)
        yield ts, msg
        ts += delta


def generate_rows_dict_anomalous(ts, delta, id):
    val = 21.5  # Starting temperature
    out = None
    while True:
        val += random.gauss(0.0, 1.0)
        out = int(val)
        msg = bulk_msg_with_dict(ts, id, out)
        yield ts, msg
        ts += delta

def main(idrange, timerange, seed):

    random.seed(seed)

    begin, end, delta = timerange
    idbegin, idend = idrange

    measurements = [
    ]

    tag_combinations = {
        'group': range(0, 12),
        'region': ['APAC', 'AMER', 'EMEA'],
        'firmware-version': ['v1.{0}.{1}'.format(a, b) for a, b in itertools.product(range(0,5), range(28,97))]
    }

    sensor_ids = ['sensor_{0}'.format(sid) for sid in range(idbegin, idend)]

    tags = []
    for sid in sensor_ids:
        tagline = [('sensor_id', sid)]
        for k, v in tag_combinations.iteritems():
            tagline.append((k, random.choice(v)))
        tagline.sort()
        tags.append(tagline)

    # Generate dictionary
    ids = []
    for ix, tagline in enumerate(tags):
        metric = 'temperature_celsius'
        sname = metric + ' ' + ' '.join(['{0}={1}'.format(key, val) for key, val in tagline])
        #
        msg = "*2\r\n+{0}\r\n:{1}\r\n".format(sname, ix)
        ids.append(ix)
        sys.stdout.write(msg)

    # Choose 100 series randomly
    anomalies = random.sample(ids, 100)
    iters = []
    for id_ in ids:
        if id_ in anomalies:
            iters.append(generate_rows_dict_anomalous(begin, delta, id_))
        else:
            iters.append(generate_rows_dict(begin, delta, id_))

    for it in iters:
        for ts, msg in it:
            if ts > end:
                break
            sys.stdout.write(msg)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Process some integers.')
    parser.add_argument('--rbegin', required=True, help='begining of the id range')
    parser.add_argument('--rend',   required=True, help='end of the id range')
    parser.add_argument('--tbegin', required=True, help='begining of the time range')
    parser.add_argument('--tend',   required=True, help='end of the time range')
    parser.add_argument('--tdelta', required=True, help='time step')
    parser.add_argument('--seed',   required=False, help='custom seed', default=None)

    args = parser.parse_args()

    main((int(args.rbegin), int(args.rend)), (parse_timestamp(args.tbegin), parse_timestamp(args.tend), parse_timedelta(args.tdelta)), args.seed)
