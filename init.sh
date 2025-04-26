#!/bin/sh

make createdb
make postgres
make migrateup