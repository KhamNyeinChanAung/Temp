Dim IE
Dim MyDocument
Set IE = CreateObject("InternetExplorer.Application")
IE.Visible = 0
IE.navigate CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) &"/test/home.html"