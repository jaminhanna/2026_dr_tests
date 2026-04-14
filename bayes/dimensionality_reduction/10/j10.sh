#!/bin/sh
#SBATCH --account=ISAAC-UTK0319
#SBATCH --partition=long
#SBATCH --qos=long
#SBATCH --nodes=1
#SBATCH --ntasks=41
#SBATCH --time=06-00:00:00
#SBATCH --output=j10.out
#SBATCH --error=j10.err

repos=/lustre/isaac24/scratch/jhanna8/repos
dir=$repos/2026_dr_tests/bayes/dimensionality_reduction/10
fr=$repos/framework
cd $fr
source pyframework/bin/activate
if test ! -f bin/bayes
then
  make bin/bayes || exit 1
fi
cd cpp-apps
mkdir 10
cp $dir/dimensionality_reduction.json \
   $dir/eons.json \
   $dir/risp.json 10
time ../bin/bayes \
  --input_file $dir/b10.in \
  --output_file $dir/b10.out \
  --n_calls 100 \
  -d $dir/networks
deactivate
rm -r 10
cd $dir
