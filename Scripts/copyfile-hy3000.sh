#!/bin/bash

# 3. 覆盖适配文件到官方源码
cp $GITHUB_WORKSPACE/hy3000/filogic.mk $GITHUB_WORKSPACE/wrt/target/linux/mediatek/image/

mv -f $GITHUB_WORKSPACE/hy3000/$MY_DTS $GITHUB_WORKSPACE/wrt/target/linux/mediatek/dts/mt7981b-philips-hy3000.dts
grep -q "hy3000" "$GITHUB_WORKSPACE/wrt/target/linux/mediatek/dts/mt7981b-philips-hy3000.dts"
if [ $? -ne 0 ]; then
    echo "❌ DTS 更新不成功"
else
    echo "✅ DTS 更新成功"
fi

cp $GITHUB_WORKSPACE/hy3000/02_network $GITHUB_WORKSPACE/wrt/target/linux/mediatek/filogic/base-files/etc/board.d/
cp $GITHUB_WORKSPACE/hy3000/platform.sh $GITHUB_WORKSPACE/wrt/target/linux/mediatek/filogic/base-files/lib/upgrade/        
cp $GITHUB_WORKSPACE/hy3000/11-mt76-caldata $GITHUB_WORKSPACE/wrt/target/linux/mediatek/filogic/base-files/etc/hotplug.d/firmware/ 
cp $GITHUB_WORKSPACE/hy3000/11_fix_wifi_mac $GITHUB_WORKSPACE/wrt/target/linux/mediatek/filogic/base-files/etc/hotplug.d/ieee80211/
mv -f $GITHUB_WORKSPACE/hy3000/uboot-tools-uboot-envtools-files-mediatek_filogic $GITHUB_WORKSPACE/wrt/package/boot/uboot-tools/uboot-envtools/files/mediatek_filogic

# cp $GITHUB_WORKSPACE/hy3000/hy3000.conf $GITHUB_WORKSPACE/openwrt/.config

mv -f $GITHUB_WORKSPACE/hy3000/boot-uboot-makefile $GITHUB_WORKSPACE/wrt/package/boot/uboot-mediatek/Makefile
grep -q "philips_hy3000" "$GITHUB_WORKSPACE/wrt/package/boot/uboot-mediatek/Makefile"
if [ $? -ne 0 ]; then
    echo "❌ uboot-mediatek/Makefile 更新不成功"
else
    echo "✅ uboot-mediatek/Makefile 更新成功"
fi

# cp $GITHUB_WORKSPACE/hy3000/437-add-cmcc_rax3000m+hy3000.patch $GITHUB_WORKSPACE/openwrt/package/boot/uboot-mediatek/patches/437-add-cmcc_rax3000m.patch

# 复制hy3000的补丁
#rm $GITHUB_WORKSPACE/wrt/package/boot/uboot-mediatek/patches/437-add-cmcc_rax3000m.patch
cp $GITHUB_WORKSPACE/hy3000/473-add-philips-hy3000.patch $GITHUB_WORKSPACE/wrt/package/boot/uboot-mediatek/patches/

grep -q "philips_hy3000" "$GITHUB_WORKSPACE/wrt/package/boot/uboot-mediatek/patches/473-add-philips-hy3000.patch"
if [ $? -ne 0 ]; then
    echo "❌ patch补丁更新不成功"
else
    echo "✅ patch补丁更新成功"
fi

mv -f $GITHUB_WORKSPACE/hy3000/arm-trusted-firmware-mediatek-#Makefile $GITHUB_WORKSPACE/wrt/package/boot/arm-trusted-firmware-mediatek/Makefile

grep -q "trusted-firmware-a-mt7981-emmc-ddr4" "$GITHUB_WORKSPACE/wrt/package/boot/arm-trusted-firmware-mediatek/Makefile"
if [ $? -ne 0 ]; then
    echo "❌ arm-trusted-firmware 更新不成功"
else
    echo "✅ arm-trusted-firmware 更新成功"
fi

