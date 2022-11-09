import type { SingleSheet } from "../types/Types"
import {AbcDecorator} from "./AbcDecorator"
import { Adapter } from "../Adapters/Adapter"

  /**
   * FFGetCoverageDec
   * Fills properties of a FireFlake Day object, with coverage data
   */
   export class FFGetCoverageDec extends AbcDecorator {
    /**
     * @param arrayOfAdaptersWithDatesAndSourceSheet - has prepared data structure for filling Day objects with FireFlake coverge data. Also as a second element of an array is matrix sheet, which is source of coverage data
     */
    getCoverageData(arrayOfAdaptersWithDatesAndSourceSheet: [Adapter[], SingleSheet]): [Adapter[], SingleSheet] {
  
      let localArray: [Adapter[], SingleSheet] = arrayOfAdaptersWithDatesAndSourceSheet
      let parsedValues: string[][] = localArray[1].cellValues
      let rowNr: number = 0
  
      for (const adapter of localArray[0]) {
  
        let colNr: number = localArray[1].coverageBeginningColumn
        
        for (let dayNr = 0; dayNr <= adapter.scmData.length - 1; dayNr++) {
  
          adapter.scmData[dayNr].grossReq = adapter.tryConvertVal(parsedValues[4 + rowNr][colNr])
          adapter.scmData[dayNr].etaQty = adapter.tryConvertVal(parsedValues[4 + rowNr][colNr + 2])
          adapter.scmData[dayNr].delins = adapter.tryConvertVal(parsedValues[4 + rowNr][colNr + 1])
          adapter.scmData[dayNr].comment = ""
          adapter.scmData[dayNr].formula = localArray[1].cellFormulas[4 + rowNr][colNr + 3]
  
          colNr += 4
        }
  
        rowNr += 1
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