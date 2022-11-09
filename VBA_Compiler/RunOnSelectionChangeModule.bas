Attribute VB_Name = "RunOnSelectionChangeModule"
Public Sub recalcLayoutAndColors(sh As Worksheet, r As Range)

    With Application
        .EnableEvents = False
        .ScreenUpdating = False
        .Calculation = xlCalculationAutomatic
    End With
    
    
    Dim dc As DynamicColors
    Set dc = New DynamicColors

    
    With Application
        .EnableEvents = True
        .ScreenUpdating = True
        .Calculation = xlCalculationAutomatic
    End With
End Sub


