"data.world-r
Copyright 2018 data.world, Inc.

Licensed under the Apache License, Version 2.0 (the \"License\");
you may not use this file except in compliance with the License.

You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an \"AS IS\" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
implied. See the License for the specific language governing
permissions and limitations under the License.

This product includes software developed at data.world, Inc.
https://data.world"

.onLoad <- function(...) {

  op <- options()
  op.dw <-
    list(dw.config_path =
      file.path(normalizePath("~", winslash = "/"), ".dw", "config"))

  toset <- !(names(op.dw) %in% names(op))
  if (any(toset))
    options(op.dw[toset])

  set_dw_config()

  invisible()

}

#' Apply configuration from file or envvars and load dwapi
#' @keywords internal
set_dw_config <- function() {

  profile <- Sys.getenv("DW_PROFILE", unset = NA)
  if (is.na(profile)) {
    profile <- "DEFAULT"
  }

  cs <- cfg_saved(profile = profile)
  suppressWarnings(set_config(cs))

  set_config(cfg_env())

  invisible()

}
