$hostnames = get-content c:\temp\MSB\_hostnames.txt  ## Get all pc names from text file


foreach($hostname in $hostnames) ## for each PC name do the following...
{
    $a = Test-Connection -ComputerName $hostname -Count 1 -Quiet ## Ping test, to verify it is online
    if($A -eq $false)  ## If it is not online
        {
            "$hostname">> "c:\temp\MSB\offline.txt" ##log hostname to "offline" txt file
        }
    else  ##if it is online
        {
            "$hostname">> "c:\temp\MSB\online.txt" ##log hostname to "online" txt file
            New-Item -ItemType directory C:\temp\MSB\$hostname | Out-Null ## create folder directory for this PC
            New-Item -ItemType directory C:\temp\MSB\$hostname\Before| Out-Null ## create folder directory to store the "before update" xml files
            New-Item -ItemType directory C:\temp\MSB\$hostname\After| out-Null ##create folder directory to store the "adter update" xml files

            $users = (Get-ChildItem \\$hostname\c$\users\).name ##get all user profiles on PC

            foreach($user in $users) ## for each user profile...
            {
                if(test-path "\\$hostname\c$\users\$user\appdata\roaming\Mobisys MSB Client\default.xml") ## if it has the default.xml file...
                    {
                        $xml = "" ## blank variable for reset
                        $xml = get-content "\\$hostname\c$\users\$user\appdata\roaming\Mobisys MSB Client\default.xml" ## set variable xml equal to contents of xml
                        $xml2 = $xml -replace 'prodciamp','prodciamx' ## find "prodciamp" and replace with "prodciamx"
                        $xml3 = $xml2 -replace 'prodcipxp','prodciamx' ## find "prodcipxp" and replace with "prodciamx"
                        $xml4 = $xml3 -replace '172.22.70.63','prodciamx.atrsap.com' ## find "172.22.70.63" and replace with "prodciamx.atrsap.com"
                        $xml5 = $xml4 -replace '172.22.70.82','prodciamx.atrsap.com' ## find "172.22.70.82" and replace with "prodciamx.atrsap.com"
                        $xml6 = $xml5 -replace '8107','8007' ## find the port "8107" and replace with "8007"

                        $xml | out-file "c:\temp\MSB\$hostname\before\$user.xml" -Encoding utf8 ## store the "before update" xml file
                        $xml6 | out-file "c:\temp\MSB\$hostname\after\$user.xml" -Encoding utf8 ## store the "After update" xml file
                        $xml6 | out-file "\\$hostname\c$\users\$user\appdata\roaming\Mobisys MSB Client\default.xml" -Encoding utf8 ##replace the default.xml file on client PC with new version, Mobisys will need to be restarted to take affect
                    }

            }
        }
}