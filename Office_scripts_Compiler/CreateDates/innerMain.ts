import {DateProcedure} from "./DateProcedure"
import type { Adapter } from "../types/Types"

//current ExcelWorkbook
let wb: ExcelScript.Workbook
/**
 * @param workbook - current workbook
 * @param strOfAdapters - stringified collection of Adapter objects passed by Power Automate from DataHolder script.
 * Droping date headers on a result sheet:CW, date,  day name
 * Adding column headers for Adapter properties
 * Styling and formatting date blocks
 */
function main(workbook: ExcelScript.Workbook, strOfAdapters: string):string {
    
    wb = workbook
    
    const parsedAdapters: Adapter[] = JSON.parse(strOfAdapters)
 
    let procedureOfDate = new DateProcedure(parsedAdapters)

    let allDates: Date[] = procedureOfDate.gatDatesFromDateBlocks()
   
    return JSON.stringify(allDates)
}



