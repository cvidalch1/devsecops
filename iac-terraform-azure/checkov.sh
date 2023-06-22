#!/bin/bash      
# 

WORK_DIR=${1-$(pwd)}
run_checkov() {
  local test_dir=$1
  docker run -t -v "${test_dir}":/tf bridgecrew/checkov:latest -d /tf
}
find_folders_by() {
  local pattern=${1:-"main.tf"}
  find "${WORK_DIR}" -type f -name "${pattern}" -printf '%h\n' | sort -u
}
run_main() {
  for folder in $(find_folders_by "main.tf"); do
    run_checkov "${folder}" &
  done
  wait
}
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  run_main
fi