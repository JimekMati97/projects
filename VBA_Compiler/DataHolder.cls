VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "DataHolder"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'***Getting all data from exFCA and packing them into Adapter. Sending collection of adapters to Adaptee***

Private shWithScmData As Worksheet
Private parts As Collection
Private dataItem As Adapter
Private typeOfFile As String
Private NoSohoInPreviousDays As Boolean
Private colNrWithStockCalc As Integer
Private openedFile As Workbook
Private plantCode As String
Private plantName As String
Private fireflakeFile As FFProcedure

Private finalColOfAdpters As Collection

Public Function getParts()
    Set getParts = parts
End Function

Private Sub repackData()
    If typeOfFile = "FF" Then
        Set parts = fireflakeFile.getPartsCollection()
    End If
    For Each part In parts
        finalColOfAdpters.Add part
    Next
End Sub
Private Sub calculateInitialStock()
    Dim part As Adapter
    Dim singleDayIter As Integer
    Dim dayWhereSohoisKnown As Integer
    Dim InitialStock As Long
    
    For Each part In finalColOfAdpters
        'findFirstInsertingPosition
        
        For singleDayIter = 1 To part.scmData.Count
        
            If part.scmData(singleDayIter).firstInsertingPosition = True Then
                
                dayWhereSohoisKnown = singleDayIter
                'if we deal with scm file we schould look for stock value, else look for Soho value
                If part.typeOfFile = "Scm" Then
                    InitialStock = CLng(convert(part.scmData.Item(singleDayIter).stockPlant))
                    InitialStock = setInitialStock(part, InitialStock, dayWhereSohoisKnown, 1)
                Else
                    InitialStock = CLng(convert(part.scmData.Item(singleDayIter).Soho))
                    InitialStock = setInitialStock(part, InitialStock, dayWhereSohoisKnown, 0)
                End If

                part.InitialStock = "" & InitialStock & ""
            End If
            
        Next
        
    Next
    

End Sub
Private Function setInitialStock(part As Adapter, InitialStock As Long, dayWhereSohoisKnown As Integer, subParam As Integer) As Long

    Dim Rqm As Long
    Dim Delivery As Long
    Dim firstDayInLoop As Boolean
    
    firstDayInLoop = True
    Do While dayWhereSohoisKnown > subParam
         If subParam = 0 And firstDayInLoop = True Then
            firstDayInLoop = False
            Rqm = convert(part.scmData.Item(dayWhereSohoisKnown - subParam).grossReq)
            Delivery = convert(part.scmData.Item(dayWhereSohoisKnown - subParam).etaQty)
            InitialStock = InitialStock - Delivery + Rqm
         Else
            conseganto = convert(part.scmData.Item(dayWhereSohoisKnown - subParam).consegnato)
            consumato = convert(part.scmData.Item(dayWhereSohoisKnown - subParam).consumato)
            InitialStock = InitialStock - conseganto + consumato
            
         End If
         dayWhereSohoisKnown = dayWhereSohoisKnown - 1
    Loop
    
    setInitialStock = InitialStock
End Function

Private Function convert(elementToConvert)
    If elementToConvert = "" Or elementToConvert = "-" Or elementToConvert = "0" Then
        elementToConvert = 0
        convert = elementToConvert
    Else
        convert = CLng(elementToConvert)
    End If
End Function
'getting dates, data from left and right columns of exFCA sheet, also sending them to Adaptee as DataHolder
'param1: copiedSh As Worksheet - sheet with exFCA data
Public Sub getDataFromSCMFile(copiedFiles As ValidatedFiles)
     
    Dim filePath As String
    Dim selectedSheet As String

    'IF user press exit on first window
    If copiedFiles Is Nothing Then
        End
    End If
    
    Dim fileObj As File
    Dim allDates As Collection
     
    'starting display progress bar
    Dim sth As StatusHandler
    Set sth = New StatusHandler
    
    sth.init_statusbar 4
    sth.show
    
    Set finalColOfAdpters = New Collection
        
    'pass file's path, sheet's name, and type of a file (SCM | Report Days) to getDataFromSCMFile to start adapting proccess
    For Each fileObj In copiedFiles.getvalidatedFilesCollection
        
        Set parts = New Collection
        
        filePath = fileObj.getfilePath
        typeOfFile = fileObj.gettypeOfFile
        selectedSheet = fileObj.getselectedSheet
        
        'check if file is in a fireflake standard
        If typeOfFile = "FF" Then
        
            Set fireflakeFile = New FFProcedure
            fireflakeFile.constructor fileObj, filePath, selectedSheet, sth
            
        Else
            Set openedFile = Workbooks.Open(filePath, True, True)
            Set shWithScmData = openedFile.Worksheets(selectedSheet)
            
            shWithScmData.Activate
            
            plantCode = fileObj.getPlantCode()
            plantName = fileObj.getplantName()
            
            'all date information for each day
            Set allDates = New Collection
            
            sth.progress_increase
            
            'preparing data of a plant, part number, part name, supplier name
            getAllDataFromLeftColumns
            
            'preparing dates information for each day
            getAllDates
            'preparing data of stock, requirement, ETA Qty, delins, consumato
            getDataFromRightColumns
            
            openedFile.Close False

        End If
        
        repackData
        
        Set parts = Nothing
        
        'calculate stock for a day before the first day
        If typeOfFile = "Scm" Or typeOfFile = "Rep" Then
            calculateInitialStock
        End If
        
        typeOfFile = ""
    Next
    

    'sending all received data to Adaptee
    'sendDataToAdaptee sth
    sendDataToAdaptee sth
End Sub

'Bringing all values from columns having information about: plant's name, plant's code, part's number,supplier's name
'using Adapter instance to store data in it
'1st for loop - going through all rows in exFCA sheet
    'if statement - checking if current row number is a last row in local scope of a part
Private Sub getAllDataFromLeftColumns()

    
    Dim lastRowNumber As Integer
    lastRowNumber = (shWithScmData.Range("A" & rows.Count).End(xlUp).Row)
    
    'row number
    Dim rowNr As Long
    
    Dim grossReqVal As Integer
    
    Dim iterator As Integer
    iterator = 1
    
    'looping through all rows
    For rowNr = 4 To lastRowNumber
    
                
            
            If typeOfFile = "Rep" Then
                dividingRowsForReportDaysFile rowNr, iterator
            ElseIf typeOfFile = "Scm" Then
                dividingRowsForScmFile rowNr, iterator
            End If
      
        
        iterator = iterator + 1
        
    Next
   
End Sub
Private Sub dividingRowsForReportDaysFile(rowNr, iterator)
    'checking if 7 rows have passed
    If CInt(iterator Mod 7) = 0 Then
    
        Set dataItem = New Adapter
        
             'calculating signs number to substract
             With shWithScmData
             
                
                dataItem.plantName = plantName
                dataItem.partNumber = .Range("B" & rowNr).MergeArea.Cells(1, 1).value
                dataItem.partName = .Range("C" & rowNr).MergeArea.Cells(1, 1).value
                dataItem.plantCode = plantCode
                dataItem.supplierName = .Range("E" & rowNr).MergeArea.Cells(1, 1).value
                dataItem.backlog = .Range("P" & rowNr).MergeArea.Cells(1, 1).value
                dataItem.stock = .Range("J" & rowNr).MergeArea.Cells(1, 1).value
                dataItem.typeOfFile = "Rep"
             End With
             
        parts.Add dataItem
      
        iterator = 0
        
    End If
End Sub
Private Sub dividingRowsForScmFile(rowNr, iterator)
    'checking if 8 rows have passed
    If CInt(iterator Mod 8) = 0 Then
    
        Set dataItem = New Adapter
        
             'calculating signs number to substract
             With shWithScmData
             
                lengthOfplantCode = Len(.Range("C" & rowNr).MergeArea.Cells(1, 1).value)
                dashPos = InStr(.Range("C" & rowNr).MergeArea.Cells(1, 1).value, "-")
                countOfSignsToSubstract = lengthOfplantCode - dashPos
                
                dataItem.plantName = Right(.Range("C" & rowNr).MergeArea.Cells(1, 1).value, lengthOfplantCode - dashPos - 1)
                dataItem.partNumber = .Range("A" & rowNr).MergeArea.Cells(1, 1).value
                dataItem.partName = .Range("B" & rowNr).MergeArea.Cells(1, 1).value
                dataItem.plantCode = left(.Range("C" & rowNr).MergeArea.Cells(1, 1).value, dashPos - 2)
                dataItem.supplierName = .Range("E" & rowNr).MergeArea.Cells(1, 1).value
                dataItem.backlog = .Range("H" & rowNr).MergeArea.Cells(1, 1).value
                dataItem.typeOfFile = "Scm"
                
             End With
             
        parts.Add dataItem
      
        iterator = 0
        
    End If
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
    lastColumnNumber = shWithScmData.Cells(3, Columns.Count).End(xlToLeft).Column
    
    Dim currentColumnDate, nextColumnDate As Date
    Dim dateDiffrence As Variant
    Dim colNr As Integer
    
    'checking with what file type we are dealing with. For scm type starting column nr=13, for Rep=18
    If typeOfFile = "Scm" Then
        colNr = 13
        
    ElseIf typeOfFile = "Rep" Then
        colNr = 18
        
    Else
        MsgBox ("Wrong File standard, program can not find starting column")
    End If
    
    For Each adaptedPart In parts
    
        With shWithScmData
                
            For columnNr = colNr To lastColumnNumber
                 'checking if it's last column
                 If columnNr = lastColumnNumber Then
                     dateDiffrence = 7
                    
                 Else

                     'date value of current columnNr
                     currentColumnDate = CDate(.Cells(3, columnNr).value)
                     'date value of next columnNr
                     nextColumnDate = CDate(.Cells(3, columnNr + 1).value)
                     'calculating date diffrence between current columnNr and columnNr+1
                     dateDiffrence = DateDiff("d", currentColumnDate, nextColumnDate)
                 End If
                
    
                 For singleDay = 1 To dateDiffrence
                     
                     'late bounding
                     Set dayObj = adaptedPart.createDayObj()
                     
                     'changing day name to english
                     dayObj.particularDate = DateAdd("d", singleDay - 1, CDate(.Cells(2, columnNr).value))
    
                     engDay = WorksheetFunction.text(dayObj.particularDate, "[$-409]dddd")
                     dayObj.Monthday = engDay
    
                     
                     'calculating signs number to substract
                     lengthOfSettimane = Len(.Cells(1, columnNr).value)
                     spacePos = InStr(.Cells(1, columnNr).value, "W")
                     countOfSignsToSubstract = lengthOfSettimane - spacePos
    
                     dayObj.Settimane = Right(.Cells(1, columnNr).value, countOfSignsToSubstract)
                     dayObj.daysCompressedInOneCol = dateDiffrence
                     
                     adaptedPart.scmData.Add dayObj
                     
                 Next
            Next
        End With
    Next

   
End Sub

'Getting data from right columns (from 4th row to the bottom & from M column to the right): stock, consumato, fabb.Lordo, Soho,
'Eta Qty, Delins+A8.
'Putting those data into Day objects
'1st For loop - going through each part in parts collection
    '2nd for loop - going through each day
        'if statement - checking if a day belongs to those type of days, that were compressed in exFCA sheet in one column
            '2 functions:
            'calculateGrosReqAndConsumato()
            'fillpartsCollectionWithRightColumnsData()
        'else (there were more than one, days compressed)
            'if statement - checking if it's first day of compressed days
                'filling Day object with: values or empty values or moving to another column
                
Private Sub getDataFromRightColumns()
        
    Dim partNr, columnNr, rowOffset, insideColumnCounter, consegnatoCol, partNrinCol, compressedDaysColumnCounter As Integer
    
    partNrinCol = 1
    rowOffset = 0
    insideColumnCounter = 1
    columnNr = 13
    compressedDaysColumnCounter = 0
    
    
    If typeOfFile = "Scm" Then
        columnNr = 13
        consumatoCol = 6
        delinsCol = 11
        sohoCol = 7
        consegnatoCol = 10
    ElseIf typeOfFile = "Rep" Then
        columnNr = 18
        consumatoCol = 7
        delinsCol = 10
        sohoCol = 4
        consegnatoCol = 9
    Else
        MsgBox ("Wrong File standard, program can not find starting column")
    End If
    
    NoSohoInPreviousDays = True
    
    For partNrinCol = 1 To parts.Count
        
        'when we move to another part there was no Soho yet utilized
        'NoSohoInPreviousDays = True
        'putting vertical data to each day
        With shWithScmData
        
            For singleDay = 1 To (parts(partNrinCol).scmData.Count)
    
                'checking if days are compressed in one column
                If parts(partNrinCol).scmData(singleDay).daysCompressedInOneCol = 1 Then
                    
                    reqVal = calculateGrosReqAndConsumato(consumatoCol, partNrinCol, singleDay, rowOffset, columnNr)
                    
                    fillpartsCollectionWithRightColumnsData partNrinCol, singleDay, rowOffset, columnNr, reqVal, delinsCol, sohoCol, consegnatoCol
                    
                    columnNr = columnNr + 1
                'if data interval is more than one day
                Else
                    
                    compressedDaysColumnCounter = compressedDaysColumnCounter + 1
                    'sprawdzenie czy jest to pierwsza kolumna ze skompresowanych dni
                    If insideColumnCounter = 1 Then
    
                        insideColumnCounter = insideColumnCounter + 1
    
                        reqVal = calculateGrosReqAndConsumato(consumatoCol, partNrinCol, singleDay, rowOffset, columnNr)
                        
                        fillpartsCollectionWithRightColumnsData partNrinCol, singleDay, rowOffset, columnNr, reqVal, delinsCol, sohoCol, consegnatoCol
                    
                         
                    'if insideColumnCounter is equal to singleDay.daysCompressedInOneCol, should make it 1
                    ElseIf parts(partNrinCol).scmData(singleDay).daysCompressedInOneCol = insideColumnCounter Then
    
                        insideColumnCounter = 1
                        columnNr = columnNr + 1
    
                    Else
    
                        parts(partNrinCol).scmData(singleDay).stockPlant = ""
                        parts(partNrinCol).scmData(singleDay).grossReq = ""
                        parts(partNrinCol).scmData(singleDay).etaQty = ""
                        parts(partNrinCol).scmData(singleDay).consegnato = ""
                        parts(partNrinCol).scmData(singleDay).Soho = ""
                        parts(partNrinCol).scmData(singleDay).delins = ""
                        parts(partNrinCol).scmData(singleDay).Ebal = ""
                        
                        insideColumnCounter = insideColumnCounter + 1
    
                    End If
                End If
            Next
        End With
        compressedDaysColumnCounter = 0
        
        If typeOfFile = "Scm" Then
            rowOffset = rowOffset + 8
            columnNr = 13
        ElseIf typeOfFile = "Rep" Then
    
            rowOffset = rowOffset + 7
            columnNr = 18
            
        End If
        
    Next

End Sub

'changing values of consumato and grossReq, ultimitly making possible calculating grossReq (fab. lordo)
'3 if statments:
    '1st - checks consumato is "-" and changes it's value to 0
    '2st - checks grossReq is "-" and changes it's value to 0
    '3th - checks if by reducing grossReq with consumato it's value is greater than 0 or equal 0
'param1: partNrinCol As Integer
'param2: singleDay As Integer
'param3: rowOffset As Integer
'param4: columnNr As Integer
'return grossRegVal As Integer
Private Function calculateGrosReqAndConsumato(consumatoCol, partNrinCol, singleDay, rowOffset, columnNr)

    With shWithScmData
        parts(partNrinCol).scmData(singleDay).consumato = .Cells(consumatoCol + rowOffset, columnNr).value
                       
         'if consumato is "-" then change it to 0
         If parts(partNrinCol).scmData(singleDay).consumato = "-" Then
             parts(partNrinCol).scmData(singleDay).consumato = 0
         End If
         
         'if grossReq ="-" Then it should be equal 0
         If .Cells(5 + rowOffset, columnNr).value = "-" Then
             parts(partNrinCol).scmData(singleDay).grossInitialReqVal = 0
         Else
             parts(partNrinCol).scmData(singleDay).grossInitialReqVal = .Cells(5 + rowOffset, columnNr).value
         End If
         
         'If consumato is greater than grossReq then it should return 0, else returns (grossReq-consumato)
         
         grossReqVal = parts(partNrinCol).scmData(singleDay).grossInitialReqVal - parts(partNrinCol).scmData(singleDay).consumato
         
         If grossReqVal < 0 Then
             grossReqVal = 0
         End If
         
         parts(partNrinCol).scmData(singleDay).grossReq = grossReqVal
    End With
    
     calculateGrosReqAndConsumato = grossReqVal
    
End Function

'filling day object with data from left columns
'param1: partNrinCol As Integer
'param2: singleDay As Integer
'param3: rowOffset As Integer
'param4: columnNr As Integer
'param5: reqVal As Integer
Private Sub fillpartsCollectionWithRightColumnsData(ByRef partNrinCol, ByRef singleDay, ByRef rowOffset, ByRef columnNr, ByRef reqVal, ByRef delinsCol, ByRef sohoCol, ByRef consegnatoCol)
    
    With shWithScmData

            
        parts(partNrinCol).scmData(singleDay).grossReq = reqVal
        parts(partNrinCol).scmData(singleDay).Soho = .Cells(sohoCol + rowOffset, columnNr).value
        parts(partNrinCol).scmData(singleDay).etaQty = .Cells(8 + rowOffset, columnNr).value
        parts(partNrinCol).scmData(singleDay).delins = .Cells(delinsCol + rowOffset, columnNr).value
        parts(partNrinCol).scmData(singleDay).consegnato = .Cells(consegnatoCol + rowOffset, columnNr).value
        
        If typeOfFile = "Scm" Then
        
            If (.Cells(4 + rowOffset, columnNr).value <> 0 And .Cells(4 + rowOffset, columnNr).value <> "-" _
            And NoSohoInPreviousDays = True) Or parts(partNrinCol).scmData(singleDay).firstInsertingPosition = True Then

            
                'make a for loop to show, that from that column should starting pasting formulas in adaptee
                'Jest uzywane tylko w sytuacjach, w ktorych czesci dla ktorych soho i stock =0, musza zostac zmienione z racji rozpoznania
                'kolumny od ktorej maja zostac wkleione wartosci
                NoSohoInPreviousDays = False
                colNrWithStockCalc = singleDay
                
                For partNr = 1 To parts.Count
                    parts(partNr).scmData(singleDay).firstInsertingPosition = True
                    
                Next
                parts(partNrinCol).scmData(singleDay).stockPlant = .Cells(4 + rowOffset, columnNr).value
                'added 24.06
                parts(partNrinCol).stock = parts(partNrinCol).scmData(singleDay).stockPlant
            Else
        
                parts(partNrinCol).scmData(singleDay).stockPlant = .Cells(4 + rowOffset, columnNr).value
                
            End If
            
        ElseIf typeOfFile = "Rep" Then
            'stock zaczyna byc uzywany w momencie kiedy SOHO staje sie rozne od 0 oraz nie zostalo jeszcze ani razu
            'wybrane dla danej czesci. Po wykonaniu sie petli dla danej czesci zmienna NoSohoInPreviousDays zostaje
            'ustawiona ponownie na True. Wtey tez mozemy wypelnic dany dzien
            'stockiem, ktory pobieramy z kolumny J dla pliku REports
            If (parts(partNrinCol).scmData(singleDay).Soho <> 0 And parts(partNrinCol).scmData(singleDay).Soho <> "-" _
            And NoSohoInPreviousDays = True) Then

            
                'make a for loop to show, that from that column should starting pasting formulas in adaptee
                'Jest uzywane tylko w sytuacjach, w ktorych czesci dla ktorych soho i stock =0, musza zostac zmienione z racji rozpoznania
                'kolumny od ktorej maja zostac wkleione wartosci
                NoSohoInPreviousDays = False
                colNrWithStockCalc = singleDay
                
                For partNr = 1 To parts.Count
                    parts(partNr).scmData(singleDay).firstInsertingPosition = True
                    parts(partNr).scmData(singleDay).stockPlant = parts(partNr).stock
                    
                Next
                
            Else
                'jezeli w sytaucji kiedy soho jest 0, a jest potrzebne uzupelnienie stock dla tego dnia, rozpoznajemy czy mamy do czynienia
                'z dniem ktory zostal rozpoznany jako dzien, dla ktorego jest przeliczany stock. Jezeli nie to oznacza to, ze mamy do czynienia
                'z dniem bez stocka i soho
                If singleDay = colNrWithStockCalc Then
                    parts(partNrinCol).scmData(singleDay).stockPlant = parts(partNrinCol).stock
                Else
                    parts(partNrinCol).scmData(singleDay).stockPlant = 0
                End If
            End If

        Else
            MsgBox ("Wrong File standard, program can not find starting column")
        End If
        
    End With
    
End Sub
''sending parts collection to Adaptee class
''param1: sth As StatusHandler - progress bar definition
Private Sub sendDataToAdaptee(sth As StatusHandler)

    Dim adaptedParts As Adaptee
    Set adaptedParts = New Adaptee
    adaptedParts.adapteeRequest sth, finalColOfAdpters

End Sub

