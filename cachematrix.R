## The makeCacheMatrix and cacheSolve functions allow caching
## the inverse of a matrix that is assumed to be square and 
## invertible.
## 
## Usage example:
##      my_matrix <- matrix(c(1,2,3,4), nrow=2, ncol=2)
##      cached_matrix <- makeCacheMatrix(my_matrix)
##      cacheSolve(cached_matrix)


## makeCacheMatrix takes a square and invertible matrix as input
## and creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
        #Initialize a variable m_inv to NULL
        m_inv <- NULL
        
        #Set the value of the matrix
        set <- function(y) {
                x <<- y
                m_inv <<- NULL
        }
        #Get the value of the matrix
        get <- function() x
        
        #Set the inverse of the matrix
        setinv <- function(inverse) m_inv <<- inverse
        
        #Get the inverse of the matrix
        getinv <- function() m_inv
        
        #Return the list of functions 
        list(set = set, get = get,
             setinv = setinv,
             getinv = getinv)
}


## cacheSolve takes the special "matrix" object generated by makeCacheMatrix
## as input and compute the inverse of the matrix by using the generic R function
## solve(), or retrieving the inverse from cache if it has been calculated.

cacheSolve <- function(x, ...) {
        #Get the inverse of the matrix that is passed in makeCacheMatrix
        m_inv <- x$getinv()
        
        #If m_inv exists, the inverse has already been computed.
        if(!is.null(m_inv)) {
                #Notify that data is retrieved from cache.
                message("getting cached data")
                #Return the inverse and exit.
                return(m_inv)
        }
        
        #The inverse has not been computed at this point.
        #Get the value of the matrix and store in "data"
        data <- x$get()
        
        #Compute the inverse of the matrix if it is invertible.
        #The matrix must be square, otherwise "solve" will throw error.
        m_inv <- solve(data, ...)
        
        #Set inverse of the matrix in cache.
        x$setinv(m_inv)
        
        #Return the inverse
        m_inv
}
