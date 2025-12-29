#!/bin/bash
echo "=== TF-A 编译标志检查 ==="
echo "BOOT_DEVICE: ${BOOT_DEVICE:-未设置}"
echo "DDR_TYPE: ${DDR_TYPE:-未设置}"
echo "USE_UBI: ${USE_UBI:-未设置}"
echo "RAM_BOOT_UART_DL: ${RAM_BOOT_UART_DL:-未设置}"
echo "PLAT: ${PLAT:-未设置}"
echo "FIP_OFFSET: ${FIP_OFFSET:-未设置}"
echo "FIP_SIZE: ${FIP_SIZE:-未设置}"

# 模拟 TFA_MAKE_FLAGS 构建
echo -e "\n=== 模拟的 TFA_MAKE_FLAGS ==="
echo "BOOT_DEVICE=${BOOT_DEVICE}"
echo "USE_MKIMAGE=1"

if [ -n "$DDR_TYPE" ] && echo "$DDR_TYPE" | grep -q "ddr4"; then
    echo "DRAM_USE_DDR4=1"
fi

if [ -n "$RAM_BOOT_UART_DL" ]; then
    echo "RAM_BOOT_UART_DL=1"
    echo "编译目标: bl2"
else
    echo "编译目标: all"
fi

if [ -n "$USE_UBI" ]; then
    echo "UBI=1"
    if [ -n "$PLAT" ]; then
        case "$PLAT" in
            *mt7622*) echo "OVERRIDE_UBI_START_ADDR=0x80000" ;;
            *mt7981*) echo "OVERRIDE_UBI_START_ADDR=0x100000" ;;
            *mt7986*) echo "OVERRIDE_UBI_START_ADDR=0x200000" ;;
        esac
    fi
fi

if [ -n "$FIP_OFFSET" ]; then
    echo "OVERRIDE_FIP_BASE=$FIP_OFFSET"
fi

if [ -n "$FIP_SIZE" ]; then
    echo "OVERRIDE_FIP_SIZE=$FIP_SIZE"
fi


echo "BOOT_DEVICE=$BOOT_DEVICE"
echo "PLATFORM=$PLAT"
echo "TARGET=$(grep CONFIG_TARGET_BOARD .config)"
echo "SUBTARGET=$(grep CONFIG_TARGET_SUBTARGET .config)"
echo "PROFILE=$(grep CONFIG_TARGET_PROFILE .config)"
    
