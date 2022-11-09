import type {AdapterProp} from "../types/Types"
import {Adapter} from "../Adapters/Adapter"
  /**
   * In multi file type, there is no plant code and plant name fileds
   * Multi Adapter, describes Multi sheet main columns
   */
  export class MultiAdapter extends Adapter {
    /**
     *@param args represents all Adapter class fields and stock
     */
      constructor(args: AdapterProp) {
        super(args)
        this.stock = args["stock"]
      }
    }