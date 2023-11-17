#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=01:00:00
#SBATCH --cpus-per-task=2
#SBATCH --partition=normal

CONTAINER=$1
SCHEDULER_ADDRESS=$2

# calculate task memory limit
mempcpu=$SLURM_MEM_PER_CPU
memlim=$(echo $SLURM_CPUS_PER_TASK*$mempcpu*0.98 | bc)

apptainer -d exec \
	$CONTAINER \
        dask worker $SCHEDULER_ADDRESS --nthreads $SLURM_CPUS_PER_TASK --memory-limit ${memlim}M --nanny --death-timeout 600 --local-directory $TMPDIR
