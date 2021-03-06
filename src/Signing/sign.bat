PATH=%PATH%;%WSDK81%\bin\x86;C:\Program Files\7-Zip;C:\Program Files (x86)\7-Zip

rem sign using SHA-1
signtool sign /v /a /n IDRIX /i Thawte /ac thawte_Primary_MS_Cross_Cert.cer /fd sha1 /t http://timestamp.verisign.com/scripts/timestamp.dll "..\Release\Setup Files\veracrypt.sys" "..\Release\Setup Files\veracrypt-x64.sys"
signtool sign /v /a /n IDRIX /i Thawte /ac Thawt_CodeSigning_CA.crt /fd sha1 /t http://timestamp.verisign.com/scripts/timestamp.dll "..\Release\Setup Files\VeraCrypt.exe" "..\Release\Setup Files\VeraCrypt Format.exe" "..\Release\Setup Files\VeraCryptExpander.exe" "..\Release\Setup Files\VeraCrypt-x64.exe" "..\Release\Setup Files\VeraCrypt Format-x64.exe" "..\Release\Setup Files\VeraCryptExpander-x64.exe"

rem sign using SHA-256
signtool sign /v /a /n "IDRIX SARL" /i GlobalSign /ac GlobalSign_Root_CA_MS_Cross_Cert.crt /as /fd sha256 /tr http://timestamp.globalsign.com/?signature=sha2 /td SHA256 "..\Release\Setup Files\veracrypt.sys" "..\Release\Setup Files\veracrypt-x64.sys"
signtool sign /v /a /n "IDRIX SARL" /i GlobalSign /ac GlobalSign_SHA256_EV_CodeSigning_CA.cer /as /fd sha256 /tr http://timestamp.globalsign.com/?signature=sha2 /td SHA256 "..\Release\Setup Files\VeraCrypt.exe" "..\Release\Setup Files\VeraCrypt Format.exe" "..\Release\Setup Files\VeraCryptExpander.exe" "..\Release\Setup Files\VeraCrypt-x64.exe" "..\Release\Setup Files\VeraCrypt Format-x64.exe" "..\Release\Setup Files\VeraCryptExpander-x64.exe"


cd "..\Release\Setup Files\"

del *.xml
copy /V /Y ..\..\..\Translations\*.xml .

rmdir /S /Q docs
mkdir docs\html\en
copy /V /Y ..\..\..\doc\html\* docs\html\en\.

del docs.zip
7z a -y docs.zip docs

"VeraCrypt Setup.exe" /p

del *.xml
del docs.zip
rmdir /S /Q docs

cd "..\..\Signing"

rem sign using SHA-1
signtool sign /v /a /n IDRIX /i Thawte /ac Thawt_CodeSigning_CA.crt /fd sha1 /t http://timestamp.verisign.com/scripts/timestamp.dll "..\Release\Setup Files\VeraCrypt Setup 1.20-BETA2.exe"
rem sign using SHA-256
signtool sign /v /a /n "IDRIX SARL" /i GlobalSign /ac GlobalSign_SHA256_EV_CodeSigning_CA.cer /as /fd sha256 /tr http://timestamp.globalsign.com/?signature=sha2 /td SHA256 "..\Release\Setup Files\VeraCrypt Setup 1.20-BETA2.exe"

pause
