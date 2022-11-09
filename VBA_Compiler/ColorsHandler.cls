VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ColorsHandler"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

Public colorPurpleMain As Long
Public colorPurpleMore As Long
Public colorPurpleDark As Long
Public colorPurpleLight As Long

Public colorMattBlueMain As Long
Public colorMattBlueMore As Long
Public colorMattBlueDark As Long
Public colorMattBlueLight As Long

Public colorMattBlack As Long

Public colorFireFlakeGrey As Long



Private Sub Class_Initialize()

    Me.colorMattBlack = RGB(20, 20, 20)
    
    Me.colorMattBlueDark = RGB(6, 12, 27)
    Me.colorMattBlueLight = RGB(128, 153, 216)
    Me.colorMattBlueMain = RGB(46, 65, 114)
    Me.colorMattBlueMore = RGB(79, 102, 158)
    
    Me.colorPurpleDark = RGB(11, 6, 27)
    Me.colorPurpleLight = RGB(152, 129, 218)
    Me.colorPurpleMain = RGB(65, 48, 117)
    Me.colorPurpleMore = RGB(89, 42, 113)
    
    Me.colorFireFlakeGrey = RGB(200, 200, 200)
    
End Sub


