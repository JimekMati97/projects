import type {AdapterProp} from "../types/Types"
import {Day} from "../DataHolder/Day"
   /**
   * Adapter
   * Common atrributes of each sheet type
   */
 export abstract class Adapter {
    
    private readonly _partNumber: string
    private readonly _partName: string
    private readonly _supplierName: string
    private readonly _backlog: string
    private readonly _typeOfFile: string
    private _scmData: Day[]
    private _noSOHOinPreviousDays: boolean
    private _colNrWithStockCalc: number
    private _initialStock: string
    private readonly _resultSheet: string
    private _stock: string
  
    public get stock() {
      return this._stock
    }
  
    public set stock(value: string) {
      this._stock = value
    }
    public get colNrWithStockCalc() {
      return this._colNrWithStockCalc
    }
  
    public set colNrWithStockCalc(value: number) {
      this._colNrWithStockCalc = value
    }
    public get noSOHOinPreviousDays() {
      return this._noSOHOinPreviousDays
    }
  
    public set noSOHOinPreviousDays(value: boolean) {
      this._noSOHOinPreviousDays = value
    }
  
    public get partName() {
      return this._partName
    }
  
    public get partNumber() {
      return this._partNumber
    }
  
    public get supplierName() {
      return this._supplierName
    }
  
    public get backlog() {
      return this._backlog
    }
  
    public get initialStock() {
      return this._initialStock
    }
    public set initialStock(value: string) {
      this._initialStock = value
    }
    public get typeOfFile() {
      return this._typeOfFile
    }
  
    public get scmData() {
      return this._scmData
    }
    public set scmData(value: Day[]) {
      this._scmData = value
    }
    public get resultSheet() {
      return this._resultSheet
    }
  
  
    public tryConvertVal(value: string) {
  
      let newVal = value
  
      if (value) {
  
        if (value.includes(" ")) {
          //drop space from string which is a seperator in a digit
          const pattern = /\s/g
          let numberCleaned = value.replace(pattern, "")
          return numberCleaned

        } else if (value.includes(",")) {
          const pattern = /,/g
          let numberCleaned = value.replace(pattern, "")
          return numberCleaned
        }
      }
      if (isNaN(Number(newVal))) {
        return "0"
      }
      return value
    }
  
    /**
     * @param strDateFormat: has one or two dates. When sheet type is FireFlake there is no need to calculate the diffrence between current and next dates. However it should be done for Single and Multi sheet types, because the diffrences between current and next date may be not equal
     * @returns in case FF sheet formatted array storing one date. In case Single or Multi returns two dates, these will be later calculated in order to get diffrence in days between them
     */
    public convertStringToDate(strDateFormat: string[]) {
      //find digits in a string
      const pattern = /\D+/
      //has one or two dates
      let dates: Date[] = []
      strDateFormat.forEach((date) => {
  
        let matches = date.split(pattern)
        let digitsForDate: number[] = []
  
        for (const period of matches) {
          digitsForDate.push(Number(period))
        }
  
        //months are counted form 0 in JS
        digitsForDate[1] -= 1
  
        //generating new date instance based on parsed numbers
        let newDate: Date
        if (this.typeOfFile == "FF") {
          newDate = new Date(digitsForDate[0], digitsForDate[1], digitsForDate[2] + 1, -5, 0, 0, 0)
        } else {
          //setting 18 on a clock, to prevent Power Automate to jump one hour ahead of a time. new Date() sets deafult hour parameter to 23. Returned to power automate is later changed to 00:00:00, which also cause day change. 
          newDate = new Date(digitsForDate[2], digitsForDate[1], digitsForDate[0] + 1, -5, 0, 0, 0)
        }
  
  
        dates.push(newDate)
  
      })
  
      return dates
  
    }
    /**
     * private @param scmData: array that stores Date objects
     * private @param noSOHOinPreviousDays informs that stock has been not filled before
     * private @param colNrWithStockCalc column number where stock has been added
     * private @param partNumber
     * private @param partName
     * private @param supplierName
     * private @param backlog
     * private @typeOfFile : Single|Multi|FF
     * private @stock
     * private @resultSheet: new result sheet's name, where data will be paste
     */
    constructor(args:AdapterProp) {
      this.scmData = []
      this._partNumber = args["partNumber"]
      this._partName = args["partName"]
      this._supplierName = args["supplierName"]
      this._backlog = args["backlog"]
      this._typeOfFile = args["typeOfFile"]
      this.stock = args["stock"]
      this.noSOHOinPreviousDays = true
      this._resultSheet = args['sheetName']
    }
  }