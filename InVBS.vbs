Option Explicit

Dim strComputer, objWMIService, colOperatingSystems, objOperatingSystem
Dim strInputFile, objFSO, objInputFile, strLine

' Specify the input file name
strInputFile = "computer_list.txt"

' Open the input file for reading
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objInputFile = objFSO.OpenTextFile(strInputFile, 1)

' Loop through each line of the input file
Do While Not objInputFile.AtEndOfStream
    ' Read the next line
    strLine = objInputFile.ReadLine()
    
    ' Trim whitespace from the line
    strLine = Trim(strLine)
    
    ' Check if the line is empty or a comment
    If strLine <> "" And Left(strLine, 1) <> "#" Then
        ' Set the computer name
        strComputer = strLine
        
        ' Connect to the WMI service on the remote computer
        Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
        
        ' Get the operating system object
        Set colOperatingSystems = objWMIService.ExecQuery("Select * from Win32_OperatingSystem")
        
        ' Log off the current user
        For Each objOperatingSystem in colOperatingSystems
            objOperatingSystem.Win32Shutdown(4)
        Next
        
        ' Restart the computer
        Set colOperatingSystems = objWMIService.ExecQuery("Select * from Win32_OperatingSystem")
        For Each objOperatingSystem in colOperatingSystems
            objOperatingSystem.Reboot()
        Next
    End If
Loop

' Close the input file
objInputFile.Close
