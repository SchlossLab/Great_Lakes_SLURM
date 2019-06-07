library(parallel)
set.seed(101)

lfun <- function(i){
  d <- dist(X) 
}

p <- 16

start <- proc.time()
X <- matrix(rnorm(2^p),ncol = 2^(p/2))
proc.time() - start

start <- proc.time()
res <- lapply(1:p,lfun)
proc.time() - start

start <- proc.time()
options(cores = 4)
mcres <- mclapply(1:p,lfun)
proc.time() - start

all.equal(res, mcres)
