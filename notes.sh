# build using SDK:

#make V=s tools/install && make V=s toolchain/install
#make package/feeds/plan44/p44-ledchain/compile

wget https://downloads.openwrt.org/releases/18.06.1/targets/ramips/mt76x8/openwrt-sdk-18.06.1-ramips-mt76x8_gcc-7.3.0_musl.Linux-x86_64.tar.xz
tar xf openwrt-sdk-18.06.1-ramips-mt76x8_gcc-7.3.0_musl.Linux-x86_64.tar.xz
cd openwrt-sdk-18.06.1-ramips-mt76x8_gcc-7.3.0_musl.Linux-x86_64

cp feeds.conf.default feeds.conf
echo "src-git plan44 https://github.com/plan44/plan44-feed.git;master" >> feeds.conf
scripts/feeds update -a
scripts/feeds install kmod-p44-ledchain
make menuconfig
make V=s package/feeds/plan44/p44-ledchain/compile
find ./ -name *ledchain*

# ...correctly builds .ipk, but the kernel version doesn't match the current onion omega firmware...
# I tried the various SDK builds for openwrt-18.06.*, but neither uses 4.14.81 (18.06.01 is to low, 18.06.02 is to high). 
# Apparently Onion forked at some random point in time (4db74fbd6908db88eda4227ed3d18822c80b9ea1 ?) and OpenWRT
# bumped the kernel version again afterwards.
