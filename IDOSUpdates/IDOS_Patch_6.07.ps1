######Get Computer Hostnames#######


$computers = get-content c:\temp\morecomputers.txt
Foreach($computer in $computers){

######Test if you can ping, write computer name in red if you can't#######


$a = Test-Connection -ComputerName $computer -Count 1 -Quiet
if($A -eq $false)
{
 Write-Host -foregroundcolor red "$Computer" 
 }
 else
 {

######Optionally kill QM3 Processes#######


##(Get-WmiObject Win32_Process -ComputerName $computer | ?{ $_.ProcessName -match "qm3" }).Terminate() |Out-Null
##(Get-WmiObject Win32_Process -ComputerName $computer | ?{ $_.ProcessName -match "qm3profiler" }).Terminate()|Out-Null


######Rename then COpy new file, Write computer name in green#######


Copy-Item -Path "\\$computer\c$\ORACLE\product\11.2.0\client_1\network\admin\tnsnames.ora" -Destination "\\$computer\c$\ORACLE\product\11.2.0\client_1\network\admin\tnsnames_20160607.ora" -Force
Copy-Item -Path "c:\temp\tnsnames.ora" -Destination "\\$computer\c$\ORACLE\product\11.2.0\client_1\network\admin\tnsnames.ora" -Force

copy-item -path "\\$computer\c$\aptar\idos\bin\sql.ini" -destination "\\$computer\c$\aptar\IDOS\BIN\sql_20160607.ini" -Force
Copy-Item -path "c:\temp\sql.ini" -destination "\\$computer\c$\aptar\IDOS\BIN\sql.ini" -Force

copy-item -path "\\$computer\c$\aptar\idos\common\profile.cfg" -destination "\\$computer\c$\aptar\IDOS\common\profile_20160607.cfg" -Force
Copy-Item -path "c:\temp\profile.cfg" -destination "\\$computer\c$\aptar\IDOS\common\profile.cfg" -Force

write-host -foregroundcolor green "$computer"

}

}