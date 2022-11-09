VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "DynamicColors"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private strStock As String
Private strBalance As String
Private strRqm As String
Private r As Range
Private firstBalance As Range
Private balanceColumnsCollection As Collection
Private sh As Worksheet


Private Sub Class_Initialize()

    ' prepare elements to colour
    strStock = "Stock"
    strBalance = "BALANCE"
    strRqm = "RQM"
    
    Set r = Range("B4")
    Set sh = r.Parent
    
    Set balanceColumnsCollection = fillBalanceColumnsCollection()
    
    If Not balanceColumnsCollection Is Nothing Then
    
        For Each colNum In balanceColumnsCollection
        
            rowNr = r.Offset(1, 0).Row
            
            Do
        
                If sh.Cells(rowNr, colNum).value < 0 Then
                    sh.Cells(rowNr, colNum).Interior.Color = RGB(255, 0, 0)
                    sh.Cells(rowNr, colNum).Font.Color = RGB(0, 0, 0)
                ElseIf sh.Cells(rowNr, colNum + 4).value < 0 Or sh.Cells(rowNr, colNum).value = 0 Then
                    sh.Cells(rowNr, colNum).Interior.Color = RGB(255, 199, 206)
                    sh.Cells(rowNr, colNum).Font.Color = RGB(0, 0, 0)
                ElseIf CLng(sh.Cells(rowNr, colNum).value) - CLng(sh.Cells(rowNr, colNum + 1).value) < 0 Then
                    sh.Cells(rowNr, colNum).Interior.Color = RGB(255, 199, 206)
                    sh.Cells(rowNr, colNum).Font.Color = RGB(0, 0, 0)
                Else
                    sh.Cells(rowNr, colNum).Interior.Color = sh.Cells(r.Row, colNum).Interior.Color
                    sh.Cells(rowNr, colNum).Font.Color = RGB(0, 0, 0)
                End If
                
                rowNr = rowNr + 1
            
            Loop Until Trim(sh.Cells(rowNr, colNum).value) = ""
            
            
        Next colNum
    End If
    

End Sub

Private Function fillBalanceColumnsCollection() As Collection
    
    Dim col As Collection
    Set col = New Collection
    
    Dim rng As Range
    Set rng = r
    Do
        If rng.value = strBalance Then
            col.Add rng.Column
        End If
        Set rng = rng.Offset(0, 1)
    Loop Until Trim(rng.value) = ""
    
    If col.Count > 0 Then
        Set fillBalanceColumnsCollection = col
End Function
    








