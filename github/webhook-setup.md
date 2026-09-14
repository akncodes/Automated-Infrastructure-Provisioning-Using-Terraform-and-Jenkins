# GitHub Webhook Setup

## 1. Open the repository settings

In GitHub:

- Open the repository
- Go to Settings
- Select Webhooks
- Click Add webhook

## 2. Configure the webhook

Set the following fields:

- Payload URL: Jenkins URL + `/github-webhook/`
- Content type: `application/json`
- Secret: optional, if configured in Jenkins
- Events: select `Push` events

## 3. Jenkins GitHub plugin

Install and configure the GitHub plugin in Jenkins if needed.

## 4. Trigger behavior

When code is pushed, Jenkins should trigger the pipeline automatically.
