import type {AdapterProp} from "../types/Types"
import {Adapter} from "../Adapters/Adapter"
  /**
   * SingleAdapter
   * Scm Scheet type
   * Adds plant's name and plant's code to abstract Adapter properties
   */
export class SingleAdapter extends Adapter {
    //public stock: string //only visible in multi file
  
    private readonly _plantName: string
    private readonly _plantCode: string
  
    public get plantName() {
      return this.plantName
    }
    public get plantCode() {
      return this.plantCode
    }
    /**
     *@param args represents all Adapter class fields and plant's name anc code 
     */
    constructor(args: AdapterProp) {
      super(args)
      this._plantName = args["plantName"]
      this._plantCode = args["plantCode"]
  
    }
  }