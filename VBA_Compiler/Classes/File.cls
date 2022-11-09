VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "File"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private fileName As String
Private plantCode As String
Private isSetSheet As Boolean
Private filePath As String
Private typeOfFile As String
Private plantName As String
Private selectedSheet As String
Private sheetNamesCollection As Collection
Private sheetCollection As Collection

Private Sub Class_Initialize()
    Set sheetCollection = New Collection
    Set sheetNamesCollection = New Collection
    plantCode = ""
    selectedSheet = False
End Sub

Public Function getFileName()
    getFileName = fileName
End Function

Public Function setFileName(value As String)
    fileName = value
End Function

Public Function getPlantCode()
    getPlantCode = plantCode
End Function

Public Function setPlantCode(value As String)
    plantCode = value
End Function

Public Function getisSetSheet()
    getisSetSheet = isSetSheet
End Function

Public Function setisSetSheet(value As Boolean)
    isSetSheet = value
End Function

Public Function getsheetCollection()
    Set getsheetCollection = sheetCollection
End Function

Public Function getsheetNamesCollection()
    Set getsheetNamesCollection = sheetNamesCollection
End Function

Public Function getfilePath()
    getfilePath = filePath
End Function

Public Function setfilePath(value As String)
    filePath = value
End Function
Public Function getplantName()
    getplantName = plantName
End Function

Public Function setplantName(value As String)
    plantName = value
End Function
Public Function getselectedSheet()
    getselectedSheet = selectedSheet
End Function

Public Function setselectedSheet(value As String)
    selectedSheet = value
End Function
'
Public Function settypeOfFile(value As String)
    typeOfFile = value
End Function
Public Function gettypeOfFile()
    gettypeOfFile = typeOfFile
End Function
