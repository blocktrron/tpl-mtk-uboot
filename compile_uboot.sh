#!/usr/bin/env bash

BOARD=$1
BUILDROOT=buildroot-gcc342
AVAILABLE_BOARDS=$(ls | grep -P '_config$' | sed 's/_config//')

print_board_list () {
	echo "No valid Board set!"
	echo "Valid boards:"
	for B in $AVAILABLE_BOARDS; do
		echo "* ${B}"
	done

}

if [ -z "$BOARD" ]; then
	print_board_list
	exit 1
fi

rm .config autoconf.h

if [ ! -d "$BUILDROOT" ]; then
	tar -xjf ${BUILDROOT}.tar.bz2
fi
ln -s ${BOARD}_config .config
ln -s ${BOARD}_autoconf_h autoconf.h
FACTORY_UBOOT=n make
