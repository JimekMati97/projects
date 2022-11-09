Attribute VB_Name = "FirstRunoutModule"
Public Sub firstRunoutFormulaFilling(sh As Worksheet, r As Range)


    Dim lastRow As Long, lastColumn As Long
    lastRow = r.End(xlDown).Row
    lastColumn = r.End(xlToRight).Column


    Dim fr_r As Range
    Dim calcArea As Range
    
    
    For X = r.Offset(1, 0).Row To lastRow
        Set fr_r = r.Parent.Cells(X, r.Offset(0, 9).Column - 1)
        Set calcArea = sh.Range(sh.Cells(X, 19), sh.Cells(X, lastColumn))
        fr_r.formula = "=FirstRunout(" & calcArea.AddressLocal & ")"
    Next X
        

End Sub

Private Sub firstRunoutFormulaFillingSide()


    Dim r As Range
    Set r = Range("b4")

    Dim lastRow As Long, lastColumn As Long
    lastRow = r.End(xlDown).Row
    lastColumn = r.End(xlToRight).Column


    Dim fr_r As Range
    Dim calcArea As Range
    
    
    For X = r.Offset(1, 0).Row To lasatRow
        Set fr_r = r.Parent.Cells(X, r.Offset(0, FFOC.E_COMMON_FIRST_RUNOUT).Column - 1)
        Set calcArea = Range(Cells(X, FFOC.E_COMMON_FIRST_BALANCE + 1), Cells(X, lastColumn))
        fr_r.formula = "=FirstRunout(" & calcArea.AddressLocal & ")"
    Next X
        

End Sub




Public Function FirstRunout(area As Range) As String

    FirstRunout = "#"
    Dim r As Range
    For Each r In area
        If r.Parent.Cells(4, r.Column).value = "BALANCE" Then
            If r.value < 0 Then
                FirstRunout = CStr(r.Parent.Cells(3, r.Column - 3).value)
                Exit Function
            End If
        End If
    Next r
End Function



