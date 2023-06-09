This is a set of scripts meant to aid with deployment of dev clouds.

# Prerequisites
- Cloned `CydarLtd/ops` repo
- aws-vault installed
- activated python virtual environment in `ops/provisioning` 
- python reqs installed from `ops/provisioning`
    - run `pip install -r requirements.txt`
- AMI manifest file in the `ops/provisioning` directory

# Setup
- suggested: clone this repo into your `~/bin` directory and add it to your path
    - add `export PATH=$HOME/bin:$HOME/bin/deploy_scripts:$PATH` to your .bashrc file
- add a file `.env` in your `ops/provisioning` repo. Add the following environment variables:
```
    export CLOUD_USER=<cloud_user>
    export RELEASE_TAG=<release_tag>
    export CLOUD_PURPOSE=development
    export DEVICE_IDENTIFIER=<device_id>
    export CLOUD_REGION=eu-west-1
    export AMI_MANIFEST=<ami_manifest>
    export AWSV_PROFILE=<aws-vault_profile>
```

# Usage
- cd to `.../ops/provisioning`
- run `deploy_cloud`
    - if no args are provided a full deployment with prompts will be executed
    - add one of the following stages as an argument to run just that stage:
        - preop
        - vault
        - compute
        - guicloud
        - connect
    - if a stage plus arg `-a` is provided then full deployment will proceed from that stage
        - i.e. `deploy_cloud compute -a` will deploy compute and subsequent stages
- at the end of each stage, if successful you will be prompted to deploy the next stage
- any variables which are required from a previous stage are printed to the terminal to be checked - the method of extracting these is not the cleanest so double check before proceeding.
    - the following variables are extracted:
        - `PREOP_MANIFEST` from `preop` output
        - `VAULT_API_HOST` from `vault` output
        - `GUICLOUD_API_HOST` from `guicloud` output
    - these are stored in the `.env` file automatically
    - these are also logged to `deploy_env_log.txt` for posterity