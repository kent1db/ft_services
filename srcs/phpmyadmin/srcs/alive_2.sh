#!/bin/bash
sleep 30
while [ $(ps aux | grep nginx | wc -l) -gt 1 ]; do
	sleep 5
done
pkill php