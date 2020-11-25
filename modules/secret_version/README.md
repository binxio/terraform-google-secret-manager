
# Module `secret_version`

Core Version Constraints:
* `>= 0.13`

Provider Requirements:
* **google (`hashicorp/google`):** (any version)

## Input Variables
* `secret_data` (required): The data to be set
* `secret_id` (required): The full id of the secret for which to create a version for

## Output Values
* `id`: The resource name of the SecretVersion. Format: projects/{{project}}/secrets/{{secret_id}}/versions/{{version}}

## Managed Resources
* `google_secret_manager_secret_version.version` from `google`

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
