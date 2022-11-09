import type { SingleSheet } from "../types/Types"
import { Adapter } from "../Adapters/Adapter"
import { ConvertedFile } from "../DataHolder/ConvertedFile"
  /**
   * Takes data from a worksheet and arranges it into a data collection
   * @param workbook
   * @param strOfValidatedSheets:validated workseets put into an array by Power Automate
   * @returns a data collection adapted to a fireflake spreadsheet
   */
  
  let resultSheetName: string
  function main(workbook: ExcelScript.Workbook, strOFArray: string) {
  
    let resultSheet: ExcelScript.Worksheet = workbook.addWorksheet();
    resultSheetName = resultSheet.getName()
  
    let collectionOfConvertedData: Adapter[] = [];
    const parsedArray:string[]=JSON.parse(strOFArray)
    for (const parsedSheetObj of parsedArray) {
  
      const singlSheetparsedSheetObj: SingleSheet = JSON.parse(parsedSheetObj)
  
      let converteFile: ConvertedFile = new ConvertedFile(singlSheetparsedSheetObj)
      
      let convertedDataFromONeSheet: Adapter[] = converteFile.arrayOfAdapters
  
      collectionOfConvertedData.push(...convertedDataFromONeSheet)
  
    }
    return JSON.stringify(collectionOfConvertedData)
 
  }








  