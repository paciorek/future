#' A future with a constant value
#'
#' A constant future is a future whose expression is a constant
#' and therefore by definition already resolved upon creation.
#'
#' @inheritParams Future-class
#' 
#' @param \dots Not used.
#'
#' @return An object of class `ConstantFuture`.
#'
#' @export
#' @name ConstantFuture-class
#' @keywords internal
ConstantFuture <- function(expr = NULL, envir = emptyenv(), substitute = FALSE, globals = NULL, packages = NULL, local = FALSE, ...) {
  expr <- force(expr)
  f <- Future(expr = expr, envir = emptyenv(), substitute = FALSE, globals = NULL, packages = NULL, local = FALSE, ...)
  f$result <- FutureResult(value = expr)
  f$state <- "finished"
  structure(f, class = c("ConstantFuture", class(f)))
  f
}


#' @export
result.ConstantFuture <- function(future, ...) {
  future$result
}