# Run Jupyter and Dask in Singularity containers on a SLURM system

**This repository describe work in progress aimed at running Jupyter and Dask using Singularity containers.**
The following steps have been run on the Spider data-processing platform at SURF. 

We use a custom image created using repo2docker and hosted on GitHub Packages (see corresponding [repository](https://github.com/fnattino/test-jupyterdask-image)).
On the SLURM system (Spider), we download the image and convert it to Singularity (now Apptainer):
```shell
apptainer build test-jupyterdask-image.sif docker://ghcr.io/fnattino/test-jupyterdask-image:latest
```

We submit a job that start JupyterLab (and the Dask scheduler) in a container on a compute node:
```shell
sbatch jupyter.slurm ./test-jupyterdask-image.sif
```

On your local system run port forwarding using the command printed in the SLURM stdout file, then 
access Jupyter from the web browser at http://localhost:8889/lab

On the SLURM system (Spider), add workers to the Dask cluster using:
```shell
# get the scheduler address from the Jupyter session
sbatch dask-worker.slurm ./test-jupyterdask-image.sif tcp://10.0.0.XX:XXXXX 
```

## Resources

* https://github.com/pbranson/pangeo-hpc-singularity/tree/master
* https://gist.github.com/willirath/2176a9fa792577b269cb393995f43dda
* https://github.com/ESM-VFC/esm-vfc-stacks/tree/master
