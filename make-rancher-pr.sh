#!/usr/bin/env bash
#
cd $(dirname $0)
#
PARTNER_REPO="${PARTNER_REPO}"
CHART="mysql-galera"
#
function show_help {
  echo "Usage: $0 --repo-root <PATH>"
}
#
if [[ -z "${PARTNER_REPO}" ]] && [[ $# -eq 0 ]]; then
  show_help
  exit 1
fi
#
while [[ $# -gt 0 ]]; do
  case $1 in
    -r | --repo-root)
      PARTNER_REPO=$2
      shift 2
    ;;
    -c | --chart)
      CHART=$2
      shift 2
    ;;
    *)
      echo "Wrong parameter: $1"
      show_help
      exit 1
    ;;
  esac
done
#
if [[ ! -d "${PARTNER_REPO}" ]]; then
  echo "Error! Path ${PARTNER_REPO} does not exist"
  exit 1
fi
#
mkdir -p "${PARTNER_REPO}/packages/codership/"
cp -av ./rancher/${CHART} \
  "${PARTNER_REPO}/packages/codership/"
#
pushd "${PARTNER_REPO}"
  rm -vf bin/partner-charts-ci
  bash scripts/pull-scripts
  echo "Processing ${CHART}..."
  PACKAGE="codership/${CHART}" ./bin/partner-charts-ci update --commit
  find charts/codership/ -name '*.sh' -exec rm -fv '{}' \;
  find charts/codership/ -name 'VARIABLES' -exec rm -fv '{}' \;
popd
