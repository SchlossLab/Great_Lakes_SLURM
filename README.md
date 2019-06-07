# Great Lakes SLURM
Using the Great Lakes cluster and batch computing with SLURM 

## Resources

* Slides: [Introduction to the Great Lakes cluster and batch computing with SLURM](https://docs.google.com/presentation/d/1yZCyfBaK9GVCI64oUW-99HtUO5RNwSlqpeUNo8BjgWI/edit#slide=id.p1)
* Slides: [Advanced batch computing with SLURM on the Great Lakes cluster](https://github.com/SchlossLab/Great_Lakes_SLURM)
* Slides: [MPI profiling with Allinea MAP](https://cscar.research.umich.edu/wp-content/uploads/sites/5/2016/04/galexv20160606.pdf)
* ARC-TS: [Great Lakes overview](https://arc-ts.umich.edu/greatlakes/)
* ARC-TS: [SLURM user guide](https://arc-ts.umich.edu/greatlakes/slurm-user-guide/)
* ARC-TS: [Migrating from PBS-Torque to SLURM](https://arc-ts.umich.edu/migrating-from-torque-to-slurm/)
* ARC-TS: [Globus](https://arc-ts.umich.edu/globus/) for high-speed data transfer
* [Snakemake profile for SLURM](https://github.com/Snakemake-Profiles/slurm)
* [Kelly's preferred configuration for HPCs](https://github.com/kelly-sovacool/hpc-config)

## SLURM Basics

### Commands

| Command | Action |
|---------|--------|
| `sbatch script.sh` | Submit `script.sh` as a job |
| `squeue -j jobid` | Check job status by `jobid` |
| `squeue -u uniqname` | Check job status by user's `uniqname`|
| `scancel jobid` | Kill a job by `jobid` |
| `my_usage uniqname` | List resource usage for user `uniqname`|
| `sinfo` | Show node status by partition |
| `scontrol show node node_name` | Show details for a node `node_name` |
| `scontrol show job jobid` | Show details for a job by `jobid`|
| `srun --pty --nodes=1 --cpus-per-task=4 --time=30:00 --account=training /bin/bash` | Run an interactive job |

Note that everything on Great Lakes will be on-demand. For time, you will only be charged for the walltime you use. But for memory, CPU, & GPU, you will be charged for the resources you *ask for*.

### Options

Take a look at the [SLURM user guide](https://arc-ts.umich.edu/greatlakes/slurm-user-guide/) from ARC-TS for a list of available options. Also see this guide for [migrating your PBS-torque scripts to SLURM](https://arc-ts.umich.edu/migrating-from-torque-to-slurm/).
These options go in your submission scripts ([example](examples/Rbatch.sh)). All lines with SLURM options start with `#SBATCH`. With the exception of the hashbang (`#!`), anything else starting with `#` is a comment.

### Examples

```
└── examples/
    ├── Rbatch.R
    └── Rbatch.sh
```

The workflow:

1. Edit your R script, `Rbatch.R`, with your preferred text editor.

1. Edit the submission script, `Rbatch.sh`. 

1. Load R and submit the job.
	```
	module load R
	sbatch Rbatch.sh
	```
	It will tell you the `jobid` in a message: `Submitted batch job 32965`.

1. Check on the status of your jobs.
	```
	squeue -u uniqname
	```
1. When it finishes, take a look at the output from R.
	```
	less Rbatch.out
	```
1. To troubleshoot problems, look at the SLURM log file.
	```
	less slurm-32965.out
	```
	where `32965` is the `jobid`.

More example files are in `/scratch/data/workshops/IntroGreatLakes/` on the beta login node (`beta-login.stage.arc-ts.umich.edu`).
