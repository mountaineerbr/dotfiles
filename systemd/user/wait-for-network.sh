#!/bin/bash
# Wait until the internet connection is established

while ! ping -c 1 -W 1 google.com; do
    sleep 1
done
