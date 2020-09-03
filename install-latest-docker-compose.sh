#!/bin/bash
INSTALL_DIR="${INSTALL_DIR:=/usr/local/bin}"

TEMPDIR=$(mktemp -d)
[ -z "${TEMPDIR}" ] && exit 1

curl -s https://api.github.com/repos/docker/compose/releases/latest \
  | grep "browser.*docker-compose-$(uname -s)-$(uname -m)\"" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | tr -d \ \
  | xargs -- curl -L -o "${TEMPDIR}/docker-compose"


cp -f "${TEMPDIR}/docker-compose" "${INSTALL_DIR}/docker-compose"
chmod +x "${INSTALL_DIR}/docker-compose"
rm -rf "${TEMPDIR}"
