#!/bin/bash


echo "[TASK 1] Setting hostname for this node to Kmaster"
hostnamectl set-hostname kmaster >/dev/null 2>&1

echo "[TASK 2] Adding newly created hostname to hosts file"
sed -i 's/^127.0.0.1 .*/127.0.0.1 localhost kmaster/' hosts >/dev/null 2>&1

echo "[Task 3] Please restart/reboot this system by ourself"
