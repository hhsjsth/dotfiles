#!/bin/bash
# 等待驱动加载稳固
sleep 5
echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
