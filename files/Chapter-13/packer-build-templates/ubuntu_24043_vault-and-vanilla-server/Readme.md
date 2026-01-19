# What is Subiquity

Subiquity is the Ubuntu server’s new automated installer, which was introduced in 18.04. It is the server counterpart of ubiquity installer used by desktop live CD installation.

Autoinstallation lets you answer all those configuration questions ahead of time with autoinstall config and lets the installation process run without any external interaction. The autoinstall config is provided via cloud-init configuration. Values are taken from the config file if set, else default values are used.

There are multiple ways to provide configuration data for cloud-init. Typically user config is stored in user-data and cloud specific config in meta-data file. The list of supported cloud datasources can be found in cloudinit docs. Since packer builds it locally, data source is NoCloud in our case and the config files will served to the installer over http.

Clues on how to hack around the ssh server limitation:

* [https://github.com/geerlingguy/packer-boxes/pull/61/commits](https://github.com/geerlingguy/packer-boxes/pull/61/commits "Site to hack around ssh timeout")
* [https://github.com/hashicorp/packer/issues/9115](https://github.com/hashicorp/packer/issues/9115 "Packer thread stating the issue")

## Command to Run

```bash

packer build .
```

```bash
# With optional runtime variables, values default to false and 2048
packer build -var 'headless_build=true' -var 'memory_amount=8192' .
```
