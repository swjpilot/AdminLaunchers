Dim strArgs, strCmd, strEngine, i, objDebug, wshShell

Set wshShell = CreateObject( "WScript.Shell" )

strEngine = UCase( Right( WScript.FullName, 12 ) )

If strEngine <> "\CSCRIPT.EXE" Then
	' Recreate the list of command line arguments
	strArgs = ""
	If WScript.Arguments.Count > 0 Then
		For i = 0 To WScript.Arguments.Count - 1
			strArgs = strArgs & " " & WScript.Arguments(i)
		Next
	End If

	' Create the complete command line to rerun this script in CSCRIPT
	strCmd = "CSCRIPT.EXE //NoLogo """ & WScript.ScriptFullName & """" & strArgs

	' Rerun the script in CSCRIPT
	Set objDebug = wshShell.Exec( strCmd )

	' Wait until the script exits
	Do While objDebug.Status = 0
		WScript.Sleep 100
	Loop

	' Exit with CSCRIPT's return code
	WScript.Quit objDebug.ExitCode
End If

Set oWS = WScript.CreateObject("WScript.Shell")
sLinkFile = "C:\MyShortcut.LNK"
Set oLink = oWS.CreateShortcut(sLinkFile)
    oLink.TargetPath = "C:\Program Files\MyApp\MyProgram.EXE"
 '  oLink.Arguments = ""
 '  oLink.Description = "MyProgram"   
 '  oLink.HotKey = "ALT+CTRL+F"
 '  oLink.IconLocation = "C:\Program Files\MyApp\MyProgram.EXE, 2"
 '  oLink.WindowStyle = "1"   
 '  oLink.WorkingDirectory = "C:\Program Files\MyApp"
oLink.Save