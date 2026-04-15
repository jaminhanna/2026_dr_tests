#!/bin/sh
#SBATCH --account=ISAAC-UTK0319
#SBATCH --partition=long
#SBATCH --qos=long
#SBATCH --nodes=1
#SBATCH --ntasks=41
#SBATCH --time=06-00:00:00
#SBATCH --output=j09.out
#SBATCH --error=j09.err

repos=/lustre/isaac24/scratch/jhanna8/repos
repo=$repos/2026_dr_tests
dir=$repo/bayes/dimensionality_reduction/09
fr=$repos/framework
cd $fr
source pyframework/bin/activate
if test ! -f bin/bayes
then
  make bin/bayes || exit 1
fi
cd cpp-apps
mkdir -p 09
cp $dir/dimensionality_reduction.json \
   $dir/eons.json \
   $dir/risp.json 09
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
  --input_file $dir/b09.in \
  --output_file $dir/b09.out \
  --n_calls 100 \
  -d $dir/networks
deactivate
rm -rf 09
cd $dir
