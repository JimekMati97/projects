Attribute VB_Name = "main"
Public Sub inner_main(copiedFiles As ValidatedFiles)
    
    
    Dim scmFile As DataHolder
    Set scmFile = New DataHolder
    
    scmFile.getDataFromSCMFile copiedFiles
       
End Sub

Public Sub mainSelectScmSheet(ictrl As IRibbonControl)

    Application.EnableEvents = False
    Application.Calculation = xlCalculationManual
    Application.ScreenUpdating = False
    
    ThisWorkbook.Sheets("reg").Range("Run").value = 1
    
    UserForm1.show
    
    Dim copiedFiles As ValidatedFiles
    Set copiedFiles = UserForm1.getListOfValidateFiles()
    
    'if user press exit on first screen
    If copiedFiles Is Nothing Then
        End
    End If

    
    inner_main copiedFiles
    
    MsgBox ("Ready")
    
    Application.EnableEvents = True
    Application.Calculation = xlCalculationAutomatic
    Application.ScreenUpdating = True
    
    ThisWorkbook.Sheets("reg").Range("Run").value = 0
    
End Sub

