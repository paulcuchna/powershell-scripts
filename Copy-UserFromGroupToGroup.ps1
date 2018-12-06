$source_group = "ACCT"
$Destination_Group = "SEC-GG-NAM-MUK-ACCTGRP-RW"


$Target = Get-ADGroupMember -Identity $Source_Group 
foreach ($Person in $Target) { 
    Add-ADGroupMember -Identity $Destination_Group -Members $Person.distinguishedname 
}