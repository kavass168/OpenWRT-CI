#!/bin/bash

echo "=== hy3000 构建环境自检（openwrt/）开始 ==="

ROOT="$GITHUB_WORKSPACE/openwrt"

# 1. 检查 filogic.mk
if [ ! -f "$ROOT/target/linux/mediatek/image/filogic.mk" ]; then
    echo "❌ 缺少 $ROOT/target/linux/mediatek/image/filogic.mk"
else
    echo "✅ filogic.mk 存在"
fi

grep -q "Device/philips_hy3000" "$ROOT/target/linux/mediatek/image/filogic.mk"
if [ $? -ne 0 ]; then
    echo "❌ filogic.mk 中没有 Device/philips_hy3000 定义"
else
    echo "✅ filogic.mk 中包含 Device/philips_hy3000"
fi

# 2. 检查 DTS
if [ ! -f "$ROOT/target/linux/mediatek/dts/mt7981b-philips-hy3000.dts" ]; then
    echo "❌ 缺少 DTS：$ROOT/target/linux/mediatek/dts/mt7981b-philips-hy3000.dts"
else
    echo "✅ DTS 文件存在"
fi

# 3. 检查 .config
if [ ! -f "$ROOT/.config" ]; then
    echo "❌ 缺少 $ROOT/.config（构建无法继续）"
else
    echo "✅ .config 存在"
fi

grep -q "philips_hy3000=y" "$ROOT/.config"
if [ $? -ne 0 ]; then
    echo "❌ .config 未启用 hy3000"
else
    echo "✅ .config 已启用 hy3000"
fi

echo "=== ✅ hy3000 构建环境自检完成（openwrt/）==="
exit 0
