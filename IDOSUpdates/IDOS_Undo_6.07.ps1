######Get Computer Hostnames#######


$computers = get-content c:\temp\idoscomputers.txt

Foreach($computer in $computers){

######Test if you can ping, write computer name in red if you can't#######


$a = Test-Connection -ComputerName $computer -Count 1 -Quiet

if($A -eq $false)
{
 write-host -foregroundcolor red "$Computer."
 }
 else
 {
######Optionally kill QM3 Processes#######


##(Get-WmiObject Win32_Process -ComputerName $computer | ?{ $_.ProcessName -match "qm3" }).Terminate() |Out-Null
##(Get-WmiObject Win32_Process -ComputerName $computer | ?{ $_.ProcessName -match "qm3profiler" }).Terminate()|Out-Null

######Rename then COpy new file, Write computer name in green#######

remove-Item -Path "\\$computer\c$\ORACLE\product\11.2.0\client_1\network\admin\tnsnames.ora" -Force
Rename-Item -Path "\\$computer\c$\ORACLE\product\11.2.0\client_1\network\admin\tnsnames_20160607.ora" -NewName "tnsnames.ora" -Force

remove-Item -path "\\$computer\c$\aptar\IDOS\BIN\sql.ini" -Force
rename-item -path "\\$computer\c$\aptar\idos\bin\sql_20160607.ini" -newname "sql.ini" -Force

remove-Item -path "\\$computer\c$\aptar\IDOS\common\profile.cfg" -Force
rename-item -path "\\$computer\c$\aptar\idos\common\profile_20160607.cfg" -newname "profile.cfg" -Force


write-host -foregroundcolor green "$computer"

}

}