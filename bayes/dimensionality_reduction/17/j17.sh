#!/bin/sh
#SBATCH --account=ISAAC-UTK0319
#SBATCH --partition=campus
#SBATCH --qos=campus
#SBATCH --nodes=1
#SBATCH --ntasks=41
#SBATCH --time=24:00:00
#SBATCH --output=j17.out
#SBATCH --error=j17.err

repos=/lustre/isaac24/scratch/jhanna8/repos
dir=$repos/2026_dr_tests/bayes/dimensionality_reduction/17
fr=$repos/framework
cd $fr
source pyframework/bin/activate
if test ! -f bin/bayes
then
  make bin/bayes || exit 1
fi
cd cpp-apps
mkdir 17
cp $dir/dimensionality_reduction.json \
   $dir/eons.json \
   $dir/risp.json 17
../bin/bayes \
  --input_file $dir/b17.in \
  --output_file $dir/b17.out \
  --n_calls 5 \
  -d $dir/networks
deactivate
rm -r 17
cd $dir
