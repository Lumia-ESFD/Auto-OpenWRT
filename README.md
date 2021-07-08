# Auto-OpenWRT
0、目录为openwrt, 若是其他源（比如lede的源码），将文件夹重命名为openwrt（mv命令）

1、此步Actions自动完成

  sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3 python2.7 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf wget curl swig rsync

2、进入SSH命令
  下载openwrt源码:
  git clone https://git.lede-project.org/source.git lede
  git clone https://github.com/openwrt/openwrt.git
  git clone https://github.com/coolsnowwolf/lede

  OpenWRT的源码版本不同可能会导致编译OpenWRT时出现问题
  git clone -b openwrt-18.06 https://github.com/openwrt/openwrt.git
  上一行代码可以调用下载18.06版本的OpenWRT源码。
  或者去官网找所需要的版本。

  mv ** openwrt
  cd openwrt

  修改源，添加包
  
  vim feeds.conf.default

  添加对16m Flash的支持
  
  vim target/linux/ath79/image/tiny-tp-link.mk

  ./scripts/feeds update -a
  
  ./scripts/feeds install -a

  make menuconfig
  
  exit后程序继续自动执行后续操作

3、此步骤Actions自动完成

  make -j8 download V=s
  
  make -j$(($(nproc) + 1)) V=s

