cd "~/windotfiles/.dotfiles/"
if ($args[0] -eq "encrypt") {
	tar czf .\..\extra.tar.gz .\..\extra
	gpg -c .\..\extra.tar.gz
	rm .\..\extra.tar.gz
	return
}
if ($args[0] -eq "decrypt") {
	gpg -do .\..\extra.tar.gz .\..\extra.tar.gz.gpg
	tar xvf .\..\extra.tar.gz
	rm .\..\extra.tar.gz
	return
}
Write-Output "Bad usage: extra-crypt.ps1 encrypt|decrypt"
