import type { SingleSheet } from "../types/Types"
import {AbcDecorator} from "./AbcDecorator"
import { Adapter } from "../Adapters/Adapter"
 /**
   * ScmGetCoverageDec
   * Fills properties of a Singe sheet Day objects, with coverage data
   */
   export class ScmGetCoverageDec extends AbcDecorator {
    /**
    * @param arrayOfAdaptersWithDatesAndSourceSheet - has prepared data structure for filling Day objects with Scmfile coverge data. Also as a second element of an array is matrix sheet, which is source of coverage data
    */
      getCoverageData(arrayOfAdaptersWithDatesAndSheet: [Adapter[], SingleSheet]): [Adapter[], SingleSheet] {
    
        let localArray: [Adapter[], SingleSheet] = arrayOfAdaptersWithDatesAndSheet
        //definig row order of coverage
        const enum CoverageRows {
          STOCK_PLANT = 3,
          RQM,
          CONSUMATO,
          SOHO,
          ETAQTY,
          EBAL,
          CONSEGNATO,
          DELINS
        }
    
        let parsedValues: string[][] = localArray[1].cellValues
        let rowNr: number = 0
    
        for (const adapter of localArray[0]) {
        
          let colNr: number = 12
    
          for (let dayNr = 0; dayNr <= adapter.scmData.length - 1; dayNr += 1) {
    
    
            if (((parsedValues[CoverageRows.STOCK_PLANT + rowNr][colNr] !== "0" && parsedValues[CoverageRows.STOCK_PLANT + rowNr][colNr] !== "" && parsedValues[CoverageRows.STOCK_PLANT + rowNr][colNr] !== "-") && (adapter.noSOHOinPreviousDays)) || (adapter.scmData[dayNr].firstStockInsertingPosition)) {
    
              adapter.noSOHOinPreviousDays = false
              adapter.colNrWithStockCalc = dayNr
    
              for (const adapter of localArray[0]) {
                adapter.scmData[dayNr].firstStockInsertingPosition = true
              }
              //setting stock on day level
              adapter.scmData[dayNr].stock = adapter.tryConvertVal(parsedValues[CoverageRows.STOCK_PLANT + rowNr][colNr])
    
              //if stock exists bind it with stock on adapter level
              adapter.stock = adapter.scmData[dayNr].stock
            } else {
              adapter.scmData[dayNr].firstStockInsertingPosition = false
              adapter.scmData[dayNr].stock = adapter.tryConvertVal(parsedValues[CoverageRows.STOCK_PLANT + rowNr][colNr])
    
            }
    
            if (adapter.scmData[dayNr].firstDayInCol == false) {
    
              adapter.scmData[dayNr].stock = ""
              adapter.scmData[dayNr].grossReq = ""
              adapter.scmData[dayNr].consumato = ""
              adapter.scmData[dayNr].soho = ""
              adapter.scmData[dayNr].etaQty = ""
              adapter.scmData[dayNr].ebal = ""
              adapter.scmData[dayNr].consegnato = ""
              adapter.scmData[dayNr].delins = ""
    
            } else {
    
              adapter.scmData[dayNr].grossReq = adapter.tryConvertVal(parsedValues[CoverageRows.RQM + rowNr][colNr])
              adapter.scmData[dayNr].consumato = adapter.tryConvertVal(parsedValues[CoverageRows.CONSUMATO + rowNr][colNr])
              adapter.scmData[dayNr].soho = adapter.tryConvertVal(parsedValues[CoverageRows.SOHO + rowNr][colNr])
              adapter.scmData[dayNr].etaQty = adapter.tryConvertVal(parsedValues[CoverageRows.ETAQTY + rowNr][colNr])
              adapter.scmData[dayNr].ebal = adapter.tryConvertVal(parsedValues[CoverageRows.EBAL + rowNr][colNr])
              adapter.scmData[dayNr].consegnato = adapter.tryConvertVal(parsedValues[CoverageRows.CONSEGNATO + rowNr][colNr])
              adapter.scmData[dayNr].delins = adapter.tryConvertVal(parsedValues[CoverageRows.DELINS + rowNr][colNr])
    
              colNr += 1
            }
    
          }
          rowNr += 8
          //}
        }
        return localArray
      }
      /**
      * @returns only first elemment of an array, which is array of fully prepared Adapter object containing fully prepared Day objects.
      */
      getArrayOfAdapters(): Adapter[] {
        return this.getCoverageData(this.opr.getArrayOfAdapters())[0]
      }
    }