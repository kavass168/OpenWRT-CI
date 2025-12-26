#!/bin/bash

# 3. 覆盖适配文件到官方源码
cp $GITHUB_WORKSPACE/hy3000/filogic.mk $GITHUB_WORKSPACE/openwrt/target/linux/mediatek/image/
cp $GITHUB_WORKSPACE/hy3000/mt7981b-philips-hy3000.dts $GITHUB_WORKSPACE/openwrt/target/linux/mediatek/dts/
cp $GITHUB_WORKSPACE/hy3000/02_network $GITHUB_WORKSPACE/openwrt/target/linux/mediatek/filogic/base-files/etc/board.d/
cp $GITHUB_WORKSPACE/hy3000/platform.sh $GITHUB_WORKSPACE/openwrt/target/linux/mediatek/filogic/base-files/lib/upgrade/        
cp $GITHUB_WORKSPACE/hy3000/11-mt76-caldata $GITHUB_WORKSPACE/openwrt/target/linux/mediatek/filogic/base-files/etc/hotplug.d/firmware/ 
cp $GITHUB_WORKSPACE/hy3000/11_fix_wifi_mac $GITHUB_WORKSPACE/openwrt/target/linux/mediatek/filogic/base-files/etc/hotplug.d/ieee80211/
cp $GITHUB_WORKSPACE/hy3000/mediatek_filogic $GITHUB_WORKSPACE/openwrt/package/boot/uboot-tools/uboot-envtools/files/
cp $GITHUB_WORKSPACE/hy3000/hy3000.conf $GITHUB_WORKSPACE/openwrt/.config
mv -f $GITHUB_WORKSPACE/hy3000/boot-uboot-makefile $GITHUB_WORKSPACE/openwrt/package/boot/uboot-mediatek/Makefile
grep -q "philips_hy3000" "$GITHUB_WORKSPACE/openwrt/package/boot/uboot-mediatek/Makefile"
if [ $? -ne 0 ]; then
    echo "❌ Makefile 更新不成功"
    exit 1
else
    echo "✅ Makefile 更新成功"
fi

# cp $GITHUB_WORKSPACE/hy3000/437-add-cmcc_rax3000m+hy3000.patch $GITHUB_WORKSPACE/openwrt/package/boot/uboot-mediatek/patches/437-add-cmcc_rax3000m.patch

# 删除ax3000m 补丁，替换为hy3000的补丁
#rm $GITHUB_WORKSPACE/openwrt/package/boot/uboot-mediatek/patches/437-add-cmcc_rax3000m.patch
#cp $GITHUB_WORKSPACE/hy3000/437-add-philips-hy3000.patch $GITHUB_WORKSPACE/openwrt/package/boot/uboot-mediatek/patches/

grep -q "philips_hy3000" "$GITHUB_WORKSPACE/openwrt/package/boot/uboot-mediatek/patches/437-add-cmcc_rax3000m.patch"
if [ $? -ne 0 ]; then
    echo "❌ patch补丁更新不成功"
else
    echo "✅ patch补丁更新成功"
fi
