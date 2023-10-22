# Custom prompt
function prompt {
	return "$([char]27)[35m[$((Get-Date).ToString("hh:mm tt"))] $env:UserName $([char]0x2020) $([char]27)[33m$(get-location) $([char]27)[36m> $([char]27)[0m"
}
