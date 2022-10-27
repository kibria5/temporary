# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/CherishOS/android_manifest -b tiramisu -g default,-mips,-darwin,-notdefault
git clone https://github.com/god-goku/local-manifest.git --depth 1 -b cherry .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

#58
# build rom
. build/envsetup.sh
export TZ=Asia/Dhaka #put before last build command
export BUILD_USER=Monu
export BUILD_HOST=cloud
export BUILD_USERNAME=Monu
export BUILD_HOSTNAME=cloud
brunch veux

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
