import {DateBlock} from './DateBlock';
import type {Adapter} from '../types/Types'

//creating date area in Fire Flake. Inserting of CW, formatted date(YYYY.mm.dd), 2 merged areas, CW number, day name
/**
 * DateProcedure
 * Calculates how many days should be visible on result sheet. Each day is represent by DateBlock, consisitng of CW nr. 
 */
export class DateProcedure {
    //has two dates : the latest one and earliest
    public rangeOfDates: Date[]
    public parsedAdapters: Adapter[]
    public dateBlocks: DateBlock[] = []

    /**
     * @param parsedAdapters - passing whole dataHolder script result
     */
    constructor(parsedAdapters:Adapter[]) {
        this.parsedAdapters = parsedAdapters
        this.calcRangeOfDates()
        this.createDates()
        this.createHeaders
        this.decorate()
    }
    /**
     * Calulates earliest and latest date of sheets dates
     * Sets two specific dates - first one in the date that is earliest among all validated sheets and second is the latest
     */
    private calcRangeOfDates() {

        let earliestDate: Date
        let latestDate: Date

        for (const adapter of this.parsedAdapters) {
            for (const day of adapter._scmData) {

                if (earliestDate == undefined) {
                    earliestDate = new Date(Date.parse(day._date))
                } else {
                    if (earliestDate > new Date(Date.parse(day._date))) {
                        earliestDate = new Date(Date.parse(day._date))
                    }
                }

                if (latestDate == undefined) {
                    latestDate = new Date(Date.parse(day._date))
                } else {
                    if (latestDate <= new Date(Date.parse(day._date))) {
                        latestDate = new Date(Date.parse(day._date))
                    }
                }
            }
        }
        this.rangeOfDates = [earliestDate, latestDate]
    }
    /**
     * Creates a group of information (DateBlock) for each day between two extreme dates (rangeOfdates)
     * Fills collection of date blocks
     */
    private createDates() {
      
        //date that is being incremented
        let currentDate: Date = this.rangeOfDates[0]

        const columnOffset = 4

        let actualColumnNr: number = 15
        //increment by 1 day till, aligning with latest date in time spectrum
        while (currentDate <= this.rangeOfDates[1]) {

            let block = new DateBlock(currentDate, actualColumnNr, this.parsedAdapters[0]._resultSheet)

            //block.fillWithData()

            //let date = new DateWithAddingFunction();
            //this code works fine, however is commmented, due to low performance of dynamic adding borders ---------IMPORTANT----------
            this.addBorders(actualColumnNr)
            //currentDate = date.addDays(currentDate, 1);

            //day incremented with 1
            const add1Day = () => new Date(currentDate.setDate(new Date(currentDate.setHours(2,0,0)).getDate()+1))
            currentDate=add1Day()
            
            actualColumnNr += columnOffset
            this.dateBlocks.push(block)
        }
    }
    private addBorders(eBalColsNr: number) {
        //starting column P(16)
        for (let col = 0; col <= 3; col += 1) {
            for (let row = 1; row <= 2; row += 1) {
                let format = wb.getWorksheet(this.parsedAdapters[0]._resultSheet).getCell(row, eBalColsNr + col).getFormat()
    
                format.getRangeBorder(ExcelScript.BorderIndex.edgeTop).setStyle(ExcelScript.BorderLineStyle.continuous); // Top border
                format.getRangeBorder(ExcelScript.BorderIndex.edgeBottom).setStyle(ExcelScript.BorderLineStyle.continuous); // Bottom border
                format.getRangeBorder(ExcelScript.BorderIndex.edgeLeft).setStyle(ExcelScript.BorderLineStyle.continuous); // Left border
                format.getRangeBorder(ExcelScript.BorderIndex.edgeRight).setStyle(ExcelScript.BorderLineStyle.continuous); // Right border
    
    
                format.getRangeBorder(ExcelScript.BorderIndex.edgeTop).setWeight(ExcelScript.BorderWeight.medium); // Top border
                format.getRangeBorder(ExcelScript.BorderIndex.edgeLeft).setWeight(ExcelScript.BorderWeight.medium); // Left border
                format.getRangeBorder(ExcelScript.BorderIndex.edgeRight).setWeight(ExcelScript.BorderWeight.medium); // Right 
            }
        }
    }
    /**
     * Creates column headers for non day data
     */
    private createHeaders() {

        const colHeaders = ["PART", "Plant Code", "Plant Name", "Part Name", "Supplier", "Resp", "Comment#1", "Comment#2", "FIRST RUNOUT",
            "Backlog", "BIP", "Hazards", "Stock", "Recv"]

        for (let colNr = 1; colNr <= 14; colNr++) {
            wb.getWorksheet(this.parsedAdapters[0]._resultSheet).getCell(3, colNr).setValue(colHeaders[colNr - 1])
        }

    }
    public gatDatesFromDateBlocks(){
        let allDates: Date[] = []

        for (let dateNr = 0; dateNr <= this.dateBlocks.length - 1; dateNr++) {
       
            allDates.push(this.dateBlocks[dateNr].currentDate)
    
        }

        return allDates
    }

    private decorate(){
        //this code enables merging cells, making headers vertically aligned ---------IMPORTANT----------
        for (const date of this.dateBlocks){
            date.decorate()
        }
    }
}