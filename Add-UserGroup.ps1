get-content c:\temp\users.txt | foreach-object{
Add-ADGroupMember -Identity <groupname> -Members (get-aduser $_).distinguishedname
write $_
}