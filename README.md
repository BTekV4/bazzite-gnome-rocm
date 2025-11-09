# Bazzite GNOME ROCm

This project creates a customized Bazzite GNOME image with a longterm kernel (6.12) to support ROCm on AMD hardware.

## Contents

- `recipes/recipe.yml`: The BlueBuild recipe to create the customized image

## Image Preparation

The image can be built using BlueBuild:

```bash
bluebuild build
```

This will create a local container image `localhost/bazzite-gnome-rocm:latest` that includes:
- Longterm kernel 6.12 (ROCm compatible)
- Kernel modules from the longterm kernel repository

## Installation

To install the image, use the following command:

```bash
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/btekv4/bazzite-gnome-rocm:latest
```

After reboot, you'll have a version of Bazzite with the ROCm-compatible kernel.

## Verifying it works

### Kernel verification
To verify the system is using the correct kernel:
```bash
uname -r
```
You should see a kernel version starting with `6.12` (longterm kernel).

### ROCm verification
To verify that ROCm works correctly:
```bash
/opt/rocm/bin/rocminfo
```

## Specific Problem Solved

This project solves the compatibility issue between ROCm and newer Linux kernel versions. ROCm requires specific kernel versions (in this case, 6.12 longterm) to work properly on AMD hardware, while Bazzite by default uses newer kernels.

## Changes Made

To enable full ROCm compatibility, the following adjustments were made:

### Repository Configuration

A COPR repository is added to provide the longterm kernel:
- `https://copr.fedorainfracloud.org/coprs/kwizart/kernel-longterm-6.12/repo/fedora-43/kwizart-kernel-longterm-6.12-fedora-43.repo`

### Installed Packages

The longterm kernel and its modules are installed to replace the default kernel:

- `kernel-longterm`
- `kernel-longterm-core`
- `kernel-longterm-devel`
- `kernel-longterm-modules`
- `kernel-longterm-modules-extra`

This ensures maximum compatibility with AMD GPUs using the ROCm stack.

## ISO Creation

If you are building this on Fedora Atomic, you can generate an offline ISO following [these instructions](https://blue-build.org/docs/building-isos/).  
Note: Due to size constraints, ISOs cannot be freely hosted on GitHub; alternative hosting must be used for public distribution.

```bash
sudo bluebuild generate-iso --iso-name bazzite-gnome-rocm.iso image ghcr.io/btekv4/bazzite-gnome-rocm:latest
```

## Credits

This project is based on [Bazzite OS](https://github.com/ublue-os/bazzite).  
Special thanks to the Bazzite team for their original image.

---

Feel free to contribute to this project by forking, making pull requests, or providing feedback!
