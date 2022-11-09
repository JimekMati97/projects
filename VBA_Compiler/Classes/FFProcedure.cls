VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "FFProcedure"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private filePath As String
Private selectedSheet As String
Private fileObj As File
Private openedFile As Workbook
Private shWithFFData As Worksheet
Private plantCode As String
Private plantName As String
Private allDates As Collection
Private sth As StatusHandler
Private parts As Collection


Private Sub Class_Initialize()

    Set fileObj = Nothing
    filePath = ""
    selectedSheet = ""
    
End Sub

Public Sub constructor(fileObject As File, path As String, sh As String, sthandler As StatusHandler)

    Set fileObj = fileObject
    filePath = path
    selectedSheet = sh
    Set sth = sthandler
    getDataFromFireFlake
    
End Sub

Private Sub getDataFromFireFlake()

    Set openedFile = Workbooks.Open(filePath, True, True)
    Set shWithFFData = openedFile.Worksheets(selectedSheet)
            
    shWithFFData.Activate
    
    
    'all date information for each day
    Set allDates = New Collection
    Set parts = New Collection
    sth.progress_increase

    'preparing data of a plant, part number, part name, supplier name
    getAllDataFromLeftColumns
'
'    'preparing dates information for each day
    getAllDates
'    'preparing data of stock, requirement, ETA Qty, delins, consumato
    getDataFromRightColumns
    
    openedFile.Close False
End Sub
'Bringing all values from columns having information about: plant's name, plant's code, part's number,supplier's name
'using Adapter instance to store data in it
'1st for loop - going through all rows in exFCA sheet
    'if statement - checking if current row number is a last row in local scope of a part
Private Sub getAllDataFromLeftColumns()

    
    Dim lastRowNumber As Integer
    lastRowNumber = (shWithFFData.Range("B" & rows.Count).End(xlUp).Row)
    
    'row number
    Dim rowNr As Long
    
    Dim grossReqVal As Integer
    
    Dim iterator As Integer
    iterator = 1
    
    'looping through all rows
    For rowNr = 5 To lastRowNumber
    
                
        Set dataItem = New Adapter
        
             'calculating signs number to substract
             With shWithFFData
               
                dataItem.partNumber = .Range("B" & rowNr).value
                dataItem.plantCode = .Range("C" & rowNr).value
                dataItem.plantName = .Range("D" & rowNr).value
                dataItem.partName = .Range("E" & rowNr).value
                dataItem.supplierName = .Range("F" & rowNr).value
                dataItem.backlog = .Range("K" & rowNr).value
                dataItem.resp = .Range("G" & rowNr).value
                dataItem.comment2 = .Range("I" & rowNr).value
                dataItem.comment1 = .Range("H" & rowNr).value
                dataItem.bip = .Range("L" & rowNr).value
                dataItem.hazards = .Range("M" & rowNr).value
                dataItem.recev = .Range("O" & rowNr).value
                dataItem.stock = .Range("N" & rowNr).value
                dataItem.typeOfFile = "FF"
                
             End With
             
        parts.Add dataItem
      
        
        iterator = iterator + 1
        
    Next
   
End Sub

'getting all dates values: Settimane, Monthday, Date, daysCompressedInOneCol
'*Settimane is a string consisting only of a week number
'1st for loop - going through each part in parts collection
    '2nd for loop - going through each column
        'if statment - calculating date diffrence
        '3th for loop - defining settimane, Monthday, Date, daysCompressedInOneCol for each day

Private Sub getAllDates()
    
    Dim dayObj As Day
    
    Dim lastColumnNumber, singleDay, columnNr As Long
    lastColumnNumber = shWithFFData.Cells(3, Columns.Count).End(xlToLeft).Column
    
    Dim currentColumnDate, nextColumnDate As Date
    Dim dateDiffrence As Variant
    Dim colNr As Integer
    
    For Each adaptedPart In parts
    
        With shWithFFData
                
            For columnNr = 16 To lastColumnNumber
                                 
                     Set dayObj = adaptedPart.createDayObj()
                    
                     'changing day name to english
                     dayObj.particularDate = CDate(.Cells(3, columnNr).value)
    
                     engDay = WorksheetFunction.text(dayObj.particularDate, "[$-409]dddd")
                     dayObj.Monthday = engDay
    
                     
                     dayObj.daysCompressedInOneCol = 1
                     
                     adaptedPart.scmData.Add dayObj
                     
                 
                 columnNr = columnNr + 3
            Next
        End With
    Next

   
End Sub


'Getting data from right columns (from 4th row to the bottom & from M column to the right): stock, consumato, fabb.Lordo, Soho,
'Eta Qty, Delins+A8.

                
Private Sub getDataFromRightColumns()
        
    Dim partNr, columnNr, rowOffset, insideColumnCounter, partNrinCol, compressedDaysColumnCounter As Integer
    
    partNrinCol = 1
    rowOffset = 0
    columnNr = 16


    
    For partNrinCol = 1 To parts.Count
        
        With shWithFFData
        
            For singleDay = 1 To (parts(partNrinCol).scmData.Count)

                parts(partNrinCol).scmData(singleDay).grossReq = .Cells(5 + rowOffset, columnNr).value
                parts(partNrinCol).scmData(singleDay).etaQty = .Cells(5 + rowOffset, columnNr + 2).value
                parts(partNrinCol).scmData(singleDay).delins = .Cells(5 + rowOffset, columnNr + 1).value
                parts(partNrinCol).scmData(singleDay).formula = setFormulaType(CStr(.Cells(5 + rowOffset, columnNr + 3).formula))
                
                
                If .Cells(5 + rowOffset, columnNr + 1).comment Is Nothing Then
                    parts(partNrinCol).scmData(singleDay).orderComment = ""
                Else
                    
                    parts(partNrinCol).scmData(singleDay).orderComment = calcRowsWidth(.Cells(5 + rowOffset, columnNr + 1), parts(partNrinCol).scmData(singleDay))
                
                End If
                
                columnNr = columnNr + 4
            Next
            
            columnNr = 16
            rowOffset = rowOffset + 1
        End With
        
    Next

End Sub

Private Function calcRowsWidth(cell As Variant, part As Day)

    Dim str As String
    Dim cm As comment
    Dim commentHeight As Integer
    Set cm = cell.comment
    
    Dim rng As String
    rng = Range(cell, cell).Address
    
    part.commentHeight = Range(rng).comment.Shape.Height
    
    str = left(cm.text, 5) & "     " & Right(cm.text, Len(cm.text) - 5)
    str = left(str, 25) & "   " & Right(str, Len(str) - 25)
    str = left(str, 38) & "     " & Right(str, Len(str) - 38)
    str = left(str, 51) & "   " & Right(str, Len(str) - 51)
    str = left(str, 71) & "     " & Right(str, Len(str) - 71)
    str = left(str, 81) & "  " & Right(str, Len(str) - 81)
    str = left(str, 107) & Right(str, Len(str) - 108)
    str = left(str, 112) & " " & Right(str, Len(str) - 112)
    str = left(str, 118) & " " & Right(str, Len(str) - 118)
    str = left(str, 127) & "    " & Right(str, Len(str) - 127)
    
    calcRowsWidth = str
    
End Function
    


Private Function setFormulaType(formula As String)
    Dim chainStr As String
    Dim regexObj As RegExp
    
    Set regexObj = New RegExp
    Debug.Print
    'regexObj.Pattern = "(R. S.: )([^<]*)(\s*</td>)"
    regexObj.Pattern = "(\w+[+|-]?)"
    regexObj.Global = True
    regexObj.IgnoreCase = True
    chainStr = formula
    
    
    Set matches = regexObj.Execute(chainStr)
    If matches.Count = 4 Then
    
        If left(matches(3), 1) = "L" Then
        'bip formula
            setFormulaType = 1
        ElseIf left(matches(3), 1) = "O" Then
        'Receving formula
            setFormulaType = 2
        Else
        'standard Ebal formula
            setFormulaType = 4
        End If
        
    'standard Ebal formula
    Else
        setFormulaType = 4
    End If
'    For Each oneMatch In matches
'        Debug.Print oneMatch
'        'Exit For
'    Next oneMatch
    
End Function

Public Function getPartsCollection()
    Set getPartsCollection = parts
End Function
