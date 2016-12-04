#!/bin/bash

set -ex

rm -rf data/
rm -rf tmp_data/
mkdir data/
mkdir tmp_data/

./download.sh
./generate.py
./generate_reserves.py
./overview.py > README.md
./screenshots_production.sh
./screenshots_produced_reserves.sh

rm -rf tmp_data/
