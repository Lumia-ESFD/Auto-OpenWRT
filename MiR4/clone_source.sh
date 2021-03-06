#!/bin/bash

git clone "https://github.com/coolsnowwolf/lede.git" OpenWRT

pushd "OpenWRT"; 

# git reset --hard e2535799fbfa1806694a5c5699f1bbe842868771

# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default                                      #使用源码自带ShadowSocksR Plus软件
# sed -i -e '1s/$/^e82d730/g' feeds.conf.default
# sed -i -e '2s/$/^974fb04/g' feeds.conf.default
# sed -i -e '3s/$/^54fd237/g' feeds.conf.default
# sed -i -e '4s/$/^2071d9f/g' feeds.conf.default

export shanchu1=$(grep  -a -n -e '&spi0 {' target/linux/ramips/dts/mt7621_xiaomi_mi-router-4.dts|cut -d ":" -f 1)
export shanchu2=$(grep  -a -n -e '&pcie {' target/linux/ramips/dts/mt7621_xiaomi_mi-router-4.dts|cut -d ":" -f 1)
export shanchu2=$(expr $shanchu2 - 1)
export shanchu2=$(echo $shanchu2"d")
sed -i $shanchu1,$shanchu2 target/linux/ramips/dts/mt7621_xiaomi_mi-router-4.dts
grep  -Pzo '&spi0[\s\S]*};[\s]*};[\s]*};[\s]*};' target/linux/ramips/dts/mt7621_youhua_wr1200js.dts > youhua.txt
echo "" >> youhua.txt
echo "" >> youhua.txt
export shanchu1=$(expr $shanchu1 - 1)
export shanchu1=$(echo $shanchu1"r")
sed -i "$shanchu1 youhua.txt" target/linux/ramips/dts/mt7621_xiaomi_mi-router-4.dts
rm -rf youhua.txt

export imsize1=$(grep  -a -n -e 'define Device/xiaomi_mir4' target/linux/ramips/image/mt7621.mk|cut -d ":" -f 1)
export imsize1=$(expr $imsize1 + 2)
export imsize1=$(echo $imsize1"s")

sed -i "$imsize1/IMAGE_SIZE := .*/IMAGE_SIZE := 16064k/" target/linux/ramips/image/mt7621.mk
sed -i 's/ssid=OpenWrt/ssid=MIWIFI/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's/encryption=none/encryption=psk2/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i '/set wireless.default_radio${devidx}.encryption=psk2/a\set wireless.default_radio${devidx}.key=Password' package/kernel/mac80211/files/lib/wifi/mac80211.sh

./scripts/feeds update -a -f
./scripts/feeds install -a -f

popd
