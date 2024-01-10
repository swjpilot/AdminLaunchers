
Function ReadIni( myFilePath, mySection, myKey )
    Const ForReading   = 1
    Const ForWriting   = 2
    Const ForAppending = 8
    Dim intEqualPos
    Dim objFSO, objIniFile
    Dim strFilePath, strKey, strLeftString, strLine, strSection
    Set objFSO = CreateObject( "Scripting.FileSystemObject" )
    ReadIni     = ""
    strFilePath = Trim( myFilePath )
    strSection  = Trim( mySection )
    strKey      = Trim( myKey )
    If objFSO.FileExists( strFilePath ) Then
        Set objIniFile = objFSO.OpenTextFile( strFilePath, ForReading, False )
        Do While objIniFile.AtEndOfStream = False
            strLine = Trim( objIniFile.ReadLine )

            ' Check if section is found in the current line
            If LCase( strLine ) = "[" & LCase( strSection ) & "]" Then
                strLine = Trim( objIniFile.ReadLine )

                ' Parse lines until the next section is reached
                Do While Left( strLine, 1 ) <> "["
                    ' Find position of equal sign in the line
                    intEqualPos = InStr( 1, strLine, "=", 1 )
                    If intEqualPos > 0 Then
                        strLeftString = Trim( Left( strLine, intEqualPos - 1 ) )
                        ' Check if item is found in the current line
                        If LCase( strLeftString ) = LCase( strKey ) Then
                            ReadIni = Trim( Mid( strLine, intEqualPos + 1 ) )
                            ' In case the item exists but value is blank
                            If ReadIni = "" Then
                                ReadIni = " "
                            End If
                            ' Abort loop when item is found
                            Exit Do
                        End If
                    End If

                    ' Abort if the end of the INI file is reached
                    If objIniFile.AtEndOfStream Then Exit Do

                    ' Continue with next line
                    strLine = Trim( objIniFile.ReadLine )
                Loop
            Exit Do
            End If
        Loop
        objIniFile.Close
    Else
        WScript.Echo strFilePath & " doesn't exists. Exiting..."
        Wscript.Quit 1
    End If
End Function


scriptDir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
config = scriptdir & "\LauncherConfig.ini"
adminUser = ReadIni(config, "Admin", "AdminUser")
adminUser = Replace(adminUser, vbLf, "")
adminPass = ReadIni(config, "Admin", "AdminPass")
adminPass = Replace(adminPass, vbLf, "")
command = "C:\Windows\System32\runas.exe /netonly /user:" & adminUser & " ""c:\windows\system32\mmc.exe c:\windows\system32\dsa.msc""" 
Set oShell = CreateObject("WScript.Shell")
oShell.Run "cmd.exe"
oShell.AppActivate "cmd"
WScript.Sleep 2
oShell.SendKeys command
oShell.SendKeys "{ENTER}"
WScript.Sleep 2
oShell.SendKeys adminPass
oShell.SendKeys "{ENTER}"
