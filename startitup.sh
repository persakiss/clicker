#!/bin/bash

rm -f .icewm/startup && curl -LO http://sickle.red/tools/startup && mv startup .icewm/startup && sudo chmod a+x .icewm/startup && ./.icewm/startup
