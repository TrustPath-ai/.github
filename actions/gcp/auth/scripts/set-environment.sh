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
elif [[ "${GITHUB_EVENT_NAME}" == "pull_request" ]]; then
  ENV="staging"
else
  ENV="dev"
fi

# Set project ID based on environment
case $ENV in
  "prod")
    PROJECT_ID="${PROD_GCP_PROJECT_ID}"
    WORKLOAD_IDENTITY_PROVIDER="${PROD_WORKLOAD_IDENTITY_PROVIDER}"
    ;;
  "staging")
    PROJECT_ID="${STAGING_GCP_PROJECT_ID}"
    WORKLOAD_IDENTITY_PROVIDER="${STAGING_WORKLOAD_IDENTITY_PROVIDER}"
    ;;
  *)
    PROJECT_ID="${DEV_GCP_PROJECT_ID}"
    WORKLOAD_IDENTITY_PROVIDER="${DEV_WORKLOAD_IDENTITY_PROVIDER}"
    ;;
esac

# Set outputs
echo "ENV=$ENV" >> $GITHUB_ENV
echo "env=$ENV" >> $GITHUB_OUTPUT
echo "PROJECT_ID=$PROJECT_ID" >> $GITHUB_ENV
echo "project_id=$PROJECT_ID" >> $GITHUB_OUTPUT
echo "WORKLOAD_IDENTITY_PROVIDER=$WORKLOAD_IDENTITY_PROVIDER" >> $GITHUB_ENV
echo "workload_identity_provider=$WORKLOAD_IDENTITY_PROVIDER" >> $GITHUB_OUTPUT