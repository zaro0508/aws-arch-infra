#!/bin/bash
set -ex

ACCOUNT_NAME="$1"

# some projects deploy to multiple AWS accounts, dev/stage/prod/etc..
# we manage this by using git branches, travis vars and double interpolation
# of environment variables.
eval export "AwsCfServiceRoleArn=\$AwsCfServiceRoleArn_$ACCOUNT_NAME"
eval export "AwsTravisAccessKey=\$AwsTravisAccessKey_$ACCOUNT_NAME"
eval export "AwsTravisSecretAccessKey=\$AwsTravisSecretAccessKey_$ACCOUNT_NAME"


# setup the awscli with the correct aws account info.
pip install awscli
mkdir -p ~/.aws
echo -e "[default]\nregion=us-east-1\nsource_profile=default\nrole_arn=$AwsCfServiceRoleArn" > ~/.aws/config
echo -e "[default]\nregion=us-east-1\naws_access_key_id=$AwsTravisAccessKey\naws_secret_access_key=$AwsTravisSecretAccessKey" > ~/.aws/credentials
