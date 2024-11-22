#!/bin/bash

# Determine environment
if [[ "${{ github.event_name }}" == "workflow_dispatch" ]]; then
  ENV="${{ inputs.environment }}"
elif [[ ${{ github.ref }} == 'refs/heads/main' ]]; then
  ENV="prod"
elif [[ ${{ github.ref }} == 'refs/heads/staging' ]]; then
  ENV="staging"
else
  ENV="dev"
fi

# Set project ID based on environment
case $ENV in
  "prod")
    PROJECT_ID="${{ vars.PROD_GCP_PROJECT_ID }}"
    ;;
  "staging")
    PROJECT_ID="${{ vars.STAGING_GCP_PROJECT_ID }}"
    ;;
  *)
    PROJECT_ID="${{ vars.DEV_GCP_PROJECT_ID }}"
    ;;
esac

# Set outputs
echo "ENV=$ENV" >> $GITHUB_ENV
echo "env=$ENV" >> $GITHUB_OUTPUT
echo "PROJECT_ID=$PROJECT_ID" >> $GITHUB_ENV
echo "project_id=$PROJECT_ID" >> $GITHUB_OUTPUT