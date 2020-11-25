
# Module `secret`

Core Version Constraints:
* `>= 0.13`

Provider Requirements:
* **google (`hashicorp/google`):** (any version)

## Input Variables
* `environment` (required): Company environment for which the resources are created (e.g. dev, tst, acc, prd, all).
* `owner` (required): Owner of the resource. This variable is used to set the 'owner' label.
* `project` (required): Company project name.
* `purpose` (required): The purpose of the secret. This variable is appended to the secret_id and used to set the 'purpose' label.
* `replication` (default `{"automatic":true}`): The replication to be used
* `roles` (required): Map of role name's as `key` and members list as `value` to bind permissions

## Output Values
* `id`: Id of the secret
* `secret_id`: Id of the secret

## Managed Resources
* `google_secret_manager_secret.secret` from `google`
* `google_secret_manager_secret_iam_policy.map` from `google`

## Data Resources
* `data.google_iam_policy.map` from `google`

## Creating a new release
After adding your changed and committing the code to GIT, you will need to add a new tag.
```
git tag vx.x.x
git push --tag
```
If your changes might be breaking current implementations of this module, make sure to bump the major version up by 1.

If you want to see which tags are already there, you can use the following command:
```
git tag --list
```
