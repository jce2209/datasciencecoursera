## This script contain two functions that creates a special matrix with the makeCacheMatrix function 
## then cacheSolve inverse the matrix. The interesting thing is that this functions saves the answers
## in the cache, in case the same matrix is asked later.

## This function creates the special matrix, which is a list, that saves in the cache the inverse matrix.

makeCacheMatrix <- function(x = matrix()) {
        m <- NULL
        set <- function(y) {
                x <<- y
                m <<- NULL
        }
        get <- function() x
        setinverse <- function(inverse) m <<- inverse
        getinverse <- function() m
        list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse)
}


## This function solves the special matrix from the makeCacheMatrix function, but before doing that, 
##  it checks if the answer is in the cache, if so, it retrieves a message and the solution.

cacheSolve <- function(x, ...) {
        m <- x$getinverse()
        if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        data <- x$get()
        m <- Inverse(data, ...)
        x$setinverse(m)
        m
}

j <- matrix(c(1.2, 2, 3, 4, 5, 6, 7, 8, 9), 3, 3)
l <- makeCacheMatrix(j)
cacheSolve(l)
cacheSolve(l)
getting cached data
[,1] [,2]      [,3]
[1,]    5  -10  5.000000
[2,]  -10   17 -7.333333
[3,]    5   -8  3.333333