#/bin/bash
set -eu

cd $(dirname "$0")

./setup.sh

docker build -t tizen/studio:2.0 -f Dockerfile .

echo "Done!"