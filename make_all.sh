#!/bin/bash

set -ex

[ -d "node_modules" ] || yarn

mkdir -p data/
mkdir -p tmp_data/
mkdir -p img/

if [[ $1 == "--no-download" ]]; then
  echo "not downloading ..."
else
  rm -rf data/*
  rm -rf tmp_data/*
  ./download.sh
  ./download_well.sh
  ./download_clojure.sh
fi

./generate.py
./generate_reserves.py

./generate_field_percentage_produced.py
./generate_giants.py
./generate_2000s.py
./generate_kumulativ_reservetilvekst_vs_produksjon.py
./generate_kumulativ_netto_reserver.py
./calc_wells.py
./calc_wells2.py
./calc_wells3.py
mkdir -p data/resources
./calc_resources2.py > data/resources/reserves_and_resources_mboe.csv
./generate_field_cumulative_reserves.py
./split_monthly_production.py
./split_discoveries.py
./split_wellbores.py
./overview.py > README.md
./make_screens.sh

rm -rf tmp_data/
