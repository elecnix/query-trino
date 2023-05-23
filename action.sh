#!/usr/bin/env bash

set -euo pipefail

TRINO_OUTPUT_FORMAT=${TRINO_OUTPUT_FORMAT:-ALIGNED}
echo "TRINO_OUTPUT_FORMAT: ${TRINO_OUTPUT_FORMAT}"

TRINO_CONFIG_FILE="$HOME/.trino_config"
echo "$TRINO_CONFIG" > "$TRINO_CONFIG_FILE"

TRINO_QUERY_FILE="$HOME/.trino_query"
echo "$TRINO_QUERY" > "$TRINO_QUERY_FILE"

curl -fLOsS "https://repo1.maven.org/maven2/io/trino/trino-cli/${TRINO_VERSION}/trino-cli-${TRINO_VERSION}-executable.jar"
mv "trino-cli-${TRINO_VERSION}-executable.jar" /usr/local/bin/trino
chmod +x /usr/local/bin/trino

EOF=$(dd if=/dev/urandom bs=15 count=1 status=none | md5sum | awk '{ print $1 }')
echo "result<<$EOF" >> "$GITHUB_OUTPUT"

echo >&2 "Executing query..."
TRINO_CONFIG=$TRINO_CONFIG_FILE java -Dorg.jline.terminal.dumb=true -jar "$(command -v trino)" \
    --password \
    -f "$TRINO_QUERY_FILE" \
    --output-format="$TRINO_OUTPUT_FORMAT" >> "$GITHUB_OUTPUT"

echo "$EOF" >> "$GITHUB_OUTPUT"
