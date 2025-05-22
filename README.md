# Bazzite GNOME ROCm

This project creates a customized Bazzite GNOME image with a downgraded kernel (6.13.7-107) to support ROCm on AMD hardware.

## Contents

- `recipes/recipe.yml`: The BlueBuild recipe to create the customized image

## Image Preparation

The image can be built using BlueBuild:

```bash
bluebuild build
```

This will create a local container image `localhost/bazzite-gnome-rocm:latest` that includes:
- Downgraded kernel to 6.13.7-107 (ROCm compatible)
- Build tools needed for kernel modules

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
You should see `6.13.7-107.bazzite.fc42.x86_64`.

### ROCm verification
To verify that ROCm works correctly:
```bash
/opt/rocm/bin/rocminfo
```

## Specific Problem Solved

This project solves the compatibility issue between ROCm and newer Linux kernel versions. ROCm requires specific kernel versions (in this case, 6.13.7) to work properly on AMD hardware, while Bazzite by default uses newer kernels.

## Changes Made

To enable full ROCm compatibility, the following adjustments were made:

### Removed Packages

Several stock kernel modules and third-party drivers were removed to simplify the image:

- **Kernel components**:
  - `kernel`
  - `kernel-core`
  - `kernel-modules`
  - `kernel-modules-extra`
  - `kernel-devel`
  - `kernel-modules-core`
- **Device modules**: 
  - `bmi260`, `kmod-bmi260`
  - `broadcom-wl`
  - `gpd-fan`, `kmod-gpd-fan`
  - `kmod-ayaneo-platform`, `ayaneo-platform`
  - `kmod-ayn-platform`, `ayn-platform`
  - `kmod-framework-laptop`, `framework-laptop-kmod-common`
  - `kmod-gcadapter_oc`, `gcadapter_oc`
  - `kmod-openrazer`, `openrazer-kmod-common`
  - `kmod-v4l2loopback`, `v4l2loopback`
  - `kmod-wl`
  - `kvmfr`, `kmod-kvmfr`
  - `nct6687d`, `kmod-nct6687d`
  - `ryzen-smu`, `kmod-ryzen-smu`
  - `kmod-vhba`, `vhba`
  - `kmod-xone`, `xone-kmod-common`
  - `kmod-zenergy`, `zenergy`

### Installed Packages

A custom Bazzite kernel and its modules were installed to replace the removed stock Bazzite components:

- [`kernel-6.13.7-107.bazzite.fc42.x86_64.rpm`](https://github.com/bazzite-org/kernel-bazzite/releases)
- [`kernel-core-6.13.7-107.bazzite.fc42.x86_64.rpm`](https://github.com/bazzite-org/kernel-bazzite/releases)
- [`kernel-modules-6.13.7-107.bazzite.fc42.x86_64.rpm`](https://github.com/bazzite-org/kernel-bazzite/releases)
- [`kernel-modules-core-6.13.7-107.bazzite.fc42.x86_64.rpm`](https://github.com/bazzite-org/kernel-bazzite/releases)
- [`kernel-modules-extra-6.13.7-107.bazzite.fc42.x86_64.rpm`](https://github.com/bazzite-org/kernel-bazzite/releases)
- [`kernel-devel-6.13.7-107.bazzite.fc42.x86_64.rpm`](https://github.com/bazzite-org/kernel-bazzite/releases)

This ensures maximum compatibility with AMD GPUs using the ROCm stack.

### Additional Software

- Added Obs Studio

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
