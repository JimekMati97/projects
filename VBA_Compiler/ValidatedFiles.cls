VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ValidatedFiles"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private validatedFilesCollection As Collection

Private Sub Class_Initialize()
    Set validatedFilesCollection = New Collection
End Sub


Public Function getvalidatedFilesCollection()
    Set getvalidatedFilesCollection = validatedFilesCollection
End Function

