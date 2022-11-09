export class Day {
    private _stock: string
    private _grossReq: string
    private _consumato: string
    private _soho: string
    private _etaQty: string
    private _consegnato: string
    private _date: Date
    private _calendarWeek: string
    private _ebal: string
    private _compressedDays: number
    private _firstDayInCol: boolean
    private _delins: string  //ordered
    private _comment: string  //only ff
    private _formula: string  //only ff
    private _firstStockInsertingPosition: boolean
  
    /**
     *@private firstDayInCol it indicates if a day in merged columns is a first day of for example 7 days
     */
    constructor() {
      this._firstDayInCol = true
    }
    public get stock() {
      return this._stock
    }
    public set stock(value: string) {
      this._stock = value
    }
    public get grossReq() {
      return this._grossReq
    }
    public set grossReq(value: string) {
      this._grossReq = value
    }
    public get calendarWeek() {
      return this._grossReq
    }
    public set calendarWeek(value: string) {
      this._grossReq = value
    }
    public get consumato() {
      return this._consumato
    }
    public set consumato(value: string) {
      this._consumato = value
    }
    public get soho() {
      return this._soho
    }
    public set soho(value: string) {
      this._soho = value
    }
    public get etaQty() {
      return this._etaQty
    }
    public set etaQty(value: string) {
      this._etaQty = value
    }
    public get consegnato() {
      return this._consegnato
    }
    public set consegnato(value: string) {
      this._consegnato = value
    }
    public get ebal() {
      return this._ebal
    }
    public set ebal(value: string) {
      this._ebal = value
    }
    public get compressedDays() {
      return this._compressedDays
    }
    public set compressedDays(value: number) {
      this._compressedDays = value
    }
    public get firstDayInCol() {
      return this._firstDayInCol
    }
    public set firstDayInCol(value: boolean) {
      this._firstDayInCol = value
    }
    public get delins() {
      return this._delins
    }
    public set delins(value: string) {
      this._delins = value
    }
    public get formula() {
      return this._formula
    }
    public set formula(value: string) {
      this._formula = value
    }
    public get comment() {
      return this._comment
    }
    public set comment(value: string) {
      this._comment = value
    }
    public get date() {
      return this._date
    }
    public set date(value: Date) {
      this._date = value
    }
    public get firstStockInsertingPosition() {
      return this._firstStockInsertingPosition
    }
    public set firstStockInsertingPosition(value: boolean) {
      this._firstStockInsertingPosition = value
    }
  }