VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "StatusHandler"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public szerokosc_paska As Double
' bardzo wazne zeby nie przekroczyc zakresu mozliwosci tych dwoch zmiennych
Public act As Double

' ile jest czesci w sumie do sprawdzenia
Public max As Double
Public dx As Double
Public jeden_procent As Double
' 360/255 <-  pod gradientowa zmiane koloru
Public grad_color As Double
Private increment_decrement_flag As Boolean

Private est_time As Double
Private avr_on_one_pn As Double
Private macro_starts As Double
Private time_flag As Double

Private basicRunningTime As Double
Private LabelEstimatedTime As Integer

Private collection_of_avr_on_pn As Collection

Public Sub init_statusbar(m_max, Optional m_min)
    
    basicRunningTime = 2.9
    
    Dim INITIAL_TIMING_FOR_ONE_PN As Double
    INITIAL_TIMING_FOR_ONE_PN = 0.19

    Set collection_of_avr_on_pn = New Collection

    max = m_max
    If Not IsMissing(m_min) Then
        act = m_min
    End If
    
    dx = CDbl(szerokosc_paska) / 5
    
    macro_starts = CDbl(Now)
    avr_on_one_pn = CDbl(INITIAL_TIMING_FOR_ONE_PN)
    
    For X = 1 To max
        collection_of_avr_on_pn.Add CDbl(INITIAL_TIMING_FOR_ONE_PN)
    Next X
    
    time_flag = macro_starts
    est_time = CDbl(max) * CDbl(avr_on_one_pn)
    
    
    est_time = 0
    For Each mitem In collection_of_avr_on_pn
        est_time = est_time + CDbl(mitem)
    Next mitem
    
    est_time = est_time + basicRunningTime
    LabelEstimatedTime = est_time
    
    StatusForm.LabelAverageTime.caption = CStr(CLng(avr_on_one_pn)) & " s"
    StatusForm.LabelEstimatedTime.caption = CStr(convert_and_show(CLng(est_time)))
    
End Sub

Public Sub progress_increase()
    If act < max Then
        act = act + 1

        
        StatusForm.PasekPostepu.width = StatusForm.PasekPostepu.width + dx
        If StatusForm.PasekPostepu.width >= 360 Then
            StatusForm.PasekPostepu.width = 360
        End If
        DoEvents
        Dim score As Integer
        
        Dim posOfSpace As Integer
        posOfSpace = InStr(StatusForm.FrameProgress.caption, " ")
        
        score = CInt(left(StatusForm.FrameProgress.caption, posOfSpace))

        StatusForm.FrameProgress.caption = CStr(score + 20) & " %"
        
        

        
        LabelEstimatedTime = LabelEstimatedTime - 0.2 * (LabelEstimatedTime)
        StatusForm.LabelEstimatedTime.caption = CStr(convert_and_show(CLng(LabelEstimatedTime)))
        
        
        StatusForm.Repaint
    End If
End Sub

Public Function convert_and_show(et As Long) As String
    convert_and_show = " 00h:00m:00s"
    
    
    godziny = Int(et / 3600)
    minuty = Int(et / 60)
    pozostalosc_po_minutach = Int(et Mod 60)
    
    convert_and_show = CStr(godziny) & "h:" & CStr(minuty) & "m:" & str(pozostalosc_po_minutach) & "s"
    
End Function

Public Sub show()
    StatusForm.PasekPostepu.BackColor = RGB(254, 190, 16)
    StatusForm.TloPaskaPostepu.BackColor = RGB(0, 0, 0)
    StatusForm.BtnPrzerwij.BackColor = RGB(0, 0, 0)
    StatusForm.BtnPrzerwij.ForeColor = RGB(254, 190, 16)
    
    StatusForm.show vbModeless
End Sub

Public Sub hide()
    StatusForm.hide
End Sub



Private Sub Class_Initialize()


    StatusForm.LabelEstimatedTime.caption = 0
    StatusForm.LabelAverageTime.caption = 0


    szerokosc_paska = 360
    grad_color = 155 ' od 155 do 255 kolor 100 razy zmieniany
    jeden_procent = CDbl(szerokosc_paska) / CDbl(100)
    act = 0
    StatusForm.PasekPostepu.width = 0
    StatusForm.PasekPostepu.BackColor = RGB(255, 0, 0)
    If max <> 0 Then
        StatusForm.FrameProgress.caption = CStr(Int((CDbl(act) / CDbl(max)) * 100)) & " %"
    Else
        StatusForm.FrameProgress.caption = "0 %"
    End If
    
    
    
End Sub

Private Sub Class_Terminate()
    Set collection_of_avr_on_pn = Nothing
End Sub
