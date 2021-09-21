#!/bin/bash

output() {
  while IFS= read -r LINE; do
    # do not indent headers that are being piped through the output
    if [[ "$LINE" =~ ^-----\>.* ]]; then
      echo "$LINE" || true
    else
      echo "       $LINE" || true
    fi
  done
}

set -e
cd $(dirname $0)

mkdir -p ../bin

if [[ -z $FFMPEG_ARCHIVE_NAME ]]; then
  echo "Variable FFMPEG_ARCHIVE_NAME isn't set, using default value" | output
  FFMPEG_ARCHIVE_NAME="ffmpeg.tar.xz"
fi

if [[ -z $FFMPEG_DOWNLOAD_URL ]]; then
  echo "Variable FFMPEG_DOWNLOAD_URL isn't set, using default value" | output
  FFMPEG_DOWNLOAD_URL="https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz"
fi

echo "Downloading $FFMPEG_DOWNLOAD_URL" | output

code=$(curl "$FFMPEG_DOWNLOAD_URL" -L --silent --fail --retry 5 --retry-max-time 15 -o ./$FFMPEG_ARCHIVE_NAME --write-out "%{http_code}")

if [ "$code" != "200" ]; then
  echo "Unable to download ffmpeg: $code" | output && exit 1
fi