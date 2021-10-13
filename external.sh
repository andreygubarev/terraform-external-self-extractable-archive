#!/usr/bin/env bash
set -e

QUERY=$(cat)

MAKESELF_BIN=$(echo $QUERY | jq -r '.makeself_bin')
MAKESELF_HEADER_BIN=$(echo $QUERY | jq -r '.makeself_header_bin')

ARCHIVE_DIR=$(echo $QUERY | jq -r '.archive_dir')
FILE_NAME=$(mktemp)
LABEL=$(echo $QUERY | jq -r '.label')
STARTUP_SCRIPT=$(echo $QUERY | jq -r '.startup_script')

NEEDROOT=$(echo $QUERY | jq -r '.needroot')
if [ "$NEEDROOT" = "true" ]; then
    NEEDROOT="--needroot"
else
    NEEDROOT=""
fi

RUN=( ${MAKESELF_BIN} --packaging-date "" --base64 ${NEEDROOT} --header ${MAKESELF_HEADER_BIN} ${ARCHIVE_DIR} ${FILE_NAME} ${LABEL} ${STARTUP_SCRIPT} )

OUTPUT=$(mktemp)
"${RUN[@]}" 2>/dev/null >${OUTPUT}
CHECKSUM=$(cat ${OUTPUT} | grep 'MD5' | awk '{ print $2 }')
rm ${OUTPUT}

CONTENT=$(cat ${FILE_NAME})
rm ${FILE_NAME}

jq -n --arg checksum "${CHECKSUM}" --arg content "${CONTENT}" '{"checksum":$checksum,"content":$content}'
