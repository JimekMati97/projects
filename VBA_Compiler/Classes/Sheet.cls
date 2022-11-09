VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Sheet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private sheetName As String
Private typeOfSheet As String
Private selectedSheet As Boolean

Private Sub Class_Initialize()
    selectedSheet = False
End Sub
Public Function getSheetName()
    getSheetName = sheetName
End Function

Public Function setSheetName(value As String)
    sheetName = value
End Function

Public Function getselectedSheet()
    getselectedSheet = selectedSheet
End Function

Public Function setselectedSheet(value As Boolean)
    selectedSheet = value
End Function

Public Function getSheetType()
    getSheetType = typeOfSheet
End Function

Public Function setSheetType(value As String)
    typeOfSheet = value
End Function


