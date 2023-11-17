#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=01:00:00
#SBATCH --cpus-per-task=2
#SBATCH --partition=normal

CONTAINER=$1

PORT=` shuf -i 8400-9400 -n 1 `

NODE=`hostname -s`
echo "Run the following on your local machine: "
echo "ssh -i /path/to/the/ssh/key -N -L 8889:${NODE}:${PORT} ${USER}@spider.surf.nl"

apptainer -d exec \
	$CONTAINER \
	jupyter lab --no-browser --port=${PORT} --ip=0.0.0.0
