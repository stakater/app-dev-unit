#!/usr/bin/env bash

###############################################################################
# Copyright 2016 Aurora Solutions
#
#    http://www.aurorasolutions.io
#
# Aurora Solutions is an innovative services and product company at
# the forefront of the software industry, with processes and practices
# involving Domain Driven Design(DDD), Agile methodologies to build
# scalable, secure, reliable and high performance products.
#
# Stakater is an Infrastructure-as-a-Code DevOps solution to automate the
# creation of web infrastructure stack on Amazon. Stakater is a collection
# of Blueprints; where each blueprint is an opinionated, reusable, tested,
# supported, documented, configurable, best-practices definition of a piece
# of infrastructure. Stakater is based on Docker, CoreOS, Terraform, Packer,
# Docker Compose, GoCD, Fleet, ETCD, and much more.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
###############################################################################

##############################################
# This script is replaces template vars:
# <#APP_DOCKER_IMAGE#> & <#APP_DOCKER_OPTS#>
# with values pass through options
##############################################
DOCKER_IMAGE=""
DOCKER_OPTS=""
FILE=""
EXTRA_UNIT_OPTS=""

# Flags to make sure all required options are given
dOptionFlag=false;
fOptionFlag=false

# Get options from the command line
while getopts ":f:d:o:u:" OPTION
do
    case $OPTION in
        f)
          fOptionFlag=true
          FILE=$OPTARG
          ;;
        d)
          dOptionFlag=true
          DOCKER_IMAGE=$OPTARG
          ;;
        o)
		  DOCKER_OPTS=$OPTARG
		  ;;
		u)
		  EXTRA_UNIT_OPTS=$OPTARG
		  ;;
        *)
          echo "Usage: $(basename $0) -f <File location> -d <Docker Image> -o <Docker Options> (optional) -u <Unit options> (optional)"
          exit 0
          ;;
    esac
done

if ! $fOptionFlag || ! $dOptionFlag;
then
  echo "Usage: $(basename $0) -f <File location> -d <Docker Image> -o <Docker Options> (optional) -u <Unit options> (optional)"
  exit 0;
fi

# create a new file tf file without the .tmpl extension
newFile="${FILE%%.tmpl*}"
cp $FILE $newFile

perl -p -i -e "s|<#APP_DOCKER_IMAGE#>|$DOCKER_IMAGE|g" "$newFile"
perl -p -i -e "s|<#APP_DOCKER_OPTS#>|$DOCKER_OPTS|g" "$newFile"
perl -p -i -e "s|<#EXTRA_UNIT_OPTS#>|$EXTRA_UNIT_OPTS|g" "$newFile"

