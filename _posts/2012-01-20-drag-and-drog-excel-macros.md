---
title: "Run an Excel macro on any file using drag and drop"
tags: ["howto"]
old-link: https://fulldecent.blogspot.com/2012/01/run-excel-macro-on-any-file-using-drag.html
---

Create an Excel macro, put that macro in a .BAS file and then use this script to apply that macro to any Excel file.

![RunMacro.png](/assets/images/2012-01-20-drag-and-drog-excel-macros.webp)

Here is the VBS file, written in WSCRIPT:

```vbscript
if WScript.Arguments.Count < 1 Then
    WScript.Echo "Drop file on to me to process."
    WScript.Quit
End If
MyPath = Left(Wscript.ScriptFullName, Len(Wscript.ScriptFullName) - Len(Wscript.ScriptName))
Set oExcel = CreateObject("Excel.Application")
Set oBook = oExcel.Workbooks.Open(Wscript.Arguments.Item(0))
Set oVBC = oBook.VBProject.VBComponents
oVBC.Import(MyPath & "\My Macro.bas")
oBook.Application.Run "Macro1"
WScript.Echo "Done"
```

To make this work, you need to configure Excel properly:

1. Excel -> Options -> Trust Center -> Trust Center options -> Macro Settings
2. TURN ON Trust access to the VBA project object model
