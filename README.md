# GNOME build system Stage 3 files
GNOME is the second officially supported desktop environment on MassOS, alongside Xfce. Releases with GNOME should be provided starting from MassOS 2022.08.

The files in this directory are the GNOME Stage 3 files for the MassOS build system.

This GNOME port is currently maintained by no one.

Unlike Xfce, the GNOME port is not in the main MassOS repository, however it may be submoduled in the `stage3` directory. If it's not submoduled, you will of course need to put the files here in `stage3/gnome` to be able to build it with `./stage3.sh gnome`.

See the `README` file in the `stage3` directory of the MassOS repository for more information about Stage 3 in the MassOS build system.

Starting from MassOS 2022.08, issues with this GNOME port should be reported on the [main MassOS issue tracker](https://github.com/MassOS-Linux/MassOS/issues), **NOT** this Stage 3 repository.
