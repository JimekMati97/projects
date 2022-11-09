VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Adaptee"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'***Converting data to Fire Flake standards. Using Fire Flake components***


Private shResult As Worksheet 'defining Fire Flake data standard sheet
Private layout As TheLayout 'defining FF's interface
Private sthandler As StatusHandler
Private parts As Collection
Private earliestDate As Date
Private latestDate As Date
Private arrayOfFormulas As Dictionary

'creating FF's formulas in a sheet, creating Layout
'param1: partsFromAdaper As Collection - it's a collection of adapters
'param2: sth As StatusHandler
'2 Functions:
    'createTemplate
    'createTheLayout
Public Sub adapteeRequest(sth As StatusHandler, ByVal partsCol As Collection)
    
    Set sthandler = sth
    Set parts = partsCol
    
    'creaing new sheet, which will be filled with Fire Flake data standard
    Set shResult = ThisWorkbook.Sheets.Add
    'recognise whats date range of a files
    getRangeOfDates
    'create Fire Flake Template
    createTemplate
    
    'create Fire Flake Layout
    createTheLayout

    
End Sub
'open every dataholder and find it's scmData Attribute. Next it loop over each date of a Day obj in scmData Collection. After
'going through all dataHolders, establish the earliest and the latest date. Which are the scope used to build date layout in Fire Flake.
'
Private Sub getRangeOfDates()
    
    Dim part As Adapter
    Dim dayObj As Day
    
    
        For Each part In parts
            For Each dayObj In part.scmData
                'setting earliest day
                If earliestDate = "00:00:00" Then
                    earliestDate = CDate(dayObj.particularDate)
                Else
                    If earliestDate > dayObj.particularDate Then
                        earliestDate = dayObj.particularDate
                    End If
                End If
                
                'setting latest day
                If latestDate = "00:00:00" Then
                    latestDate = CDate(dayObj.particularDate)
                Else
                    If latestDate <= dayObj.particularDate Then
                        latestDate = dayObj.particularDate
                    End If
                End If
            Next
        Next
    Debug.Print earliestDate
    Debug.Print latestDate

    

End Sub
'filling sheet with data from adapters and establishing formulas
'1st for loop - going through each part in parts collection
    '2nd for loop - going through each day
        '1st. if statment - checking the value of stock
        '2nd if statment checking if it's first day
            'if Statment - checking if stock value has a value diffrent than "-" or ""
                'if statment - checking the value of Soho. and calculating it with proper formula
            'Else: Ebal = 0
        'Else if statment -checnking if it's a day that has not any days compressed inside
            'if Statment - checking if stock value has a value diffrent than "-" or ""
                'if statment - checking the value of Soho. and calculating it with proper formula
            'Else:
                'if Statment - checking if the stock value was prevoius declared
        'Else if statment = checking if it's a day that  has compressed whole week inside
            'if stamement - checnkig if the day number in collection and calculating it with proper formula
Private Function createTemplate()

    sthandler.progress_increase
    
    'creating headers in sheet
    createLeftColumnHeaders
    
    'create days count
    Dim daysCount As Integer
    daysCount = CInt(DateDiff("d", earliestDate, latestDate))
    
    'creating left columns headers
    createRightColumnsHeaders daysCount
       
    'inserting part values
    offsetVal = 0
    Dim rowNr As Integer
    rowNr = 5
    
    Dim colEbalNr As Long
    colEbalNr = 17
    
    Dim firstCompressedDayinCollection As Boolean
    firstCompressedDayinCollection = True
    
    Dim firstCompressedDay As Integer
    compressedDaysCount = 1

    Dim firstDayDate As Date
    Dim lastDayDate As Date
    
    Dim columnCounter As Integer
    columnCounter = 16
    
    Dim firstDayOfAPart As Boolean
    Dim objNrInAdapter As Integer
    
    'date in column is now align wit date in an object
    Dim firstDayOfAdapterIsNowValid As Boolean
    firstDayOfAdapterIsNowValid = False
    
    Dim EbalFormula As Object
    Dim endPuttingComments As Boolean
    Dim initialRqm As Double
    Dim innerDayCounter As Integer
   
    declareArrayOfFormulas
    
    For Each part In parts
    
         objNrInAdapter = 1
         endPuttingComments = False
         firstDayDate = CDate(part.scmData(1).particularDate)
         lastDayDate = CDate(part.scmData(part.scmData.Count).particularDate)
         firstDayOfAPart = True
         innerDayCounter = 1
         
         With shResult
         'part number
         .Cells(rowNr, 2).value = part.partNumber
         'plant Code
         .Cells(rowNr, 3).value = part.plantCode
         'plant Name
         .Cells(rowNr, 4).value = part.plantName
         'part Name
         .Cells(rowNr, 5).value = part.partName
         'supplier Name
         .Cells(rowNr, 6).value = part.supplierName
         
         .Cells(rowNr, 7).value = part.resp
         
         .Cells(rowNr, 8).value = part.comment1
         
         .Cells(rowNr, 9).value = part.comment2
         'backlog
         .Cells(rowNr, 11).value = part.backlog
         
         .Cells(rowNr, 12).value = part.bip
         
         .Cells(rowNr, 13).value = part.hazards
         
         If part.typeOfFile = "Scm" Or part.typeOfFile = "Rep" Then
             .Cells(rowNr, 14).value = check(part.InitialStock)
             .Cells(rowNr, 14).AddComment ("PCV Stock: " & part.stock)
         Else
             .Cells(rowNr, 14).value = check(part.stock)
         End If
        
         .Cells(rowNr, 15).value = part.recev
        
            For I = 1 To daysCount + 1
        
                
                Set EbalFormula = shResult.Cells(rowNr, (GLOBALS.BALANCEColNr + offsetVal))
                
                If (CDate(.Cells(3, columnCounter))) >= firstDayDate And CDate(.Cells(3, columnCounter)) <= lastDayDate Then
                    
                    firstDayOfAdapterIsNowValid = True
                    
                                  
                    '.Cells(rowNr, (GLOBALS.RQMColNr + offsetVal)).value = check(part.scmData(objNrInAdapter).grossReq)
                    .Cells(rowNr, (GLOBALS.ORDERColNr + offsetVal)).value = check(part.scmData(objNrInAdapter).delins)
                    checkIfAddOrderComment part.scmData(objNrInAdapter), .Cells(rowNr, (GLOBALS.ORDERColNr + offsetVal))
'                    .Cells(rowNr, (GLOBALS.DELIVERYColNr + offsetVal)).value = check(part.scmData(objNrInAdapter).etaQty)
                    
                    'add comment with Rqm value and consumato value if date is previous before stock declartion
                    If (part.scmData(objNrInAdapter).firstInsertingPosition = False) And (endPuttingComments = False) And part.typeOfFile <> "FF" Then
                        
                        initialRqm = CDbl(part.scmData(objNrInAdapter).grossInitialReqVal)
                        .Cells(rowNr, (GLOBALS.RQMColNr + offsetVal)).AddComment ("Rqm: " & initialRqm & Chr(10) & "Consumato: " & part.scmData(objNrInAdapter).consumato)
                        .Cells(rowNr, (GLOBALS.RQMColNr + offsetVal)).value = check(part.scmData(objNrInAdapter).consumato)
                        
                        If CLng(check(part.scmData(objNrInAdapter).consegnato)) > 0 Then
                            .Cells(rowNr, (GLOBALS.DELIVERYColNr + offsetVal)).value = check(part.scmData(objNrInAdapter).consegnato)
                            .Cells(rowNr, (GLOBALS.DELIVERYColNr + offsetVal)).AddComment ("Already Delivered")
                        Else
                            .Cells(rowNr, (GLOBALS.DELIVERYColNr + offsetVal)).value = check(part.scmData(objNrInAdapter).etaQty)
                        End If
                    Else
                        endPuttingComments = True
                        .Cells(rowNr, (GLOBALS.RQMColNr + offsetVal)).value = check(part.scmData(objNrInAdapter).grossReq)
                        .Cells(rowNr, (GLOBALS.DELIVERYColNr + offsetVal)).value = check(part.scmData(objNrInAdapter).etaQty)
                    End If
                    
                    If part.typeOfFile = "FF" Then
                        EbalFormula.FormulaR1C1 = fillCellWithFormula(I, CInt(part.scmData(objNrInAdapter).formula), part.typeOfFile)
                    Else
                        EbalFormula.FormulaR1C1 = fillCellWithFormula(I, innerDayCounter, part.typeOfFile)
                    End If
                    
                    colEbalNr = colEbalNr + 4
                    objNrInAdapter = objNrInAdapter + 1
                    innerDayCounter = innerDayCounter + 1
                    
'                'if date of an object is prevoius than date in a sheet, that means it has no data, so we schould pass nothnig
'                'to req and order. If it' first date - column 14, we schould take data from stock
                Else
                    If firstDayOfAPart = True Then
                    'take data from stock and paste them to ending balance
                        EbalFormula.FormulaR1C1 = "=RC[-5]-RC[-3]+RC[-1]"
                    Else
                    'paste normal formula for counting ending balance
                        EbalFormula.FormulaR1C1 = "=RC[-4]-RC[-3]+RC[-1]"
                    End If
                    
                 
                End If
                
                offsetVal = offsetVal + 4
                firstDayOfAPart = False
                columnCounter = columnCounter + 4
                
            Next
            
        End With
        firstDayOfAdapterIsNowValid = False
        'firstDayOfAPart = True
        offsetVal = 0
        columnCounter = 16
        rowNr = rowNr + 1
        firstCompressedDayinCollection = True
        
    Next
End Function
Private Sub declareArrayOfFormulas()

    Set arrayOfFormulas = CreateObject("Scripting.Dictionary")
    
    arrayOfFormulas.Add "Scm", Array("=RC[-5]-RC[-3]+RC[-1]", "=RC[-4]-RC[-3]+RC[-1]", "=RC[-4]-RC[-3]+RC[-1]", "=RC[-4]-RC[-3]+RC[-1]")
    arrayOfFormulas.Add "Rep", Array("=RC[-5]-RC[-3]+RC[-1]", "=RC[-4]-RC[-3]+RC[-1]", "=RC[-4]-RC[-3]+RC[-1]", "=RC[-4]-RC[-3]+RC[-1]")
    arrayOfFormulas.Add "FF", Array("=RC[-5]-RC[-3]+RC[-1]-RC12", "=RC[-4]-RC[-3]+RC[-1]-RC12", "=RC[-4]-RC[-3]+RC[-1]+RC15", "=RC[-4]-RC[-3]+RC[-1]")

End Sub
Private Function fillCellWithFormula(I, innerDayCounter As Integer, typeOfFile As String) As String

    If I = innerDayCounter And innerDayCounter = 1 Then
        fillCellWithFormula = arrayOfFormulas(typeOfFile)(0)
    ElseIf I > innerDayCounter And innerDayCounter < 3 Then
        fillCellWithFormula = arrayOfFormulas(typeOfFile)(innerDayCounter)
    ElseIf I = innerDayCounter And innerDayCounter = 2 Then
        fillCellWithFormula = arrayOfFormulas(typeOfFile)(2)
    Else
        fillCellWithFormula = arrayOfFormulas(typeOfFile)(3)
    End If
    
End Function
Private Sub checkIfAddOrderComment(Day As Day, cell)

    Dim rng As String
    Dim r As Range
    
    If Day.orderComment <> "" Then
    
        rng = Range(cell, cell).Address
        Range(rng).AddComment Day.orderComment
        Range(rng).comment.Shape.Height = Day.commentHeight
        Range(rng).comment.Shape.width = 400
        Range(rng).comment.Shape.TextFrame.Characters.Font.Size = 8.5
        
    End If
    
End Sub

'***called by createTemplate***
'checking the value of order, grossRe or delivery
'param1: val AS String
'return val As String or Integer
Private Function check(val)
    If val = "-" Then
        check = 0
    Else
        check = val

    End If
End Function

'***called by createTemplate***
'creating column headers
Private Sub createLeftColumnHeaders()

    With shResult
    
        .Range("B4").value = "PART"
        .Range("C4").value = "Plant Code"
        .Range("D4").value = "Plant Name"
        .Range("E4").value = "Part Name"
        .Range("F4").value = "Supplier"
        .Range("G4").value = "Resp"
        .Range("H4").value = "Comment#1"
        .Range("I4").value = "Comment#2"
        .Range("J4").value = "FIRST RUNOUT"
        .Range("K4").value = "Backlog"
        .Range("L4").value = "BIP"
        .Range("M4").value = "Hazards"
        .Range("N4").value = "Stock"
        .Range("O4").value = "Recv"
        
    End With
    
End Sub
'***called by createTemplate***
'creating headers structure for each day
'param1: daysCount As Integer
Private Sub createRightColumnsHeaders(daysCount)

    Dim offsetVal As Integer
    offsetVal = 0
    
    Dim monthDayInEng As String
    Dim beginningDate As Date
    Dim Settimane As Integer
    
    beginningDate = earliestDate
    
    For I = 1 To daysCount + 1
        
        With shResult
        
                'changing day name to english
                monthDayInEng = WorksheetFunction.text(beginningDate, "[$-409]dddd")
                Settimane = WorksheetFunction.WeekNum(beginningDate, vbMonday) - 1
                
                .Cells(4, (GLOBALS.RQMColNr + offsetVal)).value = "RQM"
                .Cells(4, (GLOBALS.ORDERColNr + offsetVal)).value = "ORDER"
                .Cells(4, (GLOBALS.DELIVERYColNr + offsetVal)).value = "DELIVERY"
                .Cells(4, (GLOBALS.BALANCEColNr + offsetVal)).value = "BALANCE"
                .Cells(2, (GLOBALS.CWColNr + offsetVal)).value = "CW"
                .Cells(3, (GLOBALS.DateColNr + offsetVal)).value = beginningDate
                
                'Monthday i Settimane sa do wycofania z Adaptera, bo bêd¹ liczone tutaj lokalnie
                .Cells(3, (GLOBALS.DayColNr + offsetVal)).value = monthDayInEng
                .Cells(2, (GLOBALS.WeekNrColNr + offsetVal)).value = Settimane
                  
                beginningDate = DateAdd("d", 1, beginningDate)
    
                offsetVal = offsetVal + 4
            
        End With
            
       
    Next
End Sub
'creating the fonts, gridlines, background colors on Fire Flake code components basis
Private Sub createTheLayout()

    Set layout = New TheLayout
    
    Dim startingRange As Range
    Set startingRange = shResult.Range("B4")
    
    With layout
         sthandler.progress_increase
        .addDayNamesAndMergeTopDateRows shResult.Range("A3").End(xlToRight)
        .adjustLabelRow startingRange
        sthandler.progress_increase
        .colourFontsOnOtherThanBalanceColumns startingRange.Offset(0, 1)
    End With
    
    RunOnSelectionChangeModule.recalcLayoutAndColors shResult, Range("B4")
    
    FirstRunoutModule.firstRunoutFormulaFilling ActiveSheet, Range("B4")
    
    sthandler.progress_increase
    sthandler.hide
    

    
End Sub
