# yank
Dependency manager

This is an attempt to generically resolve project dependencies by configuration file.  Any project wishing to use this will be required to have a '.yank' or 'yank.yaml' configuration file in the root directory of the project.

## Config File
The config file is a yaml file containing a list of yank elements defining dependencies.  As for the name of the file, this isn't required but it is recommended to name the file `.yank`.  The perk of using yank in this way allows for others to depend on libraries others create.  If those other libraries have a .yank file it will automatically recurse through each dependency until the entire tree is complete.
``` yaml
path: /opt/yank # path to directory with read/write permissions
yanks:
	- vcs: git # git is currently the only option
	  repo: https://github.com/jelathro/C.git # Link to repository for downloading
	  branch: master # Defaults to master for git
	  #tag: # If branch is specified tag must not be and vice versa
```
