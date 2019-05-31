# Great_Lakes_SLURM
Using the Great Lakes cluster and batch computing with SLURM 

## Resources

* [Great Lakes overview](https://arc-ts.umich.edu/greatlakes/)
* [SLURM user guide](https://arc-ts.umich.edu/greatlakes/slurm-user-guide/)
* [Introduction to the Great Lakes cluster and batch computing with SLURM](https://docs.google.com/presentation/d/1yZCyfBaK9GVCI64oUW-99HtUO5RNwSlqpeUNo8BjgWI/edit#slide=id.p1)
* Advanced batch computing with SLURM on the Great Lakes cluster
* [Globus](https://arc-ts.umich.edu/globus/) for high-speed data transfer
* [Snakemake profile for SLURM](https://github.com/Snakemake-Profiles/slurm)
* [Kelly's preferred configuration for HPCs](https://github.com/kelly-sovacool/hpc-config)

## SLURM

### Commands

| Command | Action |
|---------|--------|
| `sbatch scripts.sbat` | Submit a job |
| `squeue -j jobid` | Check job status by id |
| `squeue -u uniqname` | Check job status by user |
| `scancel jobid` | Kill a job |
| `my_usage uniqname` | List resource usage for user |
| `sinfo` | Show node status by partition |
| `scontrol show node node_name` | Show details for a node |
| `scontrol show job jobid` | Show details for a job |
| `srun --pty --nodes=1 --cpus-per-task=4 --time=30:00 --account=training /bin/bash` | Run an interactive job |

### Examples

On the beta login node (`beta-login.stage.arc-ts.umich.edu`), example files are in `/scratch/data/workshops/IntroGreatLakes/`.

```
└── R-examples
    ├── iris.R
    ├── iris.sh
    ├── Rbatch.pbs
    ├── Rbatch.R
    ├── Rbatch.sbat
    ├── R-parallel.pbs
    └── R-parallel.R
```
