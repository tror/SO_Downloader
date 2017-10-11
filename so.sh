#!/bin/bash
SOID="USER"
SOPW="PASSWORT"

DWfolder="$HOME/Downloads/so"
mkdir $DWfolder

cd $DWfolder

    echo -e "\033[42mCookie Authenticating....\033[0m"
	socookie=$(wget --quiet -O- "http://api.share-online.biz/cgi-bin?q=userdetails&username=$SOID&password=$SOPW" | grep 'a=');	
	echo -e "\033 Urls in urls.txt\033[0m"
	cat urls.txt 
	echo
	echo -e "\033[41mUrls Reload? j / n \033[0m"
	read -s urlreload

if [ "urlreload" = "j" ]
  then
	  #pbpast MacOSX only
	  
	  __IS_MAC=${__IS_MAC:-$(test $(uname -s) == "Darwin" && echo 'true')}
	  if [ -n "${__IS_MAC}" ]; then
	    pbpaste > urls.txt #For MAC OSX
	  else
	    xclip -selection clipboard -o > urls.txt  #For linux
	  fi
	  	  
fi

for url in $(cat urls.txt)
	do
		echo -e "\033[42mGeneriere SHARE Link\033[0m"
		url=$(wget --quiet -O- "http://api.share-online.biz/cgi-bin?q=linkdata&username=$SOID&password=$SOPW&lid=$(basename "$url")" | grep 'URL' | cut -f 2 -d ' ');
		echo -e "\033[42mDownload URL \033[0m"$url
		wget -c  --content-disposition --header "Cookie: $socookie" $url
	done