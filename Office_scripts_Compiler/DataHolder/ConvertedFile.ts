import type {SingleSheet} from "../types/Types"
import {Adapter} from "../Adapters/Adapter"
import {Operation} from "../DataHolder/Operation"
import {ScmMultiGetDatesDec} from "../DataHolder/ScmMultiGetDatesDec"
import {StandardDec} from "../DataHolder/StandardDec"
import {EmptyArray} from "../DataHolder/EmptyArray"
import {FFGetDatesDec} from "../DataHolder/FFGetDatesDec"
import {ScmGetCoverageDec} from "../DataHolder/ScmGetCoverageDec"
import {MultiGetCoverageDec} from "../DataHolder/MultiGetCoveDec"
import {FFGetCoverageDec} from "../DataHolder/FFGetCoverageDec"
  
  /**
   * Choose a factory based on type of the sheet and create Adapters, calculate dates, retrive Coverage data
   * @param parsedSheetObj - SingleSheet equal to ValidSheet type from Validation script. 
   * @returns adapted structure to Fire Flake
   */
   export class ConvertedFile {
    public parsedSheet: SingleSheet
    public arrayOfAdapters: Adapter[] = []
    /**
     * @param parsedSheet:SingleSheet - is a 2dim array that has all cell values(string) of used range in source sheet
     */
    constructor(parsedSheet: SingleSheet) {
      this.parsedSheet = parsedSheet
      this.chooseDecorators()
    }
    /**
     * Make possible to choose a propper buliding procces. 
     * Based on row height of single article number from parsedSheet it decides what type of decorators use to achive
     * an adapted data structure for to FireFlake standard
     */
    private chooseDecorators() {
  
      let convertedFile: Operation;
  
      //choosing type of adapter production procedure based on worksheet's type
      if (this.parsedSheet.modulo == 8) {
        convertedFile = new ScmGetCoverageDec(new ScmMultiGetDatesDec(new StandardDec(new EmptyArray(this.parsedSheet))))
      } else if (this.parsedSheet.modulo == 7) {
        convertedFile = new MultiGetCoverageDec(new ScmMultiGetDatesDec(new StandardDec(new EmptyArray(this.parsedSheet))))
      } else if (this.parsedSheet.modulo == 1) {
        convertedFile = new FFGetCoverageDec(new FFGetDatesDec(new StandardDec(new EmptyArray(this.parsedSheet))))
  
      }
      this.arrayOfAdapters = convertedFile.getArrayOfAdapters()
  
      if (this.parsedSheet.modulo == 8) {
        this.calculateInitialStock(1)
      } else if (this.parsedSheet.modulo == 7) {
  
        this.calculateInitialStock(0)
      }
  
    }
    public calculateInitialStock(subParam) {
      //return 2
      for (const adapter of this.arrayOfAdapters) {
  
        for (let day = 0; day <= adapter.scmData.length - 1; day += 1) {
          if (adapter.scmData[day].firstStockInsertingPosition) {
  
            let initialStock = this.setInitialStock(adapter, Number(adapter.scmData[day].stock), day, subParam)
  
            adapter.initialStock = String(initialStock)
  
            break;
          }
  
        }
      }
    }
    private setInitialStock(adapter, stock, day, subParam) {
  
      let firstDayInLoop: boolean = true
      let initialStock: number = Number(stock);
      // console.log(initialStock)
  
      while (day >= subParam) {
  
        if ((subParam == 0) && (firstDayInLoop)) {
          firstDayInLoop = false
          let rqm: string = adapter.scmData[day - subParam].grossReq
          let delivery: string = adapter.scmData[day - subParam].etaQty
  
          // initialStock = Number(stock) - Number(delivery) + Number(rqm)
          initialStock -= (Number(delivery) - ((Number(rqm) - Number(adapter.scmData[day - subParam].consumato) < 0) ? 0 : (Number(rqm) - Number(adapter.scmData[day - subParam].consumato))))
          // console.log(initialStock,rqm)
        } else {
  
          let conseganto: string = adapter.scmData[day - subParam].consegnato
          let consumato: string = adapter.scmData[day - subParam].consumato
          // console.log(conseganto,consumato)
          initialStock -= (Number(conseganto) - Number(consumato))
  
        }
        day -= 1
      }
      // console.log(initialStock)
  
      return initialStock
  
    }
  
  }