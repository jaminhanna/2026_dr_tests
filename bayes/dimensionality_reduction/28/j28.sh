#!/bin/sh
#SBATCH --account=ISAAC-UTK0319
#SBATCH --partition=campus
#SBATCH --qos=campus
#SBATCH --nodes=1
#SBATCH --ntasks=41
#SBATCH --time=24:00:00
#SBATCH --output=j28.out
#SBATCH --error=j28.err

repos=/lustre/isaac24/scratch/jhanna8/repos
repo=$repos/2026_dr_tests
dir=$repo/bayes/dimensionality_reduction/28
fr=$repos/framework
cd $fr
source pyframework/bin/activate
if test ! -f bin/bayes
then
  make bin/bayes || exit 1
fi
cd cpp-apps
mkdir -p 28
cp $dir/dimensionality_reduction.json \
   $dir/eons.json \
   $dir/risp.json 28
mkdir -p XX
if test ! -f XX/digits_training_data.csv
then
  if test ! -f $repo/digits_training_data.csv
  then
    ( cd $repo
    tar xzf digits.tar.gz )
  fi
  cp $repo/*.csv $repo/*.json XX
fi
time ../bin/bayes \
  --input_file $dir/b28.in \
  --output_file $dir/b28.out \
  --n_calls 5 \
  -d $dir/networks
deactivate
rm -rf 28
cd $dir
