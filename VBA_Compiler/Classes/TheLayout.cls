VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "TheLayout"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private colors As ColorsHandler

Private Sub Class_Initialize()
    Set colors = New ColorsHandler
End Sub

Public Sub init(ByRef sh As Worksheet)
    
    ActiveWindow.Zoom = 80
    ActiveWindow.DisplayGridlines = False
End Sub


Public Sub addDayNamesAndMergeTopDateRows(r As Range)
    
    mergeProperly r
End Sub



Private Sub mergeProperly(ByRef r As Range)

    Dim sh  As Worksheet
    Set sh = r.Parent
    Dim tmp As Range, tmp1 As Range, tmp2 As Range
    
    Dim toggle As Boolean
    toggle = False
    
    Do
        Set tmp = r
        Set tmp1 = tmp
        Set tmp2 = r.Offset(0, 2)
        
        Set r = r.Offset(0, 3)
        
        tmp1.HorizontalAlignment = xlCenter
        tmp1.Offset(-1, 1).HorizontalAlignment = xlLeft
        
        
        sh.Range(tmp1.Offset(-1, 1), tmp2.Offset(-1, 1)).Merge
        
        ' date and weekday
        sh.Range(tmp1, tmp2).Merge
        
        tmp1.Font.Bold = True
        r.Font.Bold = True
        
        
        If toggle Then
            With sh.Range(tmp1.Offset(-1, 0), r)
                .Font.Color = colors.colorMattBlack
                .Font.Size = 10
                .Interior.Color = RGB(255, 255, 255)
            End With

        Else
            
            With sh.Range(tmp1.Offset(-1, 0), r)
                .Font.Color = colors.colorMattBlack
                .Font.Size = 10
                .Interior.Color = colors.colorFireFlakeGrey
            End With
            
        End If
        
        Me.fillSolidGridLines sh.Range(tmp1.Offset(-1, 0), r), colors.colorMattBlack
        
        
        Set r = r.Offset(0, 1)
        
        If toggle Then
            toggle = False
        Else
            toggle = True
        End If
        
    Loop Until Trim(r) = ""

End Sub


Public Sub adjustLabelRow(ByRef r As Range)


    Dim tmp As Range, innerTmp As Range, obszar As Range, toggle As Boolean
    Set tmp = r.Parent.Range(r, r.End(xlToRight))
    
    
    r.EntireRow.RowHeight = 70
    Me.changeTxtOrientation tmp, 90
    
    Dim lastRow As Long
    Dim lastCol As Long
    
    lastRow = r.End(xlDown).Row
    lastCol = r.End(xlToRight).Column
    
    Set obszar = r.Parent.Range(r, r.Parent.Cells(lastRow, lastCol))
    Me.fillThinGridLines obszar, colors.colorMattBlack
    obszar.Font.Size = 9
    
    
    Dim forWholeColumn As Range, fwc As Range
    
    
    ' part number
    Set forWholeColumn = r.Parent.Cells(1, 2)
    Set fwc = forWholeColumn
    fwc.EntireColumn.ColumnWidth = 13
    
    ' plt code
    Set forWholeColumn = r.Parent.Cells(1, 3)
    Set fwc = forWholeColumn
    fwc.EntireColumn.ColumnWidth = 5
    ' plt name
    Set forWholeColumn = r.Parent.Cells(1, 4)
    Set fwc = forWholeColumn
    fwc.EntireColumn.ColumnWidth = 10
    ' part name
    Set forWholeColumn = r.Parent.Cells(1, 5)
    Set fwc = forWholeColumn
    fwc.EntireColumn.ColumnWidth = 13
    ' supplier
    Set forWholeColumn = r.Parent.Cells(1, 6)
    Set fwc = forWholeColumn
    fwc.EntireColumn.ColumnWidth = 45
    
    toggle = True
    Set fwc = r.Parent.Cells(r.Row, 16)
    Do
    
        fwc.EntireColumn.ColumnWidth = 5
        fwc.Offset(0, 1).EntireColumn.ColumnWidth = 5
        fwc.Offset(0, 2).EntireColumn.ColumnWidth = 5
        fwc.Offset(0, 3).EntireColumn.ColumnWidth = 10
        
        fwc.Parent.Range(fwc, fwc.Offset(0, 3)).Font.Size = 11
        fwc.Offset(0, 3).Font.Bold = True
        fwc.Offset(0, 3).Font.Color = colors.colorMattBlack
        
        If toggle Then
            fwc.Parent.Range(fwc, fwc.Offset(lastRow - fwc.Row, 3)).Interior.Color = colors.colorFireFlakeGrey
        Else
            fwc.Parent.Range(fwc, fwc.Offset(lastRow - fwc.Row, 3)).Interior.Color = RGB(255, 255, 255)
        End If
    
        
        Set fwc = fwc.Offset(0, 4)
        toggle = Not toggle
    Loop Until Trim(fwc) = ""
End Sub



'dunamic colors
Public Sub colourFontsOnOtherThanBalanceColumns(ByRef r As Range)


    adjustShipFormat r
    adjustRqmCellsFormat r

End Sub




Private Sub adjustRqmCellsFormat(ByRef r As Range)

    Dim tmpr As Range, area As Range
    Set tmpr = r.Offset(0, 15 - 1)
    Do
        Set area = prepareArea(tmpr, r)
        area.Offset(0, -3).NumberFormat = "[Blue]0_ ;[Red]-0 ;0_ "
        Set tmpr = tmpr.Offset(0, 4)
    Loop Until Trim(tmpr) = ""
End Sub

Private Sub adjustShipFormat(ByRef r As Range)

    Dim tmpr As Range, area As Range
    Set tmpr = r.Offset(0, 17 - 1)
    Do
        Set area = prepareArea(tmpr, r)
        area.Offset(0, -1).NumberFormat = "[Blue]0_ ;[Red]-0 ;0_ "
        Set tmpr = tmpr.Offset(0, 4)
    Loop Until Trim(tmpr) = ""
End Sub


Private Function prepareArea(tmpr As Range, r As Range) As Range
    
    Dim tmp As Range
    Set tmp = tmpr
    Set tmp = r.Parent.Range(tmp, tmp.Parent.Cells(r.End(xlDown).Row, tmp.Column))
    Set prepareArea = tmp
End Function


 
Public Sub changeTxtOrientation(rng As Range, angle As Integer)

    With rng
        .HorizontalAlignment = xlCenter
        .VerticalAlignment = xlBottom
        .Orientation = Int(angle)
        
    End With
End Sub


Public Sub fillSolidGridLines(rng As Range, kolor As Long)
    
    
    rng.Borders(xlDiagonalDown).LineStyle = xlNone
    rng.Borders(xlDiagonalUp).LineStyle = xlNone
    With rng.Borders(xlEdgeLeft)
        .LineStyle = xlContinuous
        .Color = kolor
        .TintAndShade = 0
        .Weight = xlMedium
    End With
    With rng.Borders(xlEdgeTop)
        .LineStyle = xlContinuous
        .Color = kolor
        .TintAndShade = 0
        .Weight = xlMedium
    End With
    With rng.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .Color = kolor
        .TintAndShade = 0
        .Weight = xlMedium
    End With
    With rng.Borders(xlEdgeRight)
        .LineStyle = xlContinuous
        .Color = kolor
        .TintAndShade = 0
        .Weight = xlMedium
    End With
    With rng.Borders(xlInsideVertical)
        .LineStyle = xlContinuous
        .Color = kolor
        .TintAndShade = 0
        .Weight = xlMedium
    End With
    With rng.Borders(xlInsideHorizontal)
        .LineStyle = xlContinuous
        .Color = kolor
        .TintAndShade = 0
        .Weight = xlMedium
    End With
    
End Sub

Public Sub fillThinGridLines(rng As Range, kolor As Long)

    rng.Borders(xlDiagonalDown).LineStyle = xlNone
    rng.Borders(xlDiagonalUp).LineStyle = xlNone
    With rng.Borders(xlEdgeLeft)
        .LineStyle = xlContinuous
        .ColorIndex = 0
        .TintAndShade = 0
        .Weight = xlThin
    End With
    With rng.Borders(xlEdgeTop)
        .LineStyle = xlContinuous
        .ColorIndex = 0
        .TintAndShade = 0
        .Weight = xlThin
    End With
    With rng.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .ColorIndex = 0
        .TintAndShade = 0
        .Weight = xlThin
    End With
    With rng.Borders(xlEdgeRight)
        .LineStyle = xlContinuous
        .ColorIndex = 0
        .TintAndShade = 0
        .Weight = xlThin
    End With
    With rng.Borders(xlInsideVertical)
        .LineStyle = xlContinuous
        .ColorIndex = 0
        .TintAndShade = 0
        .Weight = xlThin
    End With
    With rng.Borders(xlInsideHorizontal)
        .LineStyle = xlContinuous
        .ColorIndex = 0
        .TintAndShade = 0
        .Weight = xlThin
    End With
End Sub



Private Sub Class_Terminate()
    Set colors = Nothing
End Sub

