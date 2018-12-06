$computer = get-content c:\temp\pcs.txt

$computer | foreach-object{



copy-item -path "c:\temp\Ethics Point Hotline.url" -destination "\\$_\c$\users\public\desktop\Ethics Point Hotline.url" -force







}