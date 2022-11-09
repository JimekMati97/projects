VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} UserForm1 
   Caption         =   "SCM file selector"
   ClientHeight    =   2445
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   5175
   OleObjectBlob   =   "UserForm1.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "UserForm1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private listOfValidatedFiles As ValidatedFiles
Private validatedSheet As Sheet
Private validatedFile As File
Private FileExists As Boolean

Public fileNameBx As MSForms.TextBox
Public WithEvents CmbBxEvents As MSForms.ComboBox
Attribute CmbBxEvents.VB_VarHelpID = -1

Public CmbBx2 As MSForms.ComboBox
Public WithEvents CmbBx2Events As MSForms.ComboBox
Attribute CmbBx2Events.VB_VarHelpID = -1

Public TextBx As MSForms.TextBox
Public TextBxPlantName As MSForms.TextBox

Public MergeBtn As MSForms.CommandButton
Public WithEvents MergeBtnEvents As MSForms.CommandButton
Attribute MergeBtnEvents.VB_VarHelpID = -1

Private listOfSheets As Collection
Private topPadding As Long
Private validatedFileNr As Integer

Private sheetsColForm As Collection
Private plantCodesForm As Collection
Private plantNamesColForm As Collection




Private Sub SelectFilesButton_Click()

    Dim myPaths As Variant
    'list of pointed  by user files to open
    myPaths = Application.GetOpenFilename(MultiSelect:=True)
   
    If VarType(myPaths) = vbBoolean Then
        Exit Sub
    ElseIf VarType(myPaths) = 8204 Then
        'validation process
        orginizeValidation myPaths
    End If

  
End Sub
Private Sub orginizeValidation(myPaths As Variant)

    Dim fso As New FileSystemObject
    Dim fileName As String
            
    Dim singleFile As Workbook
    Dim sh As Worksheet

    
    Set listOfValidatedFiles = New ValidatedFiles
    
    Dim I As Integer
    Dim numberOfPaths As Integer
    Dim plantCodeAndName() As String
    Dim numberOfUploadedFiles As Integer
    
    numberOfUploadedFiles = UBound(myPaths) - LBound(myPaths) + 1
    
    If numberOfUploadedFiles <= 8 Then
        If IsArray(myPaths) Then  '<~~ If user selects multiple file
        
            For I = LBound(myPaths) To UBound(myPaths)
                FileExists = False
                numberOfPaths = numberOfPaths + 1
                
                Dim openedFile As Workbook
                'keeping excel in readonly state
              
                Set openedFile = Workbooks.Open(myPaths(I), True, True)
                
                Set validatedFile = New File
                
                'setting name of a file
                fileName = fso.getFileName(myPaths(I))
                validatedFile.setFileName (fileName)
                validatedFile.setfilePath (myPaths(I))
                
                For Each sh In openedFile.Worksheets
                
                   'max column number filled with data in a third row
                    Dim lastColumnNumber  As Long
                    lastColumnNumber = sh.Cells(3, Columns.Count).End(xlToLeft).Column
                    
                    'third row headers checking
                    For Column = 1 To lastColumnNumber
                    
                        If (sh.Cells(3, Column).value = "Date" And sh.Cells(3, Column).Offset(-1, 0).value = "MonthDay") _
                        Or (sh.Cells(3, Column).value = "Data" And sh.Cells(3, Column).Offset(-1, 0).value = "MonthDay") _
                        Or ((sh.Cells(4, 13).value = "Hazards") _
                        And (sh.Cells(4, 14).value = "Stock") And (sh.Cells(4, 15).value = "Recv")) Then
    
                                Set validatedSheet = New Sheet
                                'adding name (String) to Sheet attribute instance
                                validatedSheet.setSheetName (sh.name)
                                'set first sheet as selected
                                If validatedFile.getisSetSheet = False Then
                                    validatedSheet.setselectedSheet (True)
                                    validatedFile.setisSetSheet (True)
                                End If
                                
                                'adding name(String) to collection of names in File instance
                                validatedFile.getsheetNamesCollection.Add sh.name
                                'adding Sheet obj to collection in File instance
                                validatedFile.getsheetCollection.Add validatedSheet
                                'check the type of validated file: Scm or Report days?
                                If sh.Cells(3, 1).value = "MRP" Then
                                    'validatedFile.settypeOfFile ("Rep")
                                    validatedSheet.setSheetType ("Rep")
                                    validatedFile.settypeOfFile ("Rep")
                                    
                                ElseIf ((sh.Cells(4, 13).value = "Hazards") _
                                And (sh.Cells(4, 14).value = "Stock") And (sh.Cells(4, 15).value = "Recv")) Then
                                    validatedSheet.setSheetType ("FF")
                                    validatedFile.settypeOfFile ("FF")
                                    'typeOfFile = "FF"
                                Else
                                    'validatedFile.settypeOfFile ("Scm")
                                    validatedSheet.setSheetType ("Scm")
                                    validatedFile.settypeOfFile ("Scm")
                                    'typeOfFile = "Scm"
                                End If
                                'check if file was already added
                                For Each fileAdded In listOfValidatedFiles.getvalidatedFilesCollection
                                    If fileAdded.getFileName = fileName Then
                                        FileExists = True
                                    End If
                                Next
                                
                                If FileExists = False Then
                                    
                                    listOfValidatedFiles.getvalidatedFilesCollection.Add validatedFile
                                End If
                                
    
                                'try set Plant Code and Plant Name
                                If validatedFile.gettypeOfFile = "Scm" Then
                                    
                                    plantCodeAndName = Split(sh.Range("C" & 4).MergeArea.Cells(1, 1).value, "-")
                                    validatedFile.setPlantCode (plantCodeAndName(0) & ",...")
                                    validatedFile.setplantName (plantCodeAndName(1) & ",...")
                                ElseIf validatedFile.gettypeOfFile = "FF" Then
                                    validatedFile.setPlantCode (sh.Range("C" & 5).value & ",...")
                                    validatedFile.setplantName (sh.Range("D" & 5).value & ",...")
                                Else
                                    validatedFile.setPlantCode ("")
                                    validatedFile.setplantName ("")
                                                        
                                End If
                                
                                Exit For
                        End If
                    
                    Next
               Next
               openedFile.Close (False)
               
            Next I
        Else '<~~ If user selects single file
            MsgBox "You didn't choose any file"
            End
        End If
        
    Else
        If numberOfUploadedFiles > 8 Then
            MsgBox ("You can't upload more than 8 files. Please try again.")
            End
        End If
    End If
    'displaying message with number of sheets that fullfill the requiremtns
    validatedfilesNumber = displayDiffrenceOfValidation(listOfValidatedFiles.getvalidatedFilesCollection.Count, numberOfPaths)
    
    Set sheetsColForm = New Collection
    Set plantCodesForm = New Collection
    Set plantNamesColForm = New Collection
    
    If validatedfilesNumber > 0 Then
        
        UserForm1.SelectFilesButton.Visible = False
        UserForm1.width = 520
        'height:66 width:228
        UserForm1.Image1.left = (UserForm1.width - 228) / 2
        
        topPadding = 50
        
            Add_Dynamic_FieldLabel "Forms.Label.1", "List of files", 70, 100
            Add_Dynamic_FieldLabel "Forms.Label.1", "List of sheets", 230, 100
            Add_Dynamic_FieldLabel "Forms.Label.1", "Plant Code", 364, 100
            Add_Dynamic_FieldLabel "Forms.Label.1", "Plant Name", 442, 100
            

        For validatedFileNr = 1 To validatedfilesNumber
            'modify form
            Add_Dynamic_TextBoxWithFileName
            Add_Dynamic_ComboBoxWithSheets
            Add_Dynamic_PlantCodeTextbox
            Add_Dynamic_PlantNameInputBox
            
            
            topPadding = topPadding + 30
        Next
        
        'add Merge and transform btn
        Add_Dynamic_MergeAndTransformBtn
        
        'setting userForm height
        UserForm1.Height = topPadding + 130
        
        
    'display message on a form, about lack of work to do because of not fullfiling standard by any of a sheet
    Else
        MsgBox ("Unfortunately any of a selected files has been uploaded.")
    End If

    
End Sub
Private Sub Add_Dynamic_FieldLabel(formType As String, caption As String, left As Integer, top As Integer)
    'adding text label
    'Add Dynamic Label and assign it to object 'Lbl'
    Set lbl = UserForm1.Controls.Add(formType)
    
    'Assign Label Name
    lbl.caption = caption

    'Label Position
    lbl.left = left
    lbl.top = top
End Sub

Private Function displayDiffrenceOfValidation(correctFiles, numberOfPaths)

    diff = correctFiles - numberOfPaths
    If diff = 0 Then
        MsgBox ("All files are correct.")
    ElseIf diff < 0 Then
        MsgBox (correctFiles & " of " & numberOfPaths & " files have been uploaded. " & Abs(diff) & " of them do not fullfill any of standards required.")
    End If

    displayDiffrenceOfValidation = correctFiles
    
   
End Function
Private Sub setFormTypePropertiesOfRowWithData(formObj, left As Integer, top As Integer, width As Integer, name As String)

    formObj.left = left
    formObj.top = top
    formObj.width = width
    formObj.name = name
    
End Sub

Private Sub Add_Dynamic_TextBoxWithFileName()
    
    'Add Dynamic Combo Box and assign it to object 'CmbBx'
    Set fileNameBx = UserForm1.Controls.Add("Forms.TextBox.1")

    'Combo Box Position
    setFormTypePropertiesOfRowWithData fileNameBx, 10, MARGINTOPPADDING + topPadding, 160, "ComboBox" & validatedFileNr

    'Debug.Print listOfValidatedFiles.getvalidatedFilesCollection().Count
    fileNameBx.value = listOfValidatedFiles.getvalidatedFilesCollection()(validatedFileNr).getFileName
    fileNameBx.Enabled = False

End Sub


Private Sub Add_Dynamic_ComboBoxWithSheets()

    'Add Dynamic Combo Box and assign it to object 'CmbBx'
    Set CmbBx2 = UserForm1.Controls.Add("Forms.comboBox.1")

    setFormTypePropertiesOfRowWithData CmbBx2, 180, MARGINTOPPADDING + topPadding, 160, "ComboBox" & validatedFileNr
    
    Set listOfSheets = getAllSheetsFromFile(fileNameBx.value)
    
    
    For Each sheetName In listOfSheets
        'TextBox1.Text = ComboBox1.value
        CmbBx2.AddItem sheetName
    Next
    
    sheetsColForm.Add CmbBx2
    'selecting first item on a list as a default
    CmbBx2.ListIndex = 0
End Sub
Private Sub Add_Dynamic_PlantCodeTextbox()


    'Add Dynamic Combo Box and assign it to object 'CmbBx'
    Set TextBx = UserForm1.Controls.Add("Forms.TextBox.1")

    setFormTypePropertiesOfRowWithData TextBx, 350, MARGINTOPPADDING + topPadding, 70, "PlantCodeTxBx" & validatedFileNr

    'check if plant code and plant name exist, if yes, disable editing input
    If listOfValidatedFiles.getvalidatedFilesCollection()(validatedFileNr).getPlantCode <> "" Then
        TextBx.Enabled = False
    End If
    TextBx.value = listOfValidatedFiles.getvalidatedFilesCollection()(validatedFileNr).getPlantCode
    
    plantCodesForm.Add TextBx
    
End Sub

Private Sub Add_Dynamic_PlantNameInputBox()
    'Add Dynamic Combo Box and assign it to object 'CmbBx'
    Set TextBxPlantName = UserForm1.Controls.Add("Forms.TextBox.1")

    setFormTypePropertiesOfRowWithData TextBxPlantName, 430, GLOBALS.MARGINTOPPADDING + topPadding, 70, "PlantCodeTxBx" & validatedFileNr
    
    'check if plant name exist, if yes, disable editing input
    If listOfValidatedFiles.getvalidatedFilesCollection()(validatedFileNr).getplantName <> "" Then
        TextBxPlantName.Enabled = False
    End If
    
    TextBxPlantName.value = listOfValidatedFiles.getvalidatedFilesCollection()(validatedFileNr).getplantName
    plantNamesColForm.Add TextBxPlantName
End Sub

Public Function getAllSheetsFromFile(path As String)

    Dim listOfSheetsOfSelectedFile As Collection
    
    For Each singleFile In listOfValidatedFiles.getvalidatedFilesCollection
        If singleFile.getFileName = path Then
            Set listOfSheetsOfSelectedFile = singleFile.getsheetNamesCollection
        End If
    Next
    
   Set getAllSheetsFromFile = listOfSheetsOfSelectedFile

End Function

'selecting option in combobox with files
Private Sub Add_Dynamic_MergeAndTransformBtn()
        'Add Dynamic Combo Box and assign it to object 'CmbBx'
    Set MergeBtn = UserForm1.Controls.Add("Forms.CommandButton.1")

    'Combo Box Position
    MergeBtn.top = topPadding + 60
    MergeBtn.caption = "Merge&Transform"
    MergeBtn.width = 80
    MergeBtn.Height = 28
    MergeBtn.name = "MergeBtn"
    MergeBtn.left = (UserForm1.width / 2) - (MergeBtn.width / 2)
        'puttig data in a combobox
    Set MergeBtnEvents = MergeBtn
End Sub

Private Sub MergeBtnEvents_Click()
          
        'updating data in collection of File objs, with filled plant codes, plant names and chosen sheets
        For nrOfFile = 1 To listOfValidatedFiles.getvalidatedFilesCollection.Count
                
                
                If InStr(plantCodesForm(nrOfFile).value, ",") > 0 Then

                     listOfValidatedFiles.getvalidatedFilesCollection(nrOfFile).setPlantCode ("")
                Else
                    listOfValidatedFiles.getvalidatedFilesCollection(nrOfFile).setPlantCode (plantCodesForm(nrOfFile).value)
                End If

                If InStr(plantNamesColForm(nrOfFile).value, ",") > 0 Then

                     listOfValidatedFiles.getvalidatedFilesCollection(nrOfFile).setplantName ("")
                Else
                    listOfValidatedFiles.getvalidatedFilesCollection(nrOfFile).setplantName (plantNamesColForm(nrOfFile).value)
                End If

                listOfValidatedFiles.getvalidatedFilesCollection(nrOfFile).setselectedSheet (sheetsColForm(nrOfFile).value)
           
            
        Next

UserForm1.hide
End Sub

Public Function getListOfValidateFiles() As ValidatedFiles
    Set getListOfValidateFiles = listOfValidatedFiles
End Function

