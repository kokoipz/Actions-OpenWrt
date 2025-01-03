#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#


##########固件配置修改#########
# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

#修改默认IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

#web登陆密码从password修改为root
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF./root/g' openwrt/package/lean/default-settings/files/zzz-default-settings

#固件版本号添加个人标识和日期
[ -e package/lean/default-settings/files/zzz-default-settings ] && sed -i "s/DISTRIB_DESCRIPTION='.*LEDE '/DISTRIB_DESCRIPTION='FICHEN($(TZ=UTC-8 date +%Y.%m.%d))@LEDE '/g" package/lean/default-settings/files/zzz-default-settings
[ ! -e package/lean/default-settings/files/zzz-default-settings ] && sed -i "/DISTRIB_DESCRIPTION='*'/d" package/base-files/files/etc/openwrt_release
[ ! -e package/lean/default-settings/files/zzz-default-settings ] && echo "DISTRIB_DESCRIPTION='FICHEN($(TZ=UTC-8 date +%Y.%m.%d))@immortalwrt '" >> package/base-files/files/etc/openwrt_release


#修改主机名
sed -i "s/hostname='OpenWrt'/hostname='Redmi-AX6'/g" package/base-files/files/bin/config_generate
sed -i "s/hostname='ImmortalWrt'/hostname='Redmi-AX6'/g" package/base-files/files/bin/config_generate


##########固件主题添加&修改#########

#更换lede源码中自带argon主题
[ -e package/lean/default-settings/files/zzz-default-settings ] && rm -rf feeds/luci/themes/luci-theme-argon && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
#[ -e package/lean/default-settings/files/zzz-default-settings ] && rm -rf feeds/luci/themes/luci-theme-design feeds/luci/applications/luci-app-design-config && git_svn main https://github.com/fichenx/packages luci-theme-design luci-app-design-config

#为immortalwrt添加luci-theme-design
[ ! -e package/lean/default-settings/files/zzz-default-settings ] && git clone -b js https://github.com/papagaye744/luci-theme-design package/luci-theme-design


#修改默认主题
sed -i 's|set luci.main.mediaurlbase|#set luci.main.mediaurlbase|g' feeds/luci/themes/luci-theme-argon/root/etc/uci-defaults/30_luci-theme-argon
sed -i 's|set luci.main.mediaurlbase|#set luci.main.mediaurlbase|g' feeds/luci/themes/luci-theme-argon-mod/root/etc/uci-defaults/90_luci-theme-argon
sed -i 's|set luci.main.mediaurlbase|#set luci.main.mediaurlbase|g' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's|set luci.main.mediaurlbase|#set luci.main.mediaurlbase|g' feeds/luci/themes/luci-theme-material/root/etc/uci-defaults/30_luci-theme-material
sed -i 's|set luci.main.mediaurlbase|#set luci.main.mediaurlbase|g' feeds/luci/themes/luci-theme-netgear/root/etc/uci-defaults/30_luci-theme-netgear

sed -i 's/luci-theme-bootstrap/luci-theme-design/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-design/g' feeds/luci/collections/luci-light/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-design/g' feeds/luci/collections/luci-nginx/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-design/g' feeds/luci/collections/luci-ssl-nginx/Makefile

sed -i 's/luci-theme-argon/luci-theme-design/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-argon/luci-theme-design/g' feeds/luci/collections/luci-light/Makefile
sed -i 's/luci-theme-argon/luci-theme-design/g' feeds/luci/collections/luci-nginx/Makefile
sed -i 's/luci-theme-argon/luci-theme-design/g' feeds/luci/collections/luci-ssl-nginx/Makefile
