import re
class JobOffer():
    """
        A class used to represent single Job Offer
        ...
        Attributes
        offerId=
        ----------
        offerId:int
        jobName:str
        link:list
        companyName:str
        companyLink:str
        jobLocation:list
        offerSpec:list
        dateOfPublish:str
    """
    offerIdCls:int=0
    def __init__(self,jobName,link,companyName,companyLink,jobLocation,offerSpec,dateOfPublish):
        # print(jobName,link,companyName,companyLink,jobLocation,offerSpec,dateOfPublish)
        """
        :param id
        :param jobName:
        :param link:
        :param companyName:
        :param companyLink:
        :param jobLocation:
        :param offerSpec:
        :param dateOfPublish:
        """
        self.__offerId=self.setOfferId(1)
        print(self.__offerId)
        self.__jobName=jobName
        self.__link=link
        self.__companyName=companyName
        self.__companyLink=companyLink
        self.__jobLocation=jobLocation
        self.__offerSpec=offerSpec
        self.__dateOfPublish=dateOfPublish

        #substracting string "opublikowana"
        self.subDate()

    def subDate(self):
        self.__dateOfPublish=re.sub("opublikowana: ","",self.__dateOfPublish)
    @property
    def offerId(self):
        return self.__offerId

    # @offerId.setter
    def setOfferId(self,value:int):
        #increment id by 1
        JobOffer.offerIdCls+=value
        return JobOffer.offerIdCls


    @property
    def getLocation(self):
        return self.__jobLocation
    @property
    def getDate(self):
        return self.__dateOfPublish

    @property
    def getJobName(self):
        return self.__jobName
    @property
    def getJobLink(self):
        print(self.__link)
        return self.__link
    @property
    def getCompanyName(self):
        return self.__companyName
    @property
    def getOfferSpec(self):
        return self.__offerSpec
    @property
    def getOfCompanyLink(self):
        return self.__offerId


