import re

class Link():
    """
    A class used to represent Link to all job offers
    ...
    Attributes
    ----------
    job:str
        value of Stanowisko input
    region:str
        value of Region input
    chBtn1:str
        value="" or "1"
    chBtn2:str
        value="" or "3"
    chBtn3:str
        value="" or "17"
    chBtn4:str
        value="" or "4"
    chBtn5:str
        value="" or "18"
    basicLink:str
        basic link structure
    buildedLink:str
        current Link structure

    Methods
    -------
    createLink():returns str
        creates link to job offers according to filled checkboxes and inputs
    checkIfJobAndRegionAreEmpty()
        checks if inputs have been filled
    checkIfChecboxesHaveBeenMarked(markedCheckboxes:list):returns str
        returns marked checboxes values divided with %
    """
    def __init__(self,markedCheckboxes:list,inputs:list):
        """
        Parameters
        :param job:
        :param region:
        :param markedCheckboxes:
        """
        self.__job=inputs[0]
        self.__region=inputs[1]
        self.__markedCheckboxes=markedCheckboxes


        self.__basicLink="https://www.pracuj.pl/praca/"
        self.__buildedLink=""

    def createLink(self):

        self.__buildedLink+=self.__basicLink+self.__job+"/"+self.__organizeLinkStructure()

        #print(self.buildedLink)
        return self.__buildedLink

    #move 2 mbelow methods to Interfacee class
    def __organizeLinkStructure(self):
        self.__job+=";kw"
        self.__region+=";wp?rd=30"

        # putting '&et=' string before first checkbox value,beacuse later they are joined with % in list ordering
        # concatenating string checboxes values with %

        self.__markedCheckboxes[0]="&et="+re.search(r"[0-9]+$", self.__markedCheckboxes[0])[0]
        strWithProcent = "%".join(self.__markedCheckboxes)
        return self.__job+"/"+self.__region+strWithProcent
