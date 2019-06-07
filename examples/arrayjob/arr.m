% hpc201

% change to this array job element's working directory
mydir = getenv('SLURM_ARRAY_TASK_ID');
cd(mydir);
disp(pwd)

% read seed and initialize generator
seed = textread('seed.txt', '%d');
rng(seed)

% compute and display product of two random matrices
A = rand(4);
B = rand(4);
C = A*B
save('output','C');
