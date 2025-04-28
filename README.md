# bazzite-gnome-rocm

This repository contains a custom Fedora-based image built for supporting ROCm (Radeon Open Compute) stack on AMD GPUs. This version is tailored for users needing specific kernel modifications and dependencies for GPU compute workloads. The image is based on the Bazzite GNOME distribution, with an upgraded kernel and other necessary configurations for ROCm compatibility.

## Installation

> **Warning**  
> This is an experimental image. Use at your own risk.

To rebase an existing Fedora Atomic installation to this custom build:

1. Rebase to the unsigned image first to install proper signing keys and policies:

   ```bash
   rpm-ostree rebase ostree-unverified-registry:ghcr.io/btekv4/bazzite-gnome-rocm:latest
   ```

2. Reboot your system:

   ```bash
   systemctl reboot
   ```

3. Rebase to the signed image:

   ```bash
   rpm-ostree rebase ostree-image-signed:docker://ghcr.io/btekv4/bazzite-gnome-rocm:latest
   ```

4. Reboot again to finalize the installation:

   ```bash
   systemctl reboot
   ```

The `latest` tag always points to the most recent build, but the Fedora version will remain fixed based on what is declared in the `recipe.yml` file.

## ISO Creation

If you are building this on Fedora Atomic, you can generate an offline ISO following [these instructions](https://blue-build.org/docs/building-isos/).  
Note: Due to size constraints, ISOs cannot be freely hosted on GitHub; alternative hosting must be used for public distribution.

## Verification

This image is signed using [Sigstore's cosign](https://docs.sigstore.dev/cosign/overview).  
To verify the authenticity of the image:

1. Download the `cosign.pub` file from this repository.
2. Run:

   ```bash
   cosign verify --key cosign.pub ghcr.io/btekv4/bazzite-gnome-rocm
   ```

This ensures the build has not been tampered with.

## Changes for ROCm Support

To enable full ROCm compatibility, the following adjustments were made:

### Removed Packages

Several stock kernel modules and third-party drivers were removed to avoid conflicts with ROCm, including:

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

A custom Bazzite kernel and its modules were installed to replace the removed stock Fedora components:

- [`kernel-6.13.7-108.bazzite.fc42.x86_64.rpm`](https://github.com/bazzite-org/kernel-bazzite/releases)
- [`kernel-core-6.13.7-108.bazzite.fc42.x86_64.rpm`](https://github.com/bazzite-org/kernel-bazzite/releases)
- [`kernel-modules-6.13.7-108.bazzite.fc42.x86_64.rpm`](https://github.com/bazzite-org/kernel-bazzite/releases)
- [`kernel-modules-core-6.13.7-108.bazzite.fc42.x86_64.rpm`](https://github.com/bazzite-org/kernel-bazzite/releases)
- [`kernel-modules-extra-6.13.7-108.bazzite.fc42.x86_64.rpm`](https://github.com/bazzite-org/kernel-bazzite/releases)
- [`kernel-devel-6.13.7-108.bazzite.fc42.x86_64.rpm`](https://github.com/bazzite-org/kernel-bazzite/releases)

This ensures maximum compatibility with AMD GPUs using the ROCm stack.

## Credits

This project is maintained by **BTekV4**.  
Special thanks to the [Bazzite OS](https://github.com/ublue-os/bazzite) team for their original image and to the contributors who help make this project possible.

---

Feel free to contribute to this project by forking, making pull requests, or providing feedback!
