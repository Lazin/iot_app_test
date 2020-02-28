# Generate 8 files
# Cardinality - 1000000
# Every file has 125000 series
# Total number of data points - 525.6B

python2.7 gen.py --rbegin=0     --rend=12500  --tbegin=20190101T000000 --tend=20200101T000000 --tdelta=00:01:00 | gzip > 525K_points_125000_columns_60sec_step_0.gz &
python2.7 gen.py --rbegin=12500 --rend=25000  --tbegin=20190101T000000 --tend=20200101T000000 --tdelta=00:01:00 | gzip > 525K_points_125000_columns_60sec_step_1.gz &
python2.7 gen.py --rbegin=25000 --rend=37500  --tbegin=20190101T000000 --tend=20200101T000000 --tdelta=00:01:00 | gzip > 525K_points_125000_columns_60sec_step_2.gz &
python2.7 gen.py --rbegin=37500 --rend=50000  --tbegin=20190101T000000 --tend=20200101T000000 --tdelta=00:01:00 | gzip > 525K_points_125000_columns_60sec_step_3.gz &
python2.7 gen.py --rbegin=50000 --rend=62500  --tbegin=20190101T000000 --tend=20200101T000000 --tdelta=00:01:00 | gzip > 525K_points_125000_columns_60sec_step_4.gz &
python2.7 gen.py --rbegin=62500 --rend=75000  --tbegin=20190101T000000 --tend=20200101T000000 --tdelta=00:01:00 | gzip > 525K_points_125000_columns_60sec_step_5.gz &
python2.7 gen.py --rbegin=75000 --rend=87500  --tbegin=20190101T000000 --tend=20200101T000000 --tdelta=00:01:00 | gzip > 525K_points_125000_columns_60sec_step_6.gz &
python2.7 gen.py --rbegin=87500 --rend=100000 --tbegin=20190101T000000 --tend=20200101T000000 --tdelta=00:01:00 | gzip > 525K_points_125000_columns_60sec_step_7.gz &
wait


