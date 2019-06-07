#!/bin/bash

# See more information at:
# https://arc-ts.umich.edu/beta/slurm-user-guide/

# Submit the first job and save the JobID as JOBONE
JOBONE=$(sbatch --parsable first.sbat)

# Submit the second job, use JOBONE as depend, save JobID
JOBTWO=$(sbatch --parsable --dependency=afterok:$JOBONE second.sbat)

# Submit the third job, use JOBTWO as depend, save JobID
JOBTHREE=$(sbatch --parsable --dependency=afterok:$JOBTWO third.sbat)
