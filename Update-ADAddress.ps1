get-content c:\temp\CLusers.txt | foreach-object{

set-aduser -identity $_ -office 'Aptar Crystal Lake - 265' -Replace @{StreetAddress = '265 Exchange Dr, Suite 100';l = 'Crystal Lake';st ='IL';PostalCode = '60014';office = 'Aptar Crystal Lake - 265'}
write "$_ is complete."

}