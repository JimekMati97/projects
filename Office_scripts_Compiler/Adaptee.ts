import type {Adapter} from "./types/Types"

let wb: ExcelScript.Workbook;

function main(workbook: ExcelScript.Workbook, strOfAdapters: string, dates: string) {

    wb = workbook

    let parsedAdapters: Adapter[] = JSON.parse(strOfAdapters)
    let parsedDates: string[] = JSON.parse(dates)
  let resultSheetName: string = parsedAdapters[0]._resultSheet

    //display current quantity of articles that should be visible on result sheet
    updateQtyOfArticles(parsedAdapters.length, resultSheetName)

    wb.getWorksheet(resultSheetName).activate()

    // //if thay were created function returns last row number filled with data. If sheet is empty boolean valye is returned
    let returnedValue: number = wb.getActiveWorksheet().getUsedRange().getLastRow().getRowIndex() + 1

    // return returnedValue
    addPartsInfo(parsedAdapters, parsedDates, returnedValue, resultSheetName)
    return resultSheetName
}
/**
 * Update 
 */
function updateQtyOfArticles(qty: number, resultSheetName: string) {
    let currentQuantity: number = Number(wb.getWorksheet(resultSheetName).getRange("A1").getValue())
    currentQuantity += qty
    wb.getWorksheet(resultSheetName).getRange("A1").setValue(currentQuantity)
}

function addPartsInfo(arrayOfAdapters: Adapter[], blockOfDates: string[], rowNumber: number, resultSheetName: string) {

    let colNr: number
    let rownNr: number = rowNumber
    let endOfPuttingComments: boolean
    let selectedSheet: ExcelScript.Worksheet = wb.getActiveWorksheet()

    const addCommemtsToStock = () => {

        for (let i = 0; i <= arrayOfAdapters.length - 1; i++) {
          if (arrayOfAdapters[i]._typeOfFile !== "FF") {
                wb.addComment(wb.getActiveWorksheet().getCell(rownNr + i, articleInfo["initialStock"]), "PCV Stock: " + arrayOfAdapters[i]["stock"])
            }

        }
    }

    addCommemtsToStock()

    const addCommentWithConsegnato = (colNr: number, rowNr: number, consegnato: string) => wb.addComment(wb.getActiveWorksheet().getCell(rownNr, colNr), "Already delivered: " + consegnato)


    for (const adapter of arrayOfAdapters) {
        endOfPuttingComments = false
        colNr = 1
        let innerDayCounter: number = 1
        //starts droping data on B5 cell
        for (const prop in adapter) {

            if (prop !== "_scmData" && prop !== "_typeOfFile" && prop !== "_colNrWithStockCalc" && prop !== "_noSOHOinPreviousDays" && prop !== "_stock" && prop !== "_initialStock" && prop !== "_resultSheet") {

                selectedSheet.getCell(rownNr, articleInfo[prop]).setValue(adapter[prop])
                colNr += 1

            } else if (prop == "_stock" || prop == "_initialStock") {
              if (adapter._typeOfFile == "Multi" || adapter._typeOfFile == "Single") {

                    selectedSheet.getCell(rownNr, articleInfo[prop]).setValue(adapter["_initialStock"])

                } else {
                    selectedSheet.getCell(rownNr, articleInfo[prop]).setValue(adapter["_stock"])
                }

            }
 
            else if (prop == "_scmData") {

                let colOfCov: number = 15
              //setting hours to 00:00:00, however in march time is reduced with 1 hours and date jumps ti previous day.
              let earliestDateInAdapter: Date = new Date(new Date(Date.parse(adapter._scmData[0]._date)).setHours(22, 0, 0))
              let latestDateInAdapter: Date = new Date(new Date(Date.parse(adapter._scmData[adapter._scmData.length - 1]._date)).setHours(22, 0, 0))

                let dayIdx: number = 0

                for (const date of blockOfDates) {

                    let parsedDate: Date = new Date(new Date(Date.parse(date)).setHours(22, 0, 0))
                    if ((parsedDate >= earliestDateInAdapter) && (parsedDate <= latestDateInAdapter)) {



                      wb.getActiveWorksheet().getCell(rownNr, colOfCov + 1).setValue(adapter._scmData[dayIdx]._delins)//sett Order
                        //putting consumato and consegnato or rqm logic
                      if (adapter._scmData[dayIdx]._firstStockInsertingPosition == false && adapter._typeOfFile !== "FF" && endOfPuttingComments == false) {

                            //
                          wb.getActiveWorksheet().getCell(rownNr, colOfCov).setValue(adapter._scmData[dayIdx]._consumato)//setting RQM
                          wb.getActiveWorksheet().addComment(wb.getActiveWorksheet().getCell(rownNr, colOfCov), "RQM: " + adapter._scmData[dayIdx]._grossReq + "\n" + "Consumato: " + adapter._scmData[dayIdx]._consumato)//setting RQM


                            //logic for putting only consegnato
                          if (Number(adapter._scmData[dayIdx]._consegnato) > 0) {
                            wb.getActiveWorksheet().getCell(rownNr, colOfCov + 2).setValue(adapter._scmData[dayIdx]._consegnato)
                              addCommentWithConsegnato(colOfCov + 2, rownNr, adapter._scmData[dayIdx]._consegnato)
                            } else {

                            wb.getActiveWorksheet().getCell(rownNr, colOfCov + 2).setValue(adapter._scmData[dayIdx]._etaQty)

                            }
                        } else {
                            endOfPuttingComments = true

                          wb.getActiveWorksheet().getCell(rownNr, colOfCov).setValue(calcRqm(adapter, dayIdx, adapter._scmData[dayIdx]._firstDayInCol))
                            //settingn Delivery
                          wb.getActiveWorksheet().getCell(rownNr, colOfCov + 2).setValue(adapter._scmData[dayIdx]._etaQty)
                        }

                        //adding ending balance formulas
                        wb.getActiveWorksheet().getCell(rownNr, colOfCov + 3).setFormulaR1C1(addEBalFormula(dayIdx, innerDayCounter, adapter, colOfCov))
                        // wb.getActiveWorksheet().getCell(firstcolOfCov + 2, rownNr).setValue(day.f)//setting RQM

                        colOfCov += 4
                        innerDayCounter += 1
                        dayIdx += 1
                    } else {
                        if (colOfCov == 15) {
                            wb.getActiveWorksheet().getCell(rownNr, colOfCov + 3).setFormulaR1C1("=RC[-5]-RC[-3]+RC[-1]")
                        } else {
                            wb.getActiveWorksheet().getCell(rownNr, colOfCov + 3).setFormulaR1C1("=RC[-4]-RC[-3]+RC[-1]")
                        }
                        colOfCov += 4
                    }

                }

            }

        }
        rownNr += 1
    }

}
/**
 * For fire flake sheet type it returns exisitng Rqm value, because there is no need to modify it. fire flake has no information about consumato. For PCV exports Rqm should be reduced with consumato value. But when consumato is greater than rqm, 0 is returned.
 */
function calcRqm(adapter: Adapter, dayIdx: number, firstDayInCol: boolean): number | string {
  if (adapter._typeOfFile == "FF") {
    return Number(adapter._scmData[dayIdx]._grossReq)
    } else {
      let diff: number = Number(adapter._scmData[dayIdx]._grossReq) - Number(adapter._scmData[dayIdx]._consumato)

        if (!firstDayInCol) {

            return ""
        }
        else if (diff < 0) {

            return 0
        } else {

            return diff
        }
    }


}
function addEBalFormula(dayIdx: number, innerDayCounter: number, adapter: Adapter, colOfCov: number) {

    const formulas = {
        "FF": ["=RC[-5]-RC[-3]+RC[-1]-RC12", "=RC[-4]-RC[-3]+RC[-1]-RC12", "=RC[-4]-RC[-3]+RC[-1]+RC15", "=RC[-4]-RC[-3]+RC[-1]", "=RC14-RC[-3]+RC[-1]-RC12"],
        "Multi": ["=RC[-5]-RC[-3]+RC[-1]", "=RC[-4]-RC[-3]+RC[-1]"],
        "Single": ["=RC[-5]-RC[-3]+RC[-1]", "=RC[-4]-RC[-3]+RC[-1]"]
    }
    // console.log(adapter)
  if (adapter._typeOfFile == "FF") {

        //recognizing a type of formula
      let matches = adapter._scmData[dayIdx]._formula.split(/[+|-]/)

        if (matches.length == 4) {

            if (matches[3].slice(0, 1) == "L" && matches[2].slice(0, 1) == "N") {

                return formulas["FF"][3]
            }
            else if (matches[3].slice(0, 1) == "L" && matches[2].slice(0, 1) !== "N") {
                return formulas["FF"][1]
            }
            else if (matches[3].slice(0, 1) == "O") {
                return formulas["FF"][2]
            } else {
                return formulas["FF"][3]
            }
        } else {
            return formulas["FF"][3]
        }
        //recognizing formulas for Multi and single file types
    } else {
        if (((dayIdx + 1) == innerDayCounter) && (innerDayCounter == 1) && (colOfCov == 15)) {
            return formulas["Multi"][1]
        }
        else {
            return formulas["FF"][3]
        }
    }
}

const articleInfo = {
    _partNumber: 1,
    _partName: 4,
    _plantName: 3,
    _plantCode: 2,
    _supplierName: 5,
    _backlog: 10,
    _stock: 13,
    _resp: 6,
    _bip: 11,
    _comment1: 7,
    _comment2: 8,
    _recev: 14,
    _hazards: 12,
    _firstRunout: 9,
    _initialStock: 13
}