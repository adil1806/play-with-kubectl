#!/bin/bash


echo "[TASK 1] Setting hostname for this node to Kworker"
hostnamectl set-hostname kworker >/dev/null 2>&1

echo "[TASK 2] Adding newly created hostname to hosts file"
sed -i 's/^127.0.0.1 .*/127.0.0.1 localhost kworker/' hosts >/dev/null 2>&1

echo "[Task 3] Please restart/reboot this system by ourself"
