#!/usr/bin/env bash

# Function: usage
#
# Print the help message for these tests.
#
# Usage:
#
#   vars=(TF_VAR_foo TF_VAR_bar)
#   usage
#
usage() {
  printf "Usage: "
  for tf_var in "${vars[@]}" ; do
    printf "%s=..." "$tf_var"
  done
  printf "%s\\n" "$0"
  exit 1
}

# Function: err
#
# Print an error message and exit.
#
err() {
  echo "ERROR: $*" ; exit 1
}

# Function: validateVars
#
# Validate variables that are expected to be exported.
#
# Usage:
#
#   vars=(TF_VAR_foo TF_VAR_bar)
#   validateVars
#
validateVars() {
  for tf_var in "${vars[@]}" ; do
    code='[ -z $'"$tf_var"' ] && err "'"$tf_var"' not set"'
    eval "$code"
  done

  bins=(
    shunit2
    terraform
  )

  for bin in "${bins[@]}" ; do
    code='if ! command -v '"$bin"' > /dev/null ; then
            err "'"$bin"' not found in $PATH"
          fi'
    eval "$code"
  done
}
