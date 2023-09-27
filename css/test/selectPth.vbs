Dim strLine()

getPath

Function getPath()
    Set wShell=CreateObject("WScript.Shell")
    Set oExec=wShell.Exec("mshta.exe ""about:<input type=file id=FILE><script>FILE.click();new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);close();resizeTo(0,0);</script>""")
    sFileSelected = oExec.StdOut.ReadLine
    if sFileSelected <> "" then
        ' msgbox sFileSelected
        readData(sFileSelected)
        writeData()
    else
        msgbox false
    end if
End Function

Sub writeData()
    'Set objFileToWrite = CreateObject("Scripting.FileSystemObject").OpenTextFile(tmp,2,true)
    Dim fso, objFileToWrite,folderPath, recordLine
    Dim seperateHeader, errorCode, errorName, errorType, errorCondition

    Set fso = CreateObject("Scripting.FileSystemObject")
    folderPath = fso.GetParentFolderName(WScript.ScriptFullName)
    Set seperateHeader = Nothing
    Set objFileToWrite = fso.CreateTextFile(folderPath + "/ErrorCode.txt", True)

    'objFileToWrite.WriteLine("Errorcode,Name,Type,Condition")

    for i = LBound(strLine) to UBound(strLine)

        recordLine = strLine(i)

        if Mid(recordLine, 7, 1) = "|" then

            seperateHeader = Split(recordLine, "|")

            if InStr(seperateHeader(0), "S") <> 0 or InStr(seperateHeader(0), "U") <> 0 then

                errorCode = seperateHeader(0)
                errorName = seperateHeader(1)
                errorType = ""
                errorCondition = ""

                objFileToWrite.Write(errorCode + "," + errorName + "," + errorType + "," + errorCondition)
                'objFileToWrite.WriteLine()
            
            elseif InStr(seperateHeader(0), "-") <> 0 then

                errorName = ""
                errorType = seperateHeader(0)
                errorCondition = seperateHeader(1)

                objFileToWrite.Write(errorCode + "," + errorName + "," + errorType + "," + errorCondition)

            else
                if errorType <> "" then

                    errorName = ""
                    errorCondition = seperateHeader(1)
                
                    objFileToWrite.Write(errorCode + "," + errorName + "," + errorType + "," + errorCondition)

                else 
                    
                    errorName = seperateHeader(1)

                    objFileToWrite.Write(errorCode + "," + errorName + "," + errorType + "," + errorCondition)
                end if

            end if

        end if
        
        if vartype(seperateHeader) = 8204 then

            objFileToWrite.WriteLine()

        end if

        Set seperateHeader = Nothing

    next 

    objFileToWrite.Close

    Set objFileToWrite = Nothing
End Sub

Sub readData(tmp)

    Set objFileToRead = CreateObject("Scripting.FileSystemObject").OpenTextFile(tmp,1, true, 0)
    i = 0
    do while NOT objFileToRead.AtEndOfStream

        'strLine = strLine + objFileToRead.ReadLine + chr(13) + chr(10)
        ReDim Preserve strLine(i)
        strLine(i) = objFileToRead.ReadLine
        i = i + 1

    loop
    
End Sub
