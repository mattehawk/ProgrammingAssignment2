# Matrix inversion is usually a costly computation and there may be some benefit
# to caching the inverse of a matrix rather than compute it repeatedly. The
# following two functions are used to cache the inverse of a matrix.

# makeCacheMatrix creates a matdix containing a function to
#  - set/get the value of the matrix
#  - set/get the inverse value of the matrix

makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    get <- function() x
    setinverse <- function(inverse) inv <<- inverse
    getinverse <- function() inv
    list(set=set, get=get, setinverse=setinverse, getinverse=getinverse)
}

# Assuming the matrix is always invertible....
# This function checks to see if the inverse has already been cashed.
# If inverse cashed, the cached value is used.
# If inverse is NOT cashed, calculates the inverse values and caches that
# value using setinverse function.

cacheSolve <- function(x, ...) {
    inv <- x$getinverse()
    if(!is.null(inv)) {
        message("getting cached data.")
        return(inv)
    }
    data <- x$get()
    inv <- solve(data)
    x$setinverse(inv)
    inv
}

# Test Run

# > x <- rbind(c(2,8), c(3,9))

# > m = makeCacheMatrix(x)

# > m$get()
# [,1] [,2]
# [1,]    2    8
# [2,]    3    9

# > cacheSolve(m)
# [,1]       [,2]
# [1,] -1.5  1.3333333
# [2,]  0.5 -0.3333333
# > cacheSolve(m)

# "getting cached data"
# [,1]       [,2]
# [1,] -1.5  1.3333333
# [2,]  0.5 -0.3333333

