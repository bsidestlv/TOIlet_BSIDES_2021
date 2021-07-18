This is a kernel challenge (with a little web one at first :) ) !

To build a local environment to solve the chalenge you can do ont of the following:
1. Download a docker image that is the same as a remote one (with one one small difference :) )
	```
	docker run -d -p 3000:3000 myshelldocker/bsidesctf_2021_toilet_local
	```
2. Build the environment from scratch with a Dockerfile from this repository. Run in privileged mode:
	```
	git clone https://github.com/V3rochka/TOIlet_BSIDES_2021.git
	cd TOIlet_BSIDES_2021
	docker build -t bsidesctf_2021_toilet_local .
	docker run --privileged -d -p 3000:3000 bsidesctf_2021_toilet_local
	```
The `docker run` will take time, you can run it in non-detached mode (`-t`) to see the init proccess



Solve the challenge on the local environment and use a final exploit on the remote server.

About the bug:


1. Achieve RCE in our webservice.
2. 4.19.173 kernel, please achieve root privs with this [bug](https://github.com/torvalds/linux/commit/99253eb750fda6a644d5188fb26c43bad8d5a745) <br> *hint*: `/proc/kallsyms` and `/dev/kmsg` is readable





Good luck!!
