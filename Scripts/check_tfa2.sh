#!/bin/bash
# check_tfa_params.sh

echo "=== OpenWrt TF-A 参数检查工具 ==="
echo ""

# 获取当前目录的环境变量
if [ -f .config ]; then
    echo "1. 从 .config 文件读取:"
    grep -E "(BOOT_DEVICE|DDR_TYPE|RAM_BOOT|USE_UBI|PLAT|NAND)" .config | head -20
    echo ""
fi

# 尝试从 make 获取
echo "2. 通过 make 获取变量:"
{
    echo "BOOT_DEVICE = $(make -s print-variable VARIABLE=BOOT_DEVICE 2>/dev/null | tail -1 || echo '未知')"
    echo "DDR_TYPE = $(make -s print-variable VARIABLE=DDR_TYPE 2>/dev/null | tail -1 || echo '未知')"
    echo "PLAT = $(make -s print-variable VARIABLE=PLAT 2>/dev/null | tail -1 || echo '未知')"
    echo "RAM_BOOT_UART_DL = $(make -s print-variable VARIABLE=RAM_BOOT_UART_DL 2>/dev/null | tail -1 || echo '未设置')"
    echo "USE_UBI = $(make -s print-variable VARIABLE=USE_UBI 2>/dev/null | tail -1 || echo '未设置')"
} 2>/dev/null

echo ""
echo "3. 模拟 TFA_MAKE_FLAGS 生成:"

# 模拟 Makefile 的逻辑
BOOT_DEVICE_VAL=$(make -s print-variable VARIABLE=BOOT_DEVICE 2>/dev/null | tail -1)
DDR_TYPE_VAL=$(make -s print-variable VARIABLE=DDR_TYPE 2>/dev/null | tail -1)
RAM_BOOT_VAL=$(make -s print-variable VARIABLE=RAM_BOOT_UART_DL 2>/dev/null | tail -1)
PLAT_VAL=$(make -s print-variable VARIABLE=PLAT 2>/dev/null | tail -1)
USE_UBI_VAL=$(make -s print-variable VARIABLE=USE_UBI 2>/dev/null | tail -1)

echo "BOOT_DEVICE=${BOOT_DEVICE_VAL}"
echo "USE_MKIMAGE=1"

if [ -n "$DDR_TYPE_VAL" ] && echo "$DDR_TYPE_VAL" | grep -q "ddr4"; then
    echo "DRAM_USE_DDR4=1"
fi

if [ -n "$RAM_BOOT_VAL" ]; then
    echo "RAM_BOOT_UART_DL=1"
    echo "编译目标: bl2"
else
    echo "编译目标: all"
fi

if [ -n "$USE_UBI_VAL" ]; then
    echo "UBI=1"
    case "$PLAT_VAL" in
        *mt7622*) echo "OVERRIDE_UBI_START_ADDR=0x80000" ;;
        *mt7981*) echo "OVERRIDE_UBI_START_ADDR=0x100000" ;;
        *mt7986*) echo "OVERRIDE_UBI_START_ADDR=0x200000" ;;
    esac
fi
