import type { SingleSheet } from "../types/Types"
import {AbcDecorator} from "./AbcDecorator"
import { Adapter } from "../Adapters/Adapter"
import {Day} from "../DataHolder/Day"
  /**
   * FFGetDatesDec
   * Add to each Adapter object's property scmData an array of Day instances
   * In the Fireflake case, data are simply "read" from a sheet 
   */
   export class FFGetDatesDec extends AbcDecorator {
    /**
     * @param arrayOfAdaptersAndSource - has a source sheet of data and an array of Adapter object
     * @returns an array of Adapter objects each having scmData array of Day objects.
     * Prepares time range based on date range from source sheet. Each Day object will have information about coverage of a particular day
     */
    getDates(arrayOfAdaptersAndSource: [Adapter[], SingleSheet]): [Adapter[], SingleSheet] {
  
      let localArray: [Adapter[], SingleSheet] = arrayOfAdaptersAndSource
      let firstColNr: number = localArray[1].coverageBeginningColumn
     
      for (const adapter of localArray[0]) {
        for (let colNr = firstColNr; colNr <= localArray[1].colNr - 1; colNr += 4) {
  
          let dayObj = new Day()
          let dateValue: Date = adapter.convertStringToDate([localArray[1].cellValues[2][colNr]])[0]
          let calendarWeek: string = localArray[1].cellValues[1][colNr + 1]
  
          dayObj.calendarWeek = calendarWeek
          dayObj.date = dateValue
  
          adapter.scmData.push(dayObj)
        }
  
      }
      return localArray
    }
    /**
     * @returns array of Adapter objects with each having collection of Day objects
     */
    getArrayOfAdapters(): [Adapter[], SingleSheet] {
      return this.getDates(this.opr.getArrayOfAdapters())
    }
  }