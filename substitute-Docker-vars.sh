#!/usr/bin/env bash

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

