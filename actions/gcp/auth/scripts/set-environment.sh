#!/bin/bash

# Get inputs from environment variables that the action sets
EVENT_NAME="${GITHUB_EVENT_NAME}"
GITHUB_REF="${GITHUB_REF}"
INPUT_ENVIRONMENT="${INPUT_ENVIRONMENT}"

# Determine environment
if [[ "${EVENT_NAME}" == "workflow_dispatch" ]]; then
  ENV="${INPUT_ENVIRONMENT}"
elif [[ "${GITHUB_REF}" == "refs/heads/main" ]]; then
  ENV="prod"
elif [[ "${GITHUB_REF}" == "refs/heads/staging" ]]; then
  ENV="staging"
else
  ENV="dev"
fi

# Set project ID based on environment
case $ENV in
  "prod")
    PROJECT_ID="${PROD_GCP_PROJECT_ID}"
    ;;
  "staging")
    PROJECT_ID="${STAGING_GCP_PROJECT_ID}"
    ;;
  *)
    PROJECT_ID="${DEV_GCP_PROJECT_ID}"
    ;;
esac

# Set outputs
echo "ENV=$ENV" >> $GITHUB_ENV
echo "env=$ENV" >> $GITHUB_OUTPUT
echo "PROJECT_ID=$PROJECT_ID" >> $GITHUB_ENV
echo "project_id=$PROJECT_ID" >> $GITHUB_OUTPUT