
/**
 * DateBlock
 * Stores info about sheet's column index which indcates his location. Delivers info about date, concrete cell where date is inserted on a sheet
 */
export class DateBlock {
    
    public currentDate: Date
    private actualColumnNr: number
    private cell: ExcelScript.Range
    public resultSheetName: string

    constructor(currentDate, actualColumnNr, resultSheetName: string) {
        this.actualColumnNr = actualColumnNr
        this.currentDate = currentDate
        this.resultSheetName = resultSheetName
        this.cell = wb.getLastWorksheet().getCell(1, this.actualColumnNr)
        this.fillWithData()
    }
    public fillWithData() {
        this.cell.setValue("CW:")
        this.cell.getOffsetRange(1, 0).setValue(this.formatDate(this.currentDate))//eliminate parameter
        this.cell.getOffsetRange(0, 1).setValue(this.calcCW())
        this.cell.getOffsetRange(1, 3).setValue(this.getNameOfDay())
        this.cell.getOffsetRange(2, 0).setValue("RQM")
        this.cell.getOffsetRange(2, 1).setValue("ORDER")
        this.cell.getOffsetRange(2, 2).setValue("DELIVERY")
        this.cell.getOffsetRange(2, 3).setValue("BALANCE")
    }
    /**
     * @returns stringified valid date format with - as delimiter 
     */
    private formatDate(date: Date):string {

      return [
        this.pad2Place(date.getFullYear()),
        this.pad2Place(date.getMonth() + 1),
        this.pad2Place(date.getDate())
      ].join("-")
    }

    /**
     * @returns number of calendar week
     * substract time that passed till 1st Jan from time passed till particular date.
     */
    private calcCW():number {

        let oneJan:Date = new Date(this.currentDate.getFullYear(), 0, 1);
        const numberOfDays:number = Math.floor((Number(this.currentDate) - Number(oneJan)) / (24 * 60 * 60 * 1000));
        const result:number = Math.ceil((numberOfDays - 1) / 7);
        return result
    }
    /**
     * @returns name of a day in english
     */
    private getNameOfDay():string {
        return this.currentDate.toLocaleDateString("en-EN", { weekday: 'long' });
    }
    /**
     * @returns days and months in format 00-00
     * adds 0 at the beggining of a string till it's length is equal to 2
     */
    private pad2Place(timePeriod: number):string {
        return timePeriod.toString().padStart(2, '0')
    }

    //merging cells, bolding borders, aligning text, horizpntal and vertical transformations 
    public decorate() {
        //merging cells
        wb.getActiveWorksheet().getRange(this.cell.getOffsetRange(0, 1).getAddressLocal() + ":" + this.cell.getOffsetRange(0, 3).getAddressLocal()).merge(false)
        //merging cells of second row
        wb.getActiveWorksheet().getRange(this.cell.getOffsetRange(1, 0).getAddressLocal() + ":" + this.cell.getOffsetRange(1, 2).getAddressLocal()).merge(false)
        //aligning to left date
        this.cell.getOffsetRange(1, 0).getFormat().setHorizontalAlignment(ExcelScript.HorizontalAlignment.left)
        this.cell.getOffsetRange(0, 1).getFormat().setHorizontalAlignment(ExcelScript.HorizontalAlignment.left)
        wb.getActiveWorksheet().getRange(this.cell.getOffsetRange(2, 0).getAddressLocal() + ":" + this.cell.getOffsetRange(2, 3).getAddressLocal()).getFormat().setTextOrientation(90)

    }
}