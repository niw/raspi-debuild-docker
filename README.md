Raspberry Pi OS deb package Build on Docker
===========================================

This repository contains a Docker file to prepare build environment to
create or modify deb packages for arm64 Raspberry Pi OS on macOS.

This Docker image is intended to be used on Apple Silicon Mac,
which runs arm64 docker image natively.
This means that it's only supporting to build packages for arm64
Raspberry Pi OS.


Instruction
-----------

To modify existing deb package for example, follow the next instruction.

```bash
# Build Docker image and run Docker process on the host.
make run

# Following is in the Docker process.

# Download the source pckage and build dependencies for the package
# to be modified.
apt source package-to-be-modified
apt build-dep package-to-be-modified

cd package-to-be-modified

# Create a new patch for the source.
quilt new patch-name.patch
# Repeaet to add files to be modified.
quilt add /path/to/file/being/modified

# Edit files added

# Update the patch.
quilt refresh

# Build deb pckage from the source with the new patch.
debuild -b -uc -us

# Copy the deb file built from Docker to the host.
cp package-modified.deb /host
```
