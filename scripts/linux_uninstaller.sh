#!/bin/sh

NC="\033[0m"
PURPLE="\033[1;35m"
GREEN="\033[1;32m"

APP_DIR=~/.local/share/applications
APP=${APP_DIR}/hwstudio.desktop

MIME_DIR=~/.local/share/mime
MIME_PKG=${MIME_DIR}/packages
MIME=${MIME_PKG}/hwstudio.xml

ICON_DIR=~/.local/share/icons
ICON=${ICON_DIR}/application-x-hwstudio-project.png

echo "${PURPLE}This script uninstalls hwstudio as a user application"
echo "------------------------------------------------------"

printf "Do you want to continue? [y/N]:${NC} "
read RESP
case "$RESP" in
    [yY][eE][sS]|[yY])
      # Desktop Entry

      rm -f ${APP}
      rm -f ${ICON}
      update-desktop-database ${APP_DIR}

      echo "${GREEN}\nhwstudio.desktop uninstalled!${NC}"


      # Register extension .ice

      rm -f ${MIME}
      update-mime-database ${MIME_DIR}

      echo "${GREEN}hwstudio project unregistered!${NC}"
      ;;
    *)
      ;;
esac
