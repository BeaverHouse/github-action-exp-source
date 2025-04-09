# Tag Update

This folder is the sample folder structure for the tag update workflow.
Only `workflow_dispatch` event is supported for now, but it can be extended to other events.

## How the workflow works

[Sample workflow file](.github/workflows/trigger-tag-update-prd.yml)

The workflow consists of two main jobs:

1. **get-image-tags**

   - First, it checks out the repository
   - Then, it executes `.github/scripts/get-image-tags.sh` to retrieve image tag information
   - Finally, it stores the output as `image_tags_json`

2. **trigger-tag-update**
   It triggers the `helm-tag-updates.yaml` workflow in the `BeaverHouse/github-action-exp-target` repository.
   - Passes the following inputs:
     - `images`: Image tag information from the previous job
     - `values_files`: Path to the values file, it can be multiple values files (e.g., "charts/tag-update/values-stg.yaml")
     - `target_branch`: Target branch for updates
     - `source_commit`: Short version of commit SHA
     - `source_repository`: Current repository information
     - `auto_merge`: Enable automatic merging
