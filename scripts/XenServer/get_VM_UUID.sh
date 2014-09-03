#!/bin/bash
xe vm-list name-label=$1 | awk '/uuid/ {print $5}'
