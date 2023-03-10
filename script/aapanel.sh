#! /bin/bash
# By Ezel
# https://github.com/ByEzel93/aaPanel

# Colors
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
purple(){
    echo -e "\033[35m\033[01m$1\033[0m"
}

# aapanel Install
function aapanel-install(){
wget -O "/root/aapanel-install.sh" "http://www.aapanel.com/script/install_6.0_en.sh"
red "aaPanel'i kurun - Orjinal (Eğer kurulu değilse)."
bash "/root/aapanel-install.sh"
}



# aapanel Downgrade
function downgrade-aapanel(){
wget -O "/root/aaPanel_EN-6.8.23.zip" "https://ghproxy.com/https://github.com/ByEzel93/aaPanel/releases/download/6.8.23/aaPanel_EN-6.8.23.zip"
red "İndirme tamamlandı, sürüm düşürülüyor."
unzip aaPanel_EN-6.8.23.zip
cd /root/panel
wget -O "/root/panel/downgrade.sh" "https://ghproxy.com/https://raw.githubusercontent.com/ByEzel93/aapanel/main/script/downgrade.sh" 
bash "/root/panel/downgrade.sh"
red "Sürüm başarıyla düşürülmüştür."
rm /root/aaPanell_EN-6.8.23.zip /root/panel/ -rf
}



# Crack
function panel-happy() {
  echo "Öncelikle yazılım mağazasını manuel olarak açınız."
  if [ -f "/www/server/panel/data/plugin.json" ]; then
    sed -i 's|"endtime": -1|"endtime": 999999999999|g' /www/server/panel/data/plugin.json
    sed -i 's|"pro": -1|"pro": 0|g' /www/server/panel/data/plugin.json
    chattr +i /www/server/panel/data/plugin.json
    chattr -i /www/server/panel/data/repair.json
    if [ -f "/www/server/panel/data/repair.json" ]; then
      rm /www/server/panel/data/repair.json
    fi
    cd /www/server/panel/data || exit
    wget https://ghproxy.com/https://raw.githubusercontent.com/ByEzel93/aaPanel/main/resource/repair.json
    if [ -f "repair.json" ]; then
      chattr +i repair.json
      echo -e "\033[31mBaşarıyla crack yapıldı.\033[0m"
    else
      echo -e "\033[31mDosya indirme işlemi başarısız.\033[0m"
    fi
  else
    echo -e "\033[31mplugin.json dosyası bulunamadı.\033[0m"
  fi
}


# Clean Trash
function clean-up-trash(){
    if [ -f "aaPanel_EN-6.8.23.zip" ] && [ -f "aapanel-install.sh" ]; then
        rm aaPanel_EN-6.8.23.zip aapanel-install.sh -rf
        echo "Başarıyla temizlendi."
        echo "Bu betiği kaldırmak isterseniz, şu komutu çalıştırın: rm aapanel.sh -rf"
    else
        echo "Belirtilen dosyalar bulunamadı. Lütfen dosya adının doğruluğunu kontrol edin."
    fi
}


# Uninstaller
function uninstall(){
wget -O "/root/bt-uninstall.sh" "http://download.bt.cn/install/bt-uninstall.sh"
bash "/root/bt-uninstall.sh"
red "Panel başarıyla kaldırıldı."
}

# Günlük dosyasını silin ve yazmayı önlemek için dosyayı kilitleyin
function log(){
echo "" > /www/server/panel/script/site_task.py
chattr +i /www/server/panel/script/site_task.py
rm -rf /www/server/panel/logs/request/*
chattr +i -R /www/server/panel/logs/request
}

# Change Language
function language-turkish(){
wget -q --spider https://ghproxy.com/https://github.com/ByEzel93/aaPanel/releases/download/1.0/aapanel_turkish-6.8.21.zip
if [ $? -eq 0 ]; then
  wget -O /root/turkish.zip https://ghproxy.com/https://github.com/ByEzel93/aaPanel/releases/download/1.0/aapanel_turkish-6.8.21.zip
  unzip -o /root/turkish.zip -d /www/server/
  rm /root/turkish.zip -rf
  /etc/init.d/bt restart
  echo "Dil dosyası başarıyla değiştirildi."
else
  echo "Dosya bulunamadı, lütfen geçerli bir URL girin."
fi
}

# Menu
function start_menu(){
    clear
    purple "aaPanel aracını kullandığınız için teşekkür ederiz.."
    purple " https://github.com/ByEzel93/aaPanel"
    yellow " ————————————————————————————————————————————————"
    green " 1. CentOS/Debian/Ubuntu üzerinde aaPanel'i kur"
    yellow " ————————————————————————————————————————————————"
    green " 2. aaPanel sürümü 6.8.23'e düşür"
    green " 3. aaPanel'i Crackle"
    green " 4. aaPanel dilini Türkçe olarak değiştir"
    green " 5. Günlük dosyaları sil, dosya yazma izinlerini kilitle"
    yellow " ————————————————————————————————————————————————"
    green " 6. aaPanel'i kaldır"
    green " 7. Gereksiz dosyaları temizle"
    green " 0. Çıkış"

    echo
    read -p "Lütfen yapmak istediğiniz işlem rakamını giriniz:" menuNumberInput
    case "$menuNumberInput" in
        1) aapanel-install ;;
        2) downgrade-aapanel ;;
        3) panel-happy ;;
        4) language-turkish ;;
        5) log ;;
        6) uninstall ;;
        7) clean-up-trash ;;
        0) exit 1 ;;
        *)
            clear
            red "Lütfen geçerli bir rakam girin!"
            start_menu
        ;;
    esac

}
start_menu "first"
