#!/usr/bin/env bash
set -e
SRC="../apim-with-mi"
DST="."

echo "Copying MI configuration and security artifacts from $SRC to $DST"
# copy the MI Dockerfile
mkdir -p dockerfiles/mi
cp -a "$SRC/dockerfiles/mi/Dockerfile" dockerfiles/mi/

# copy mi conf
mkdir -p conf/mi/conf
cp -a "$SRC/conf/mi/conf/deployment.toml" conf/mi/conf/

# copy security resources (may include binary keystores)
mkdir -p conf/mi/repository/resources/security
cp -a "$SRC/conf/mi/repository/resources/security/"* conf/mi/repository/resources/security/ || true

# create capps dir
mkdir -p capps

# copy any existing capps
cp -a "$SRC/capps/"* capps/ 2>/dev/null || true

# set permissive permissions for local development if not root
if [ "$EUID" -ne 0 ]; then
  chmod -R 777 conf/mi/repository/resources/security capps || true
  echo "Set permissive permissions on copied files (non-root run)."
else
  chown -R 802:802 conf/mi/repository/resources/security capps || true
  chmod -R 755 conf/mi/repository/resources/security capps || true
  echo "Set ownership to 802:802 and permissions on copied files."
fi

echo "Done. You can now run: docker compose up --build -d"
