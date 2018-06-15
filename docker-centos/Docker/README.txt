

===================================================================

Due to Fedora Atomic's OSTree your version of Nvidia is limited to
the specific version VERSION. Fedora Atomic doesn't support DKMS.
If you need to upgrade your kernel, install new packages, it is
then important to uninstall Nvidia before and reinstall it after
you processed your changed. Execute all these commands as root.
The Nvidia installer as well as this README is regenerated if it is
necessary by restart the docker daemon (service docker restart).

Enter the home directory :

	cd /home/fedora/

Uninstall the Nvidia driver:

	./NVIDIA-Linux-x86_64-VERSION.run --uninstall

Then process your upgrades and package installations and reboot:

	systemctl reboot

Check afterwards if your kernel-devel are still compliant:

	ll /usr/lib/modules/`uname -r`/build

If the symlink build is broken you have to install the new devel 
kernel header changed install the compliant ones. Check your local
and layered packages to install your current devel

	rpm-ostree status
	rpm-ostree uninstall <kernel-devel-rpms>
	systemctl reboot

Install the new ones with rpm-ostree, preferably locally after you
downloaded them from koji:

	curl -LO https://kojipkgs.fedoraproject.org/packages/kernel/<>
	rpm-ostree install <kernel-devel-rpms>
	systemctl reboot

Reinstall nvidia:

	ostree admin unlock --hotfix
	chmod u+x NVIDIA-Linux-x86_64-VERSION.run
	./NVIDIA-Linux-x86_64-VERSION.run --dkms --no-drm -s
	nvidia-smi

===================================================================
