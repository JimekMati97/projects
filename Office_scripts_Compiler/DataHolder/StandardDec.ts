import type { SingleSheet } from "../types/Types"
import {AbcDecorator} from "./AbcDecorator"
import { Adapter } from "../Adapters/Adapter"
import { MultiAdapter } from "../Adapters/MultiAdapter"
import { SingleAdapter } from "../Adapters/SingleAdapter"
import { FFAdapter } from "../Adapters/FFAdapter"
  /**
   * StandardDec
   * Common behaviour of creating adapters for sheet types: Single,Multi and fireFlake
   */

   export class StandardDec extends AbcDecorator {
    /**
     * @param arrayOfAdaptersasAndSheet - first element is an ampty array where Adapters objects will be pushed, second is a matrix source sheet. Method recognices what type of Adapter create. Add him into an array
     * @returns data with information about how many adapters we have, what type they are, stores information about few first column values from source sheet like partName, partNumber, supplierName, dependly of a sheet type
     */
    createAdapters(arrayOfAdaptersasAndSheet: [Adapter[], SingleSheet]): [Adapter[], SingleSheet] {
      
      let localArray: [Adapter[], SingleSheet] = arrayOfAdaptersasAndSheet
      const resultSheetName:string=arrayOfAdaptersasAndSheet[0][0].resultSheet
  
      for (let row = localArray[1].firstRowNr; row <= localArray[1].rowNr - 1; row += localArray[1].modulo) {
  
        //stores a current row taken from matrix data:SingleSheet
        let cRow: string[] = localArray[1].cellValues[row]
  
       // let singleAdapterProp: AdapterProp;
        let adapter: Adapter
  
        //constructing adapter
        switch (localArray[1].modulo) {
  
          case 7:
            adapter = new MultiAdapter({ partNumber: cRow[1], partName: cRow[2], supplierName: cRow[4], stock: cRow[9], backlog: cRow[15], typeOfFile: "Multi", sheetName: resultSheetName })
            break
          case 8:
            let splitPlantCodeAndPlantName = () => (cRow[2].match(/(\w+)\s?-\s?([\w\s]+)/) == null) ? ["", ""] : [cRow[2].match(/(\w+)\s?-\s?([\w\s]+)/)[1], cRow[2].match(/(\w+)\s?-\s?([\w\s]+)/)[2]]
            let plantNameAndCode: string[] = splitPlantCodeAndPlantName()
  
            adapter = new SingleAdapter({ partNumber: cRow[0], partName: cRow[1], plantName: plantNameAndCode[1], plantCode: plantNameAndCode[0], supplierName: cRow[4], backlog: cRow[7], typeOfFile: "Single", sheetName: resultSheetName })
            break
          case 1:
            adapter = new FFAdapter({ partNumber: cRow[1], partName: cRow[4], plantName: cRow[3], plantCode: cRow[2], supplierName: cRow[5], backlog: cRow[10], typeOfFile: "FF", resp: cRow[6], comment1: cRow[7], comment2: cRow[8], bip: cRow[11], hazards: cRow[12], stock: cRow[13], recev: cRow[14], sheetName: resultSheetName })
            break
  
        }
        localArray[0].push(adapter)
      }
      return localArray
    }
    /**
     * @returns an array, which first elemnt is an array filled with Adapter objects and second is a source sheet with matrix data from excel cells
     */
    getArrayOfAdapters(): [Adapter[], SingleSheet] {
      return this.createAdapters(this.opr.getArrayOfAdapters())
    }
  }