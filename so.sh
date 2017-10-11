#!/bin/bash
USER="USER"
PW="password"
DWfolder="$HOME/Downloads/so"
mkdir $DWfolder

cd $DWfolder

    echo -e "\033[42mCookie Authenticating....\033[0m"
	cookie=$(wget --quiet -O- "http://api.share-online.biz/cgi-bin?q=userdetails&username=$USER&password=$PW" | grep 'a=');
	echo -e "\033 Urls in urls.txt\033[0m"
	cat urls.txt 
	echo
	echo -e "\033[41mUrls Reload? j / n \033[0m"
	read -s urlload

if [ "$urlload" = "j" ]
  then
	  #pbpast MacOSX only
	  pbpaste > urls.txt 
fi

for url in $(cat urls.txt)
	do
		echo -e "\033[42mGeneriere SHARE Link\033[0m"
		url=$(wget --quiet -O- "http://api.share-online.biz/cgi-bin?q=linkdata&username=$USER&password=$PW&lid=$(basename "$url")" | grep 'URL' | cut -f 2 -d ' ');
		echo -e "\033[42mDownload URL \033[0m"$url
		wget -c  --content-disposition --header "Cookie: $cookie" $url
	done
