#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
LANG=en_US.UTF-8

# aapanel Downgrade

panel_path='/www/server/panel'

if [ ! -d $panel_path ];then
echo "aaPanel şu anda kurulu değil!"
exit 0;
fi

base_dir=$(cd "$(dirname "$0")";pwd)
if [ $base_dir = $panel_path ];then
echo "Downgrade komutu panelin kök dizininde yürütülemez!"
exit 0;
fi

if [ ! -d $base_dir/class ];then
echo "Downgrade dosyası bulunamadı!"
exit 0;
fi

rm -f $panel_path/*.pyc $panel_path/class/*.pyc
\cp -r -f $base_dir/. $panel_path/
/etc/init.d/bt restart
echo "===================================="
echo "Sürüm düşürme tamamlandı!"