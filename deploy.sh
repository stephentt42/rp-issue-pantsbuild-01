#! /usr/bin/env bash
set -e 
set -o pipefail

./pants package function.py
gsutil cp dist/cloud_function.zip gs://$GCS_BUCKET/
gcloud functions deploy topstops \
    --source gs://$GCS_BUCKET/cloud_function.zip \
    --entry-point main.handler \
    --runtime python39 --trigger-http \
    --allow-unauthenticated --project $GCP_PROJECT
