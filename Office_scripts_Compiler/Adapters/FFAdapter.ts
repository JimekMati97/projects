import type {AdapterProp} from "../types/Types"
import {Adapter} from "../Adapters/Adapter"
  /**
   * Fire Flake Adapter
   * Cover all Fire Flakes columns,
   * Has info about comments columns, receiving, bip and hazards
   */
  export class FFAdapter extends Adapter {
    //fields visible only in FF
    readonly resp: string
    readonly comment1: string
    readonly comment2: string
    readonly bip: string
    readonly hazards: string
    readonly recev: string
    readonly plantCode: string
    readonly plantName: string
  
  /**
   *@param args represents all Adapter class fields and plant's name anc code
   * There are also fields charactersitic only for FireFlake sheet standard: bip, comments, resp, hazrds,recev
   */
    constructor(args: AdapterProp) {
      super(args)
      this.plantCode = args["plantCode"]
      this.plantName = args["plantName"]
      this.bip = args["bip"]
      this.comment1 = args["comment1"]
      this.comment2 = args["comment2"]
      this.resp = args["resp"]
      this.stock = args['stock']
      this.hazards = args["hazards"]
      this.recev = args["recev"]
    }
  
  }