FROM ubuntu

ARG GODOT_VERSION='3.2.3'
ARG GODOT_DIST_URL='https://downloads.tuxfamily.org/godotengine'

ENV GODOT_VERSION=$GODOT_VERSION

RUN apt-get update -qq \
 && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
    ca-certificates \
    curl \
    unzip \
 && update-ca-certificates

RUN curl -fsSL "${GODOT_DIST_URL}/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_linux_headless.64.zip" -o godot.zip \
 && curl -fsSL "${GODOT_DIST_URL}/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_export_templates.tpz" -o tpl.tpz \
 && unzip godot.zip \
 && mv "Godot_v${GODOT_VERSION}-stable_linux_headless.64" /usr/local/bin/godot \
 && chmod +x /usr/local/bin/godot \
 && unzip tpl.tpz \
 && mkdir -p /usr/local/share/godot/templates/${GODOT_VERSION}.stable/ \
 && mv templates/* /usr/local/share/godot/templates/${GODOT_VERSION}.stable/ \
 && rm -rf godot.zip tpl.tpz templates
