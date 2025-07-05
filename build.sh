#!/bin/bash

# Exit script when any command fails
set -e

# Init repo
repo init -u https://github.com/Miku-UI/manifesto.git -b Blooming --depth=1 --git-lfs

# Add local_manifests
mkdir -p .repo/local_manifests
cat > .repo/local_manifests/local_manifests.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
    <project name="tranguyenxuwu/device_rova" path="device/xiaomi/rova" remote="github" revision="15-dev" />
    <project name="iusmac/kernel_rova" path="kernel/xiaomi/rova" remote="github" revision="15-dev" />
    <project name="iusmac/vendor_rova" path="vendor/xiaomi/rova" remote="github" revision="15-dev" />
</manifest>
EOF

# Sync source using Crave’s script
/opt/crave/resync.sh

# Apply Pixel patch
cd hardware/google/pixel
git fetch https://github.com/LineageOS/android_hardware_google_pixel refs/changes/10/433410/1
git cherry-pick FETCH_HEAD
cd -

# Setup build environment
source device/xiaomi/rova/vendorsetup.sh
source build/envsetup.sh

# Lunch target
lunch miku_rova-bp2a-userdebug

# Build
make diva -j$(nproc --all)
