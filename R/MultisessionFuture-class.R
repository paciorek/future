#' @inheritParams ClusterFuture-class
#' @inheritParams Future-class
#'
#' @return
#' `MultisessionFuture()` returns an object of class
#' `MultisessionFuture`, which inherits from `ClusterFuture`.
#' 
#' @export
#' @rdname ClusterFuture-class
MultisessionFuture <- function(expr = NULL, envir = parent.frame(), substitute = FALSE, globals = TRUE, persistent = FALSE, local = !persistent, workers = NULL, ...) {
  if (substitute) expr <- substitute(expr)
  f <- ClusterFuture(expr = expr, envir = envir, substitute = FALSE, globals = globals, persistent = persistent, local = local, workers = workers, ...)
  structure(f, class = c("MultisessionFuture", class(f)))
}


#' @export
getExpression.MultisessionFuture <- function(future, mc.cores = 1L, ...) {
  ## NOTE: In order to override the default 'mc.cores = NULL' of
  ## getExpression.Future(), we have to pass it as a named argument to
  ## NextMethod().  If not done, that is, if we just call NextMethod(), then
  ## 'mc.cores' will resolve to the default (= NULL).  If we don't name the
  ## argument - NextMethod("getExpression", mc.cores) - then the default
  ## will still be NULL.
  ## The problem with using NextMethod(mc.cores = mc.cores) is that if we
  ## call getExpression(f, 2L) instead of getExpression(f, mc.cores = 2L),
  ## then the call will become getExpression.Future(f, 2L, mc.cores = 2L).
  ## I don't think there is a solution here, except to enforce that all
  ## arguments to a method that uses NextMethod() must be named.
  ## See also https://github.com/HenrikBengtsson/Wishlist-for-R/issues/44
  ## /HB 2018-06-13

  ## Assert that no arguments but the first is passed by position
  assert_no_positional_args_but_first()
  NextMethod(mc.cores = mc.cores)
}
