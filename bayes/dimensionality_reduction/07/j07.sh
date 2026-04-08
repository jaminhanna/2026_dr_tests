#!/bin/sh
#SBATCH --account=ISAAC-UTK0319
#SBATCH --partition=campus
#SBATCH --qos=campus
#SBATCH --nodes=1
#SBATCH --ntasks=41
#SBATCH --time=24:00:00
#SBATCH --output=j07.out
#SBATCH --error=j07.err

repos=/lustre/isaac24/scratch/jhanna8/repos
dir=$repos/2026_dr_tests/bayes/dimensionality_reduction/07
fr=$repos/framework
cd $fr
source pyframework/bin/activate
if test ! -f bin/bayes
then
  make bin/bayes || exit 1
fi
cd cpp-apps
cp $dir/dimensionality_reduction.json \
   $dir/eons.json \
   $dir/risp.json .
../bin/bayes \
  --input_file $dir/b07.in \
  --output_file $dir/b07.out \
  --n_calls 20 \
  -d $dir/networks
deactivate
rm dimensionality_reduction.json eons.json risp.json
cd $dir
