let wb:ExcelScript.Workbook

function main(workbook: ExcelScript.Workbook, resultSheetName:string) {
  wb=workbook
  let resultSheet: string = resultSheetName
  workbook.getWorksheet(resultSheet).activate()
  addColorFormattingOnEbal(resultSheet)
  addDateAndCountFilledRows(resultSheet)

  let eBalColsNr: number = workbook.getWorksheet(resultSheet).getUsedRange().getColumnCount()
  let rowEbalNr: number = workbook.getWorksheet(resultSheet).getUsedRange().getLastRow().getRowIndex()

  addTableBorders(eBalColsNr, rowEbalNr, resultSheet)
  
}
function addColorFormattingOnEbal(resultSheet:string) {
  //calculate number of ebal cols to fill with conditional formatting
  //first colNr of Ebal is 19
  let eBalColsNr: number = ((wb.getWorksheet(resultSheet).getUsedRange().getColumnCount() - 18) / 4) + 1

  let rowEbalNr: number = wb.getWorksheet(resultSheet).getUsedRange().getLastRow().getRowIndex() + 1

  // Get the range to format.
  const sheet = wb.getWorksheet(resultSheet);

  //stores addresses of selected ranges indicating each eBal column
  let arrayOfSelectedRanges: string[] = []
  for (let i = 0; i <= eBalColsNr - 1; i++) {

    let ratingRange: ExcelScript.Range = sheet.getRange("S5:S" + rowEbalNr).getOffsetRange(0, 4 * i);
    //trim name of the sheet and get only selected range:string
    // ratingRange.getAddressLocal().match(/!(.*)/) return an array. 
    //[0] is !xx:xx
    //[1] is xx:xx
    let rangeStr: string = ratingRange.getAddressLocal().match(/!(.*)/)[1]
    arrayOfSelectedRanges.push(rangeStr)

  }
  //all ranges that need to have cond. format. implemented (which are only eBal columns)
  let allRanges: ExcelScript.RangeAreas = sheet.getRanges(arrayOfSelectedRanges.join(","))
  // Add cell value conditional formatting.
  const cellValueConditionalFormatting =
    allRanges.addConditionalFormat(ExcelScript.ConditionalFormatType.cellValue).getCellValue();
  const cellValueConditionalFormatting2 =
    allRanges.addConditionalFormat(ExcelScript.ConditionalFormatType.cellValue).getCellValue();
  // Create the condition, in this case when the cell value is between 50 and 75.
  let ruleIfLessThan0: ExcelScript.ConditionalCellValueRule = {
    formula1: "0",
    operator: ExcelScript.ConditionalCellValueOperator.lessThan
  };
  let ruleIfEqualTo0: ExcelScript.ConditionalCellValueRule = {
    formula1: "0",
    operator: ExcelScript.ConditionalCellValueOperator.equalTo
  };
  cellValueConditionalFormatting.setRule(ruleIfLessThan0);
  cellValueConditionalFormatting2.setRule(ruleIfEqualTo0);

  // Set the format to apply when the condition is met.
  let format = cellValueConditionalFormatting.getFormat();
  format.getFill().setColor("red");

  let format2 = cellValueConditionalFormatting2.getFormat();
  format2.getFill().setColor("pink");
  // }
}

function addDateAndCountFilledRows(resultSheet:string){
  //number of articles viisble on a screen
  let compileNrArticles: number = wb.getWorksheet(resultSheet).getUsedRange().getRowCount()-4
  let date:Date=new Date()
  //all articles that should visible on a srcreen
  let articlesQty: number = Number(wb.getWorksheet(resultSheet).getRange("A1").getValue())
  //fill A1 cell with how many articles have been compiled properly
  wb.getWorksheet(resultSheet).getRange("A1").setValue(compileNrArticles+"/"+articlesQty+" articles compiled")
  wb.getWorksheet(resultSheet).getRange("A2").setValue(date.toLocaleString('pl-PL',{timeZone:"Europe/Warsaw"}))
}

function addTableBorders(eBalColsNr: number, rowEbalNr: number, resultSheet:string){
  for (let col = 1; col <= eBalColsNr-1; col += 1) {
    for (let row = 3; row <= rowEbalNr; row += 1) {
      let format = wb.getWorksheet(resultSheet).getCell(row, col).getFormat()
      format.getRangeBorder(ExcelScript.BorderIndex.edgeTop).setStyle(ExcelScript.BorderLineStyle.continuous); // Top border
      format.getRangeBorder(ExcelScript.BorderIndex.edgeBottom).setStyle(ExcelScript.BorderLineStyle.continuous); // Bottom border
      format.getRangeBorder(ExcelScript.BorderIndex.edgeLeft).setStyle(ExcelScript.BorderLineStyle.continuous); // Left border
      format.getRangeBorder(ExcelScript.BorderIndex.edgeRight).setStyle(ExcelScript.BorderLineStyle.continuous); // Right border
    }
  }
}