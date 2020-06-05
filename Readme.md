# azure_eval_function

Simple azure servless function and runs eval in python.
Deployed via Docker using ansible internally.

# Concepts

## Azure

The azure serverless functions
https://azure.microsoft.com/en-us/services/functions/

### Subscription

The subscription is the billing address that the service runs on.

### Resource Group

All of the resources are grouped together in a resource group.

### App Service Resource

The function has a source code repository and a url to access it.

### App Service Plan Resource

A plan on how to scale your service, instance size and count. Used to autoscale your app.

### Storage Account Resource

Azure Functions use a container storage to store the function file system.

## Docker

We use docker internally to make a reproducible build. You pick a base operating system image and build your application on top of that. 

## Ansible

Ansible is used inside of docker to talk to the azure.


# Implementation

## Execution

The simplist way to run is via 
`make`

## Testing

TODO

## Teardown 

Remember to tear down the system when you are not using to save money, storage and functions cost money.

TODO

## Login to azure from debian

Prepare your debian system like this.

If you are running in wsl you need to install xming to get the display to show on windows

    export DISPLAY=<your ip address>:0.0

Setup the azure functions for debian

	sudo apt-get install curl
	curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
	sudo apt-get install chromium
	
To do the login we run 

	az login
	
Finally we have to copy the credentials to a location in the docker working area so it is available to copy into the container.

	cp -r ~/.azure/ secret/.azure

References :
https://mukeshnotes.wordpress.com/2017/01/04/login-to-azure-powershell-options/
https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest
https://github.com/microsoft/WSL/issues/4106

## Debian

The debian packages I installed 

```
emacs
tmux
ansible
gcc
git
x11-apps
```

## WSL

I used chocolaty to setup a windows machine for running debian in the wsl2 docker container.

References:

https://docs.docker.com/docker-for-windows/wsl/

### Chocolaty

packages I have installed locally

```
Chocolatey v0.10.15
azure-cli v2.7.0
chocolatey v0.10.15
chocolatey-core.extension v1.3.5.1
chocolatey-fastanswers.extension v0.0.2
chocolatey-windowsupdate.extension v1.0.4
chromium v83.0.4103.61
docker-desktop v2.3.0.3
DotNet4.5.2 v4.5.2.20140902
grep v2.1032
KB2919355 v1.0.20160915
KB2919442 v1.0.20160915
KB2999226 v1.0.20181019
KB3033929 v1.0.5
KB3035131 v1.0.3
KB3118401 v1.0.4
microsoft-windows-terminal v1.0.1401.0
powershell-core v7.0.1
python v3.8.3
python3 v3.8.3
vcredist140 v14.26.28720.3
vcredist2015 v14.0.24215.20170201
vcredist2017 v14.16.27033
vscode v1.45.1
vscode.install v1.45.1
wsl v1.0.1
Xming v6.9.0.31
git.install v2.27.0
git v2.27.0
az.powershell
azurepowershell
```
## Docker

Developed on Debian it uses Docker for saving of the results of the individual steps of ansible.
Ansible is executed multiple times in Docker using the `--tags` to select which tasks to run.

For this, Multiple ansible executions are packaged into docker RUN steps in the Dockerfile.
Files are added with ADD to docker only as needed to prevent the re-execution of previous steps, if you change a file previously used it will rerun the the following steps.

## Ansible-Docker-Target-Graph

An Idea for the future.

We want to create a dependency graph for each group of hosts of ansible tasks to execute in order and tag the results in docker at run time.

Instead of using docker build we could use docker execute on a base image or starting tag. Each step would bring the starting tag to the ending tag in docker, ending in a commit.

It should be possible to automatically select which steps to execute by looking at the docker images available and looking at external dependencies.

Each tagged image would be part of a dependency graph.

We can align ansible tags and targets with the docker images that are tagged.

### Ansible-Target

So we have ansible tags on tasks to execute on groups of hosts that are named,

We can combine them to call it an ansible-target.

### Ansible-Target-Deps

Each ansible-target has dependencies, so other targets, git controlled files or other external things. Each of those can be checked as needed and the docker-target-label updated with information.

A tool to check the depedencies between ansible-targets so that if one gets updated, the others will need to be recalculated.

Also given local source files or other information we want to invalidate or update the docker tags.

So one tool would be to take a source tag and add in the source files or dependency information, and update the end tag if the source file or external system returns a different information.
