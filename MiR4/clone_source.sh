#!/bin/bash

git clone "https://github.com/coolsnowwolf/lede.git"

pushd "lede"; 

# git reset --hard e2535799fbfa1806694a5c5699f1bbe842868771

# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default                                      #使用源码自带ShadowSocksR Plus软件
# sed -i -e '1s/$/^e82d730/g' feeds.conf.default
# sed -i -e '2s/$/^974fb04/g' feeds.conf.default
# sed -i -e '3s/$/^54fd237/g' feeds.conf.default
# sed -i -e '4s/$/^2071d9f/g' feeds.conf.default

sed -i "$imsize1/IMAGE_SIZE := .*/IMAGE_SIZE := 16064k/" target/linux/ramips/image/mt7621.mk
sed -i 's/ssid=OpenWrt/ssid=MIWIFI/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's/encryption=none/encryption=psk2/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i '/set wireless.default_radio${devidx}.encryption=psk2/a\set wireless.default_radio${devidx}.key=Password' package/kernel/mac80211/files/lib/wifi/mac80211.sh

./scripts/feeds update -a -f
./scripts/feeds install -a -f

popd
