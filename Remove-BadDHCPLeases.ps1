#########################################################################################################################################################
#Script Name: Remove-BadDHCPLeases                                                                                                                      # 
#Description: This script will log the current status on DHCP v4 bad leases, try to clear them twice, and then log any remaining DHCP v4 bad leases.    #
#Created by: Matthew Patrick                                                                                                                            #
#Created on: June 27th, 2017                                                                                                                            #
#########################################################################################################################################################

$ErrorActionPreference = "continue"                                                     #script will not close on error, it will display the error and continue
$datetime = get-date -format dd.MM.yyyy_HH.mm                                           #get current local date and time in 24-hour format (local time of the device it is being run on, not the destination DHCP server)
$DHCPServer = "slvddc01"                                                                #DHCP to run against
$LogPath = "\\smukfil01\shareall\"                        			        #Destination for log file

"Before clearing:" >> "$logpath\$datetime.txt"                                          
get-dhcpserverv4lease -computername $DHCPServer -badlease >> "$logpath\$datetime.txt"    #Log all badd addresses before script runs
remove-dhcpserverv4lease -computername $DHCPServer -badlease >> "$logpath\$datetime.txt" #Attempt to clear bad addresses, and log any errors
remove-dhcpserverv4lease -computername $DHCPServer -badlease >> "$logpath\$datetime.txt" #Second attempt to clear bad addresses, and log any errors
"After clearing:" >> "$logpath\$datetime.txt"
get-dhcpserverv4lease -computername $DHCPServer -badlease >> "$logpath\$datetime.txt"    #Log all bad addresses that remain after script runs