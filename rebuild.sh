#!/bin/bash

docker build -t="gchiam/storm" storm
docker build -t="gchiam/storm:0.10.0" storm
docker build -t="gchiam/storm-nimbus" storm-nimbus
docker build -t="gchiam/storm-supervisor" storm-supervisor
docker build -t="gchiam/storm-ui" storm-ui
