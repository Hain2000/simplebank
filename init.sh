#!/bin/sh

make postgres
sleep 3
make createdb
make migrateup