# 🌸 Miku UI Build Script for Rova (Blooming Branch)

This project provides a ready-to-use bash script to automate the process of syncing and building Miku UI for the **Xiaomi (Rolex/Riva)** device.

## 📋 Table of Contents

- [Requirements](#-requirements)
- [Quick Start](#-quick-start)
- [Build Methods](#-build-methods)
  - [Method 1: One-liner Command](#method-1-one-liner-command)
  - [Method 2: Using build.sh Script (Recommended)](#method-2-using-buildsh-script-recommended)
- [Credits](#-credits)

## 🔧 Requirements

Before starting, ensure you have:

- **`crave`** AOSP account and CLI tool installed, or ssh tunnel to run these scripts

## 🚀 Quick Start

```bash
crave run --no-patch -- "bash <(curl -fsSL https://raw.githubusercontent.com/tranguyenxuwu/miku-rova-build-script/main/build.sh)"
```

## 🛠️ Build Methods

### Method 1: One-liner Command

Copy and paste the command below directly into your terminal:

```bash
crave run --no-patch -- "repo init -u https://github.com/Miku-UI/manifesto.git -b Blooming --depth=1 --git-lfs; \
mkdir -p .repo/local_manifests && echo '<?xml version=\"1.0\" encoding=\"UTF-8\"?><manifest><project name=\"tranguyenxuwu/device_rova\" path=\"device/xiaomi/rova\" remote=\"github\" revision=\"15-dev\" /><project name=\"iusmac/kernel_rova\" path=\"kernel/xiaomi/rova\" remote=\"github\" revision=\"15-dev\" /><project name=\"iusmac/vendor_rova\" path=\"vendor/xiaomi/rova\" remote=\"github\" revision=\"15-dev\" /></manifest>' > .repo/local_manifests/local_manifests.xml; \
/opt/crave/resync.sh; \
(cd hardware/google/pixel && git fetch https://github.com/LineageOS/android_hardware_google_pixel refs/changes/10/433410/1 && git cherry-pick FETCH_HEAD); \
source device/xiaomi/rova/vendorsetup.sh; \
source build/envsetup.sh; \
lunch miku_rova-bp2a-userdebug; \
make diva -j\$(nproc --all)"
```

### Method 2: Using build.sh Script (Recommended)

Use the provided bash script for better readability and maintainability.

```bash
crave run --no-patch -- "bash <(curl -fsSL https://raw.githubusercontent.com/tranguyenxuwu/miku-rova-build-script/main/build.sh)"
```

#### What the script does:

- Initializes the repo with the Miku-UI Blooming branch
- Adds the required local manifests for the Rova device
- Syncs all sources via Crave
- Applies the necessary patch for Pixel components
- Sets up the build environment
- Starts the build using `make diva`

## 🙏 Credits

- **[Miku UI](https://github.com/Miku-UI)** - The beautiful custom ROM
- **[@iusmac](https://github.com/iusmac)** - For the Rova device tree, vendor blobs and kernel
- **[LineageOS](https://github.com/LineageOS)** - For upstream support and patches

---

> 💡 **Need help?** Feel free to open an issue if you encounter any problems during the build process.
