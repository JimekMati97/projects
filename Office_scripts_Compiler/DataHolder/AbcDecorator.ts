  import {Operation} from "../DataHolder//Operation"
  /**
   * AbcDecorator
   * Abstract class for all inherited by all concrete decorator classes
   * It has an Operation instance and at the same time is an Operation
   */
   export abstract class AbcDecorator extends Operation {
    public opr: Operation
    /**
     * @param opr:Operation - represents particular scenario for modifing array of adapters
     */
    constructor(opr: Operation) {
      super()
      this.opr = opr
    }
    abstract getArrayOfAdapters()
  }