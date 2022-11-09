import type { SingleSheet } from "../types/Types"
import {AbcDecorator} from "./AbcDecorator"
import { Adapter } from "../Adapters/Adapter"
  /**
   * MultiGetCoverageDec
   * Fills properties of a Multi sheet Day object, with coverage data
   */
   export class MultiGetCoverageDec extends AbcDecorator {
    /**
    * @param arrayOfAdaptersWithDatesAndSourceSheet - has prepared data structure for filling Day objects with Multifile coverge data. Also as a second element of an array is matrix sheet, which is source of coverage data
    */
      getCoverageData(arrayOfAdaptersAndDatesWithSourceSheet: [Adapter[], SingleSheet]): [Adapter[], SingleSheet] {
    
        let localArray: [Adapter[], SingleSheet] = arrayOfAdaptersAndDatesWithSourceSheet
        //definig row order of coverage
        const enum CoverageRows {
          SOHO = 3,
          RQM,
          RQM2,
          CONSUMATO,
          ETAQTY,
          CONSEGNATO,
          DELINS
        }
    
        let parsedValues: string[][] = localArray[1].cellValues
        let rowNr: number = 0
    
        for (const adapter of localArray[0]) {
          
          let colNr: number = 17
    
          for (let dayNr = 0; dayNr <= adapter.scmData.length - 1; dayNr++) {
    
            if ((parsedValues[CoverageRows.SOHO + rowNr][colNr] !== "0" && parsedValues[CoverageRows.SOHO + rowNr][colNr] !== "-" && parsedValues[CoverageRows.SOHO + rowNr][colNr] !== "" && adapter.noSOHOinPreviousDays) || (adapter.scmData[dayNr].firstStockInsertingPosition)) {
    
              adapter.noSOHOinPreviousDays = false
              adapter.colNrWithStockCalc = dayNr
    
              for (const adapter of localArray[0]) {
                adapter.scmData[dayNr].firstStockInsertingPosition = true
              }
              //setting stock on day level
              adapter.scmData[dayNr].stock = adapter.tryConvertVal(parsedValues[CoverageRows.SOHO + rowNr][colNr])
              
            } else {
    
              adapter.scmData[dayNr].firstStockInsertingPosition = false
              adapter.scmData[dayNr].stock = adapter.tryConvertVal(parsedValues[CoverageRows.SOHO + rowNr][colNr])
    
            }
    
    
            if (adapter.scmData[dayNr].firstDayInCol == false) {
    
              adapter.scmData[dayNr].grossReq = ""
              adapter.scmData[dayNr].consumato = ""
              adapter.scmData[dayNr].soho = ""
              adapter.scmData[dayNr].etaQty = ""
              adapter.scmData[dayNr].consegnato = ""
              adapter.scmData[dayNr].delins = ""
    
            }else {
    
              adapter.scmData[dayNr].grossReq = adapter.tryConvertVal(parsedValues[CoverageRows.RQM + rowNr][colNr])
              adapter.scmData[dayNr].consumato = adapter.tryConvertVal(parsedValues[CoverageRows.CONSUMATO + rowNr][colNr])
              adapter.scmData[dayNr].soho = adapter.tryConvertVal(parsedValues[CoverageRows.SOHO + rowNr][colNr])
              adapter.scmData[dayNr].etaQty = adapter.tryConvertVal(parsedValues[CoverageRows.ETAQTY + rowNr][colNr])
            adapter.scmData[dayNr].consegnato = adapter.tryConvertVal(parsedValues[CoverageRows.CONSEGNATO + rowNr][colNr])
              adapter.scmData[dayNr].delins = adapter.tryConvertVal(parsedValues[CoverageRows.DELINS + rowNr][colNr])
              colNr += 1
    
            }
          }
          rowNr += 7
        }
        return localArray
      }
    /**
    * @returns only first elemment of an array, which is array of fully prepared Adapter object containing fully prepared Day objects.
    */
     getArrayOfAdapters(): Adapter[]{
        return this.getCoverageData(this.opr.getArrayOfAdapters())[0]
      }
}