# Generate 8 files
# Cardinality - 1000000
# Every file has 125000 series
# Total number of data points - 525.6B

python2.7 gen.py --rbegin=0      --rend=125000  --tbegin=20190101T000000 --tend=20200101T000000 --tdelta=00:01:00 | gzip > 525K_points_125000_columns_60sec_step_0.gz &
python2.7 gen.py --rbegin=125000 --rend=250000  --tbegin=20190101T000000 --tend=20200101T000000 --tdelta=00:01:00 | gzip > 525K_points_125000_columns_60sec_step_1.gz &
python2.7 gen.py --rbegin=250000 --rend=375000  --tbegin=20190101T000000 --tend=20200101T000000 --tdelta=00:01:00 | gzip > 525K_points_125000_columns_60sec_step_2.gz &
python2.7 gen.py --rbegin=375000 --rend=500000  --tbegin=20190101T000000 --tend=20200101T000000 --tdelta=00:01:00 | gzip > 525K_points_125000_columns_60sec_step_3.gz &
python2.7 gen.py --rbegin=500000 --rend=625000  --tbegin=20190101T000000 --tend=20200101T000000 --tdelta=00:01:00 | gzip > 525K_points_125000_columns_60sec_step_4.gz &
python2.7 gen.py --rbegin=625000 --rend=750000  --tbegin=20190101T000000 --tend=20200101T000000 --tdelta=00:01:00 | gzip > 525K_points_125000_columns_60sec_step_5.gz &
python2.7 gen.py --rbegin=750000 --rend=875000  --tbegin=20190101T000000 --tend=20200101T000000 --tdelta=00:01:00 | gzip > 525K_points_125000_columns_60sec_step_6.gz &
python2.7 gen.py --rbegin=875000 --rend=1000000 --tbegin=20190101T000000 --tend=20200101T000000 --tdelta=00:01:00 | gzip > 525K_points_125000_columns_60sec_step_7.gz &
wait


