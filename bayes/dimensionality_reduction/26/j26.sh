#!/bin/sh
#SBATCH --account=ISAAC-UTK0319
#SBATCH --partition=campus
#SBATCH --qos=campus
#SBATCH --nodes=1
#SBATCH --ntasks=41
#SBATCH --time=24:00:00
#SBATCH --output=j26.out
#SBATCH --error=j26.err

repos=/lustre/isaac24/scratch/jhanna8/repos
dir=$repos/2026_dr_tests/bayes/dimensionality_reduction/26
fr=$repos/framework
cd $fr
source pyframework/bin/activate
if test ! -f bin/bayes
then
  make bin/bayes || exit 1
fi
cd cpp-apps
mkdir 26
cp $dir/dimensionality_reduction.json \
   $dir/eons.json \
   $dir/risp.json 26
../bin/bayes \
  --input_file $dir/b26.in \
  --output_file $dir/b26.out \
  --n_calls 5 \
  -d $dir/networks
deactivate
rm -r 26
cd $dir
