VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Adapter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public copiedShName As String
Public partNumber As String
Public plantCode As String
Public plantName As String
Public partName As String
Public supplierName As String
Public backlog As String
Public stock As String
Public InitialStock As String
Public typeOfFile As String

'atrs for ff
Public resp As String
Public comment1 As String
Public comment2 As String
Public bip As String
Public hazards As String
Public recev As String

Public scmData As Collection
Private dayObj As Day


Private Sub Class_Initialize()
    Set scmData = New Collection
End Sub
Public Function createDayObj()
    Set createDayObj = New Day
End Function

Private Sub Class_Terminate()
    Set scmData = Nothing
End Sub


