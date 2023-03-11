#!/usr/bin/env bash
set -e

################################################################################

QUERY=$(cat)

MAKESELF_BIN=$(echo ${QUERY} | jq -r '.makeself_bin')
MAKESELF_HEADER_BIN=$(echo ${QUERY} | jq -r '.makeself_header_bin')
ARCHIVE_DIR=$(echo ${QUERY} | jq -r '.archive_dir')
FILE_NAME=$(echo ${QUERY} | jq -r '.file_name')
LABEL=$(echo ${QUERY} | jq -r '.label')
STARTUP_SCRIPT=$(echo ${QUERY} | jq -r '.startup_script')
NEEDROOT=$(echo ${QUERY} | jq -r '.needroot')
if [ "${NEEDROOT}" = "true" ]; then
    NEEDROOT="--needroot"
else
    NEEDROOT=""
fi

################################################################################

OUTPUT=$(mktemp -d)
pushd ${OUTPUT} >/dev/null

cp -R ${ARCHIVE_DIR} .
cp ${MAKESELF_BIN} makeself.sh
cp ${MAKESELF_HEADER_BIN} makeself-header.sh

chmod +x ${STARTUP_SCRIPT}

RUN=( ./makeself.sh --nomd5 --nocrc --tar-extra '--mtime=2019-01-01' --packaging-date '1970-01-01T00:00:00Z' --base64 ${NEEDROOT} $(basename ${ARCHIVE_DIR}) ${FILE_NAME} ${LABEL} ${STARTUP_SCRIPT}  )
echo "${RUN[@]}" >run.log

"${RUN[@]}" >makeself.log 2>&1
popd >/dev/null

################################################################################

jq -n --arg path "${OUTPUT}/${FILE_NAME}" '{"path":$path}'
