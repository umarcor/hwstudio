FROM ghcr.io/umarcor/hwstudio/godot/export
COPY gexport.sh /usr/local/bin/gexport
RUN chmod +x /usr/local/bin/gexport
ENTRYPOINT ["gexport"]
