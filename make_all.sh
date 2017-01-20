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
fi

./generate.py
./generate_reserves.py
./add_discovery_year.py
./drop_columns.py data/raw_reserves_field_discovery_year_mboe.csv fldRecoverableNGL fldRecoverableCondensate fldRemainingNGL fldRemainingCondensate
./generate_field_percentage_produced.py
./generate_giants.py
./generate_kumulativ_reservetilvekst_vs_produksjon.py
./calc_wells.py
./calc_resources2.py > data/reserves_and_resources_mboe.csv
./split_monthly_production.py
./split_discoveries.py
./split_wellbores.py
./overview.py > README.md
./make_screens.sh

rm -rf tmp_data/
