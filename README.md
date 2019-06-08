# Great Lakes SLURM
Using the Great Lakes cluster and batch computing with SLURM 

## Resources

* Slides: [Introduction to the Great Lakes cluster and batch computing with SLURM](https://docs.google.com/presentation/d/1yZCyfBaK9GVCI64oUW-99HtUO5RNwSlqpeUNo8BjgWI/edit#slide=id.p1)
* Slides: [Advanced batch computing with SLURM on the Great Lakes cluster](https://github.com/SchlossLab/Great_Lakes_SLURM)
* Slides: [MPI profiling with Allinea MAP](https://cscar.research.umich.edu/wp-content/uploads/sites/5/2016/04/galexv20160606.pdf)
* ARC-TS: [Great Lakes overview](https://arc-ts.umich.edu/greatlakes/)
* ARC-TS: [SLURM user guide](https://arc-ts.umich.edu/greatlakes/slurm-user-guide/)
* ARC-TS: [Migrating from PBS-Torque to SLURM](https://arc-ts.umich.edu/migrating-from-torque-to-slurm/)
* ARC-TS: [Globus high-speed data transfer](https://arc-ts.umich.edu/globus/) 
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
These options go in your submission scripts ([example](examples/simpleR/Rbatch.sh)). All lines with SLURM options start with `#SBATCH`. With the exception of the hashbang (`#!`), anything else starting with `#` is a comment.

### Examples

More example files are in `/scratch/data/workshops/IntroGreatLakes/` on the beta login node (`beta-login.stage.arc-ts.umich.edu`).

#### R scripts

[`examples/simpleR/`](examples/simpleR/)

1. Edit your R script, [`Rbatch.R`](examples/simpleR/Rbatch.R), with your preferred text editor.

1. Edit the submission script, [`Rbatch.sh`](examples/simpleR/Rbatch.sh). 

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

#### Job Arrays

[`examples/arrayjob/`](examples/arrayjob/)

The matlab script [`arr.m`](examples/arrayjob/arr.m) takes a job id as input and works on only one task.

The submission script [`submit.sh`](examples/arrayjob/submit.sbat) sets up the job array with three tasks and runs the matlab script once per task. To make a job array, use the sbatch command `#SBATCH --array=1-3`. Edit the integers `1` and `3` to modify the number of tasks in the array and the numbers they're assigned.

Submit the job with:
```
module load matlab
sbatch submit.sh
```
#### Dependent scheduling

[`examples/depjob/`](examples/depjob/)

* Submit a job at a given time:

	1 minute before New Year's Day 2020:
	```
	sbatch --begin 2019-12-31T23:59:00 j1.sbat
	```

	At the next 6pm:
	```
	sbatch --begin 18:00 j2.sbat
	```

* Submit a job after another job completes:
	```
	JOBID=`sbatch --parsable first.sbat`   # JOBID <- first’s jobid
	sbatch dependency=afterany:$JOBID second.sbat
	```

#### Workflow

An example using Trinity RNA-seq: [`examples/trinity/`](examples/trinity/)

The submission script [`trinity.sbat`](examples/trinity/trinity.sbat) contains lots of boilerplate code to handle intermediate directories & files. If you find yourself writing complicated bash scripts like this, consider whether you should instead use a proper workflow manager such as Snakemake. See [a minimal example of using Snakemake on the HPC](https://github.com/kelly-sovacool/snakemake_hpc_mwe).

#### Multiprocessing

[`examples/multiR/`](examples/multiR)

## Conda

Rather than using the modules provided, [I](https://github.com/kelly-sovacool) prefer to use conda to manage my software dependencies.

Download the latest installer for [Anaconda](https://www.anaconda.com/distribution/#download-section) (includes everything) or [Miniconda](https://docs.conda.io/en/latest/miniconda.html) (includes only the minimum, but faster to install).

```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

I like to create a separate conda environment for each of my projects. Example:

Create a conda environment called `rstats` and install R & the tidyverse packages from the `r` channel:
```
conda create -n rstats -c r r r-tidyverse
```

Before submitting jobs for your project `rstats`, activate the environment:
```
conda activate rstats
```

The packages installed in `rstats` are then available for any jobs you submit while the environment is activated.
