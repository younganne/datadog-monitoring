# Monitoring

Using Terraform + DataDog to monitor Example Org's IT infrastructure (observability-as-code).

Alert the [Org StatusPage](https://example.statuspage.io/) on errors involving more than 10 minutes of site downtime.

Alert the IT Slack Channel and user@example.com on errors involving more than 3 minutes of site downtime.

Using DataDog Synthetic URL monitoring, monitor with just one browser (full-sized Chrome/Chromium or Firefox), once per hour, from two nodes: one in Western US, and another in Western Europe, one each from GCP and AWS. These limits are due to Datadog pricing.

If using another monitoring solution, more frequent might be appropriate - depending on costs.

Terraform file location: https://github.com/younganne/datadog-monitoring/blob/main/datadog/synthetic-url-monitoring/

## Details

* One test every hour
* Run in 2 test locations (Western US (AWS) and Western Europe (GCP))
One test browser type (full-sized laptop/desktop Chrome)

## Standard Workflow

To add/update/delete infrastructure, this is the general workflow:

1. Create a new branch off of main in this repo.
2. Update/add/etc to the terraform files in the datadog/synthetic-url-monitoring/ directory. You may need to manually test these changes first.
3. Pass in the variable values for datadog_api_key, datadog_app_key, and datadog_app_url as needed using your preferred secrets management method.
4. Commit and push your changes and open a pull request for the IT Team.
