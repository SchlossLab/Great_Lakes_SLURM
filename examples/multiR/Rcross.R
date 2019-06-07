library(parallel)
n <- 100
set.seed(123)
x <- rnorm(n)
y <- x + rnorm(n)
rand.data <- data.frame(x, y)

K <- 10000000
samples <- split(sample(1:n), rep(1:K, length = n))

cv.fold.fun <- function(index) {
   fit <- lm(y~x, data = rand.data[-samples[[index]],])
   pred <- predict(fit, newdata = rand.data[samples[[index]],])
   return((pred - rand.data$y[samples[[index]]])^2)
}

#  Sequential version
start <- proc.time()
res.fun   <- lapply(seq(along = samples), cv.fold.fun)
proc.time() - start
mean(unlist(res.fun))

#  Parallel version
start <- proc.time()
options(cores = 4)
mcres.fun <- mclapply(seq(along = samples), cv.fold.fun)
proc.time() - start
mean(unlist(mcres.fun))

#  All the elements are identical
all.equal(res.fun, mcres.fun)
