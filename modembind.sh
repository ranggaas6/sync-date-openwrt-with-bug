#!/bin/sh
# This should ping the cable modem and if it's not reachable, bounce the wan interface

dtdir="/root/date"
initd="/etc/init.d"
logp="/root/logp"
jamup2="/root/jam2_up.sh"
jamup="/root/jamup.sh"
nmfl="$(basename "$0")"
scver="3.5"

for i in https://google.com
do

function usbmodem() {
    httping -l -g $i -c 1 >/dev/null
    if [ $? -eq 0 ]
      then 
        echo "MODEM BERHASIL MELAKUKAN PING"
        exit 0
      else
        echo "MODEM TIDAK BISA MENDAPATKAN PING"
        ngefly
    fi
}

function ngefly() {
    adb shell settings put global preferred_network_mode1 11
    echo "MEMILIH 4G SIM 1"
    sleep 1
    adb shell settings put global preferred_network_mode2 11
    echo "MEMILIH 4G SIM 2"
    sleep 1
    adb shell am start -a android.settings.AIRPLANE_MODE_SETTINGS
    echo "MENGAKSES MODE PESAWAT"
    sleep 1
    adb shell cmd connectivity airplane-mode enable
    echo "MENGHIDUPKAN MODE PESAWAT"
    sleep 1
    adb shell cmd connectivity airplane-mode disable
    echo "MEMATIKAN MODE PESAWAT"
    sleep 1
    adb shell monkey -p xyz.easypro.httpcustom -c android.intent.category.LAUNCHER 1
    echo "MEMBUKA HTTP CUSTOM"
}

function ngecurl() {
	curl -si "$cv_type" | grep Date > "$dtdir"
	echo -e "${nmfl}: Executed $cv_type as time server."
	logger "${nmfl}: Executed $cv_type as time server."
}

function sandal() {
    hari=$(cat "$dtdir" | cut -b 12-13)
    bulan=$(cat "$dtdir" | cut -b 15-17)
    tahun=$(cat "$dtdir" | cut -b 19-22)
    jam=$(cat "$dtdir" | cut -b 24-25)
    menit=$(cat "$dtdir" | cut -b 26-31)

    case $bulan in
        "Jan")
           bulan="01"
            ;;
        "Feb")
            bulan="02"
            ;;
        "Mar")
            bulan="03"
            ;;
        "Apr")
            bulan="04"
            ;;
        "May")
            bulan="05"
            ;;
        "Jun")
            bulan="06"
            ;;
        "Jul")
            bulan="07"
            ;;
        "Aug")
            bulan="08"
            ;;
        "Sep")
            bulan="09"
            ;;
        "Oct")
            bulan="10"
            ;;
        "Nov")
            bulan="11"
            ;;
        "Dec")
            bulan="12"
            ;;
        *)
           return

    esac

	date -u -s "$tahun"."$bulan"."$hari"-"$jam""$menit" > /dev/null 2>&1
	echo -e "${nmfl}: Set time to [ $(date) ]"
	logger "${nmfl}: Set time to [ $(date) ]"
}

if [[ "$1" == "update" ]]; then
	echo -e "${nmfl}: Updating script..."
	echo -e "${nmfl}: Downloading script update..."
	curl -sL raw.githubusercontent.com/vitoharhari/sync-date-openwrt-with-bug/main/jam.sh > "$jamup"
	chmod +x "$jamup"
	sed -i 's/\r$//' "$jamup"
	cat << "EOF" > "$jamup2"
#!/bin/bash
# Updater script sync jam otomatis berdasarkan bug/domain/url isp
jamsh='/usr/bin/jam.sh'
jamup='/root/jamup.sh'
[[ -e "$jamup" ]] && [[ -f "$jamsh" ]] && rm -f "$jamsh" && mv "$jamup" "$jamsh"
[[ -e "$jamup" ]] && [[ ! -f "$jamsh" ]] && mv "$jamup" "$jamsh"
echo -e 'jam.sh: Update done...'
chmod +x "$jamsh"
EOF
	sed -i 's/\r$//' "$jamup2"
	chmod +x "$jamup2"
	bash "$jamup2"
	[[ -f "$jamup2" ]] && rm -f "$jamup2" && echo -e "${nmfl}: update file cleaned up!" && logger "${nmfl}: update file cleaned up!"
elif [[ "$1" =~ "http://" ]]; then
	cv_type="$1"
elif [[ "$1" =~ "https://" ]]; then
	cv_type=$(echo -e "$1" | sed 's|https|http|g')
elif [[ "$1" =~ [.] ]]; then
	cv_type=http://"$1"
else
	echo -e "Usage: add domain/bug after script!."
	echo -e "${nmfl}: Missing URL/Bug/Domain!. Read https://github.com/vitoharhari/sync-date-openwrt-with-bug/blob/main/README.md for details."
	logger "${nmfl}: Missing URL/Bug/Domain!. Read https://github.com/vitoharhari/sync-date-openwrt-with-bug/blob/main/README.md for details."
fi

if [[ ! -z "$cv_type" ]]; then
	# Script Version
	echo -e "${nmfl}: Script v${scver}"
	logger "${nmfl}: Script v${scver}"

    # Runner
	if [[ "$2" == "cron" ]]; then
		usbmodem
		ngecurl
		sandal
	else
		usbmodem
		ngecurl
		sandal
	fi

	# Cleaning files
	[[ -f "$logp" ]] && rm -f "$logp" && echo -e "${nmfl}: logp cleaned up!" && logger "${nmfl}: logp cleaned up!"
	[[ -f "$dtdir" ]] && rm -f "$dtdir" && echo -e "${nmfl}: tmp dir cleaned up!" && logger "${nmfl}: tmp dir cleaned up!"
	[[ -f "$jamup2" ]] && rm -f "$jamup2" && echo -e "${nmfl}: update file cleaned up!" && logger "${nmfl}: update file cleaned up!"
else
	echo -e "Usage: add domain/bug after script!."
	echo -e "${nmfl}: Missing URL/Bug/Domain!. Read https://github.com/vitoharhari/sync-date-openwrt-with-bug/blob/main/README.md for details."
	logger "${nmfl}: Missing URL/Bug/Domain!. Read https://github.com/vitoharhari/sync-date-openwrt-with-bug/blob/main/README.md for details."
fi

done