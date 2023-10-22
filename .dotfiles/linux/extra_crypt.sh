#!/bin/sh
cd "$HOME/.dotfiles/" || exit 1
if [ "$1" = "encrypt" ]; then
	tar czf extra.tar.gz extra/
	gpg -c extra.tar.gz
	rm extra.tar.gz
	exit
fi
if [ "$1" = "decrypt" ]; then
	gpg -do extra.tar.gz extra.tar.gz.gpg
	tar xvf extra.tar.gz
	rm extra.tar.gz
	exit
fi
echo "Bad usage: extra-crypt.sh encrypt|decrypt"
