#!/usr/bin/env bash
set -e

QUERY=$(cat)

MAKESELF_BIN=$(echo $QUERY | jq -r '.makeself_bin')
MAKESELF_HEADER_BIN=$(echo $QUERY | jq -r '.makeself_header_bin')

ARCHIVE_DIR=$(echo $QUERY | jq -r '.archive_dir')
FILE_NAME=$(echo $QUERY | jq -r '.file_name')
LABEL=$(echo $QUERY | jq -r '.label')
STARTUP_SCRIPT=$(echo $QUERY | jq -r '.startup_script')

GZIP=$(echo $QUERY | jq -r '.gzip')
if [ "$GZIP" = "true" ]; then
    GZIP="--gzip"
else
    GZIP=""
fi

NEEDROOT=$(echo $QUERY | jq -r '.needroot')
if [ "$NEEDROOT" = "true" ]; then
    NEEDROOT="--needroot"
else
    NEEDROOT=""
fi

RUN=(${MAKESELF_BIN} ${ARCHIVE_DIR} ${FILE_NAME} ${LABEL} ${STARTUP_SCRIPT} ${GZIP} ${NEEDROOT} --header=${MAKESELF_HEADER_BIN} --quiet --tar-quietly)

OUTPUT=$(mktemp)
"${RUN[@]}" 2>/dev/null >${OUTPUT}
CHECKSUM=$(cat ${OUTPUT} | grep 'MD5' | awk '{ print $2 }')
rm ${OUTPUT}

jq -n --arg checksum "$CHECKSUM" '{"r":$checksum}'
