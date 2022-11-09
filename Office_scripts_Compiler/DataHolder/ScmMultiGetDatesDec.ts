import type { SingleSheet } from "../types/Types"
import {AbcDecorator} from "./AbcDecorator"
import { Adapter } from "../Adapters/Adapter"
import {Day} from "../DataHolder/Day"
  /**
   * ScmMultiGetDatesDec
   * Add to each Adapter object's property scmData an array of Day instances
   * In the Fireflake case, data are simply "read" from a sheet and the diffrence between days is alwayes equal 1, however for Single and multi sheets that diffrence should be calculated
   */
   export class ScmMultiGetDatesDec extends AbcDecorator {
   
    /**
   * @param arrayOfAdaptersAndSource - has a source sheet of data and an array of Adapter object
   * @returns an array of Adapter objects each having scmData array of Day objects.
   * Prepares time range based on date range from source sheet. Each Day object will have information about coverage of a particular day
   */
    getDates(arrayOfAdaptersAndSheet: [Adapter[], SingleSheet]): [Adapter[], SingleSheet] {
  
      let localArray: [Adapter[], SingleSheet] = arrayOfAdaptersAndSheet
      let firstColNr: number = localArray[1].coverageBeginningColumn
    
      for (const adapter of localArray[0]) {
        for (let colNr = firstColNr; colNr <= localArray[1].colNr; colNr++) {
               
          let dateDiff: number;
          let twoDates: Date[]
  
         //if it's last calnedar week in dates scope, then it schould not look up to a next calendar week   
          if (localArray[1].colNr - 1 == colNr - 1) {
  
            twoDates = adapter.convertStringToDate([localArray[1].cellValues[2][colNr - 1]])
            dateDiff = 7
          } else {
            
            twoDates = adapter.convertStringToDate([localArray[1].cellValues[2][colNr - 1], localArray[1].cellValues[2][colNr]])
            dateDiff = Math.ceil((twoDates[1].getTime() - twoDates[0].getTime()) / 1000 / 3600 / 24)
           
          }
  
          let calendarWeek: string = localArray[1].cellValues[0][colNr - 1]
  
          for (let i = 0; i <= dateDiff - 1; i++) {
  
            let dayObj = new Day()
            let copyDate: Date = new Date(Number(twoDates[0]))
            dayObj.date = new Date(copyDate.setDate(twoDates[0].getDate() + i))
            if (i >= 1) {
              dayObj.firstDayInCol = false
            }
  
            dayObj.calendarWeek = calendarWeek
            adapter.scmData.push(dayObj)
          }
        }
      }
      return localArray
    }
    getArrayOfAdapters() {
        return this.getDates(this.opr.getArrayOfAdapters())
      }
    
}