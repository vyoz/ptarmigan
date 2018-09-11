#!/bin/sh

func_upd() {
	if [ -d $1 ]; then
		cd $1
		git checkout $3
		git pull
		cd ..
	else
		echo "$1" not found
	fi
}

func_tag() {
	if [ -d $1 ]; then
		cd $1
		git checkout $3
		git pull
		git checkout $4
		cd ..
	else
		echo "$1" not found
	fi
}

######################################################
git submodule update --init --recursive

cd libs

# change URL
cd inih
CNT=`git remote -v | grep -c benhoyt`
if [ $CNT -ne 0 ]; then
	git checkout master
	git remote set-url origin https://github.com/nayutaco/inih.git
	git fetch
fi
cd ..

cd lmdb
CNT=`git remote -v | grep -c LMDB`
if [ $CNT -ne 0 ]; then
	git checkout mdb.master
	git remote set-url origin https://github.com/nayutaco/lmdb.git
	git fetch
fi
cd ..

func_upd jsonrpc-c https://github.com/nayutaco/jsonrpc-c.git localonly
func_tag inih https://github.com/nayutaco/inih.git master gnu_prefix
func_upd libbase58 https://github.com/luke-jr/libbase58.git master
func_tag lmdb https://github.com/nayutaco/lmdb.git mdb.master gnu_prefix
func_tag mbedtls https://github.com/ARMmbed/mbedtls.git development mbedtls-2.12.0
func_upd libev https://github.com/enki/libev.git master
func_upd jansson https://github.com/akheron/jansson.git master
func_upd curl https://github.com/curl/curl.git master
func_upd zlib https://github.com/madler/zlib.git master

