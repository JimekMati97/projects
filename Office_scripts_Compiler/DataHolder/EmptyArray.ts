import type {SingleSheet} from "../types/Types"
import {Operation} from "./Operation"
  /**
   * EmptyArray
   * Empty array prepares  place for storing adapters
   */
   export class EmptyArray extends Operation {
    private parsedSheet: SingleSheet
    constructor(parsedSheetObj: SingleSheet) {
      super()
      this.parsedSheet = parsedSheetObj
    }
    /**
     *@returns array of empty array - used later by adapters and source sheet
     */
    getArrayOfAdapters():[[],SingleSheet]{
      return [[], this.parsedSheet]
    }
  }