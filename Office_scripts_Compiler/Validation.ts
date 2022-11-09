import type {ValSheet,ExcelTemplateValues} from "./types/Types"
  /**
   * Represents Currenlty opened Excel workbook, passed by Power Automatem getfiles()
   */
  class ActiveWorkbook {
  
      private activeWb: ExcelScript.Workbook
      private chosenSh: string
      private resultSheetName:string
      //value of Range(A3)
      private a3Value:string|number|boolean
  
    /**
     *
     * @param wb - currnet active workbook
     * @param sh - sheet name of the workbook, pass by Power Automate
     *
     */
    constructor(wb: ExcelScript.Workbook, sh: string) {
          this.activeWb = wb
          this.chosenSh = sh
      }
      
      /**
       * @returns basic inforamtion about a sheet: sheet's name, sheet's type, last row and column number,all cell values in string type from used range, diffrence between filled rows, beggining coverage column, EBal formulas (if it's Fire Flake type)
       * 
       */
      public validateSheet(): string {
  
          const sheetExcel: ExcelScript.Worksheet = this.activeWb.getWorksheet(this.chosenSh)
          //getting value of a3Value Cell
          this.a3Value = sheetExcel.getRange("A3").getValue()
  
          let matrixArray: ExcelTemplateValues
          //properly validated sheet or information about failure
          let validatedSheet:ValSheet|string;
  
          //recognizing sheet type
          if (this.a3Value == "Cod. P/N" || this.a3Value =="P/N Code"){
                //calling function with single article row range number
                matrixArray = this.createExcelTemplate(8)
                validatedSheet={ sourceSheet: this.chosenSh, sheetType: "single", colNr: matrixArray[1], rowNr: matrixArray[2],cellValues: matrixArray[0], modulo: 8, coverageBeginningColumn: 12,firstRowNr:3}
              }
              else if (this.a3Value == "MRP"){      
              matrixArray = this.createExcelTemplate(7)
                validatedSheet = { sourceSheet: this.chosenSh, sheetType: "multi", colNr: matrixArray[1], rowNr: matrixArray[2], cellValues: matrixArray[0], modulo: 7, coverageBeginningColumn: 18, firstRowNr: 3}
              }
              else if (this.a3Value == "" && sheetExcel.getRange("B4").getValue()=="PART"){
                matrixArray = this.createExcelTemplate(1)
                validatedSheet = { sourceSheet: this.chosenSh, sheetType: "ff", colNr: matrixArray[1], rowNr: matrixArray[2], cellValues: matrixArray[0], modulo: 1, coverageBeginningColumn: 15, cellFormulas: matrixArray[3], firstRowNr: 4}
              }else{
    
                validatedSheet = "Fail standard"
  
              }
              //return fail standard in case of string type variable or change type to string if it's an ValSheet type
            return (typeof(validatedSheet)!=="string")?JSON.stringify(validatedSheet):validatedSheet
                
            }
  
  
    /**
     * Gets all values from cells, formulas and max row, column index numbers (limited to only 250 article numbers)
     * @returns values:ExcelTemplateValues
     */
    private createExcelTemplate(rowRangeNr:number): ExcelTemplateValues|null {
  
      let usedRange = this.activeWb.getWorksheet(this.chosenSh).getUsedRange()
      if(usedRange!==undefined){
        //specify last row  and column length
        const rowCount: number = (((usedRange.getRowCount()-3) / rowRangeNr) >= 225) ? (225*rowRangeNr)+3 : usedRange.getRowCount()
        
        const columnCount: number = usedRange.getColumnCount()
  
        const cellValues: string[][] = usedRange.getTexts()
        let formulas: string[][];
  
        if (this.a3Value == "") {
          formulas = usedRange.getFormulas()
        }
  
        let values: ExcelTemplateValues = [cellValues, columnCount, rowCount, formulas]
        return values
      }
      return null
  
    }
  
  }
  /**
   * Validates worksheet, recognices it's type: FireFlake|Single Plant|Multi Plant
   * @param workbook
   * @param sh: name of the sheet passed by Power Automate
   * @returns all cell values of used range, main information describing a sheet.
   */
  function main(workbook: ExcelScript.Workbook, sh: string) {
      sh = sh//For Power Automate purpose
  
      //init result sheet
      const awb = new ActiveWorkbook(workbook, sh)
      return awb.validateSheet()
  }
  
  
  
  
  