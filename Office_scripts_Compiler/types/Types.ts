export type Adapter = {
    _partNumber: string
    _partName: string
    _plantName?: string
    _plantCode?: string
    _supplierName: string
    _backlog: string
    _typeOfFile: string
    _stock?: string
    _resp?: string
    _bip?: string
    _comment1?: string
    _comment2?: string
    _recev?: string
    _hazards?: string
    _firstRunout?: string
    _scmData: Day[]
    _noSOHOinPreviousDays?: boolean
    _colNrWithStockCalc?: number
    _initialStock?: string
    _resultSheet?: string
}

export type Day = {
    _stock?: string//only visible in single type file
    _grossReq: string
    _consumato?: string
    _soho?: string
    _etaQty: string
    _consegnato?: string
    _date: string
    _calendarWeek?: string
    _ebal?: string
    _compressedDays?: number
    _firstDayInCol?: boolean
    _firstStockInsertingPosition?: boolean
    _delins: string  //ordered
    _comment?: string  //only ff
    _formula?: string  //only ff
}
  /*
   * Same as ValSheet type in Validation script
   * @param sheet: sheet's name
   * @param sheetType
   * @param colNr: last column number with data
   * @param rowNr: last row number with data
   * @param coverageBeginningColumn: first column number, where data with coverage start
   * @param modulo: row number diffrence between artciles - it's basically row weight of each article number
   * @param cellValues: 2-dimensional array -all cell values in string type from used range
   * @param [optional] cellFormulas: takes formulas from each cell in used range
   * @param firstRowNr: first row on source sheet, from which data are taken
   */
  
export type SingleSheet = {
    sourceSheet: string
    sheetType: string
    colNr: number
    rowNr: number
    coverageBeginningColumn: number
    modulo: number
    cellValues: string[][]
    cellFormulas?: string[][]
    firstRowNr: number
    resultSheet: string
  }


/**
 * @param partNumber
 * @param sheetType
 * @param partName
 * @param plantName:[opt.] only visible for FF and Single file types
 * @param plantCode:[opt.] only visible for FF and Single file types
 * @param supplierName
 * @param backlog:
 * @param typeOfFile:Single(Scm)|Multi(MultiSide)|FF(FireFlake)
 * @param stock:[opt.] It's a stock hat indicates stock value from PCV Export. For Multi it's visible in seperate column. For a Single it's visible in a separate row.
 * @param resp:[opt.]
 * @param bip:[opt.]
 * @param comment1:[opt.]
 * @param comment2: [opt.]
 * @param hazards:[opt.]
 * @param initialStock:[opt.] calculated stock for the past days. It's only usefull for Single and Multi files
 */

 export type AdapterProp = {
    partNumber: string
    partName: string
    plantName?: string
    plantCode?: string
    supplierName: string
    backlog: string
    typeOfFile: string
    stock?: string
    resp?: string
    bip?: string
    comment1?: string
    comment2?: string
    recev?: string
    hazards?: string
    initialStock?: string
    sheetName:string
  }
  /**
 * @param sheet: sheet's name
 * @param sheetType
 * @param colNr: last column number with data
 * @param rowNr: last row number with data
 * @param coverageBeginningColumn: first column number, where data with coverage start
 * @param modulo: row number diffrence between artciles - it's basically row weight of each article number
 * @param cellValues: 2-dimensional array -all cell values in string type from used range
 * @param [optional] cellFormulas: takes formulas from each cell in used range
 * @param firstRowNr: first row on source sheet, from which data are taken
 */
 export interface ValSheet {
    sourceSheet: string
    sheetType: string
    colNr: number
    rowNr: number
    coverageBeginningColumn: number
    modulo: number
    cellValues: string[][]
    cellFormulas?: string[][]
    firstRowNr:number
  }
  /**
   * custom type returned by createExcelTemplate()
   * cellValues, columnCount, rowCount, [opt.] formulas
   */
export  type ExcelTemplateValues = [
    string[][], 
    number,
    number,
    string[][]?
  ]