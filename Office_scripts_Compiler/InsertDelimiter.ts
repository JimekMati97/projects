
function main(workbook: ExcelScript.Workbook, strOfAdapters: string) {
    // function addDelimiter(collectionOfConvertedData: Adapter[]) {
    //adding & character after first appearance of the character "}", after 15th appearance of  characters "}]"
    //providing delimiter for POwer Automate split function
    let countOfAdapters: number = JSON.parse(strOfAdapters).length
    // console.log(collectionOfConvertedData[0].pscmData[0].date)
    // let strArrayOFAdapters: string = JSON.stringify(strOfAdapters)
  
    let indexes: number[] = []
    let rgx = /,\{\"scmData/gi
    let result: RegExpExecArray;
    let startPos: number = -1
    let strWithDelimiter: string = ""
    //how many matches of "{"scmData" has found
    let macthesCount: number = 0
    while ((result = rgx.exec(strOfAdapters))) {
  
      //strWithDelimiter should be addad only every 10th article, 
      //preventing condition when first artcile was found
      //at last article rest should be calculated
      if (macthesCount % 5 == 0 && macthesCount !== 0 && countOfAdapters !== macthesCount) {
        strWithDelimiter += strOfAdapters.slice(startPos + 1, result.index) + "]&["
        startPos = result.index
      }
      macthesCount += 1
    }
    //how many articles left as the rest
    let rest: number = macthesCount - 1 % 5
    //if rest is equal to 0, that means that quantity of articles is dividable with 10, so it means we are currently at the end of a string
    if (rest) {
      //if rest exists, we can add to strWithDelimiter final part of a string
      strWithDelimiter += strOfAdapters.slice(startPos + 1)
    }
    return strWithDelimiter
  
  }