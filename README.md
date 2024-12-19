# Slough - GitHub Action - Determine tags for Docker container

GitHub action to generate a list of tags for a containerimage, based on the branch and the commit hash.

## Example

Usage:

```yaml
---
jobs:
  generate-container-tags:
    runs-on: ubuntu-latest
    outputs:
      tags: ${{ steps.generate-version.outputs.tags }}
    steps:
      - uses: DarylStark/slough-gha-ac-container-tag-generator@v1
        id: generate-version
        with:
          container-repository: my-repo
          container-name: my-container
          version: 1.0.1
```

This will create two tags at least:

-   `my-repo/my-container:1.0.1`
-   `my-repo/my-container:<commit-hash>`

If you are commiting this to `main`, a `latest` tag will also be created. If you are commiting this to `dev`, a `latest-dev` tag will also be created.

## Inputs

The following inputs are supported:

-   `container-repository`: (__required__) The repository where the container is stored. This is the first part of the tag.
-   `container-name`: The name of the container. This is the second part of the tag. If not given, it will be the repository name.
-   `version`: The version of the container. This is the third part of the tag. If not given, this tag will not be created.

## Outputs

The following outputs are supported:

-   `tags`: A list of tags that have been generated.
