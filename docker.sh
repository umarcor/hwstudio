#!/usr/bin/env sh

set -e

cd $(dirname $0)

ENABLE_BUILDKIT=1

build_dev() {
  docker build -t umarcor/hwstudio:dev - <<EOF
FROM python:3.7
RUN \
  curl -sL https://deb.nodesource.com/setup_11.x | bash - &&\
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&\
  echo 'deb https://dl.yarnpkg.com/debian/ stable main' | tee /etc/apt/sources.list.d/yarn.list &&\
  apt update -qq &&\
  apt install -y nodejs yarn &&\
  sed -i 's/TLSv1.2/TLSv1.0/g' /etc/ssl/openssl.cnf
EOF
}

build_run() {
  docker build -t umarcor/hwstudio:run - <<EOF
FROM python:3.7
RUN apt update -qq &&\
  apt install -y \
    libasound2 \
    libgconf-2-4 \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libgtk2.0-0 \
    libnotify4 \
    libnss3 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxi6 \
    libxrandr2 \
    libxss1 \
    libxtst6
EOF
}

#libglib2.0-0 \
#libfontconfig \
#libpangocairo-1.0-0 \

exec_runx() {
  /t/runx/runx --no-auth -- /t/x11docker/x11docker -i --hostdisplay --gpu --user=root -- -v "$1"://src -- umarcor/hwstudio:run $2
}

case "$1" in
  --build|-b)
    shift
    case "$1" in
      dev) build_dev;;
      run) build_run;;
      *)
        echo "Unknown build arg $1"
        exit 1
    esac
    ;;
  --dist|-d)
    shift
    if [ "x$1" = "x-i" ]; then
      exec_runx "/$(pwd)" bash
    else
      docker run --rm -v /$(pwd)://src -w //src -e DIST_TARGET=lin64 umarcor/hwstudio:dev bash -c "yarn && yarn grunt dist -v"
    fi
    ;;
  --test|-t)
    cd dist
    VERSION="`ls icestudio-*-linux64.zip | sed 's#.*-\([0-9\.]*\)-.*#\1#g'`"
    echo "VERSION: $VERSION"
    unzip "icestudio-$VERSION-linux64.zip"
    chmod +x "icestudio-$VERSION-linux64/icestudio"

    shift
    exec_runx "/$(pwd)/icestudio-$VERSION-linux64" $1
    ;;
  --publish|-p)
    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
    docker images
    docker push umarcor/hwstudio
    docker logout
    ;;
esac
