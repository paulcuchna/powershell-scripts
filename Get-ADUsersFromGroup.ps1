$a = Get-ADGroupMember "SEC-GG-GDC-PTC-PDMLink Production Users" 
$d += "firstname, lastname, OU
"
$a | foreach-object{

$b = $_.name
$c = get-aduser $b -properties * | select givenname, surname, DistinguishedName 

$gn = $c.givenname
$sn = $c.surname
$dn = $c.DistinguishedName


$d += "$gn, $sn, $dn
"
}

$d | Out-File C:\temp\PDMLink.txt