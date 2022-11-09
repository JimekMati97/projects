
from JobOffer import JobOffer
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.service import Service

class Req():
    """
        A class used to represent Request
        ...
        Attributes
        ----------
        jobOffersCol:list
            list of JobOffer objects
        jobName:str
            name of the job
        jobLink:list
            link to a job
        companyName:str
        jobLocation:list
        companyLink:str
            link to a city
        offerSpec:list
            type of contract
        dateOfPub:str
        jobOffer:str
            single job offer from jobOffersList variable
        Methods
        -------
        parseData(link:str):returns:list
            parse allData to class atributes
        launchBrowser(link:str):returns:str
            generate respoonse from web link
        dealWithJobLink()
        GetOfferSpec()
        getDate()
        GetJobLocationForOffersWithOnePlant()
        parseParticularJobOffer()

    """

    jobLocation=[]


    def __init__(self,link:str):
       self.__link=link
       self.__jobOffersCol=[]
       self.__validLink=link #resposnible for storing link with addad page number

    def setValLink(self,value):
        self.__validLink=value
        soup = self.__launchBrowser()
        result = self.__parseParticularJobOffer(soup)
        return result
    def __checkHowManyPages(self):
        soup = self.__launchBrowser()
        paginationDiv=soup.find("div",class_="pagination")

        howmManyPages:int;
        #new line is alwayes viisble as firs elelment of a list
        try:
            if len(list(paginationDiv.children))>1:

                howmManyPages=len(paginationDiv.find("ul",class_="pagination_list").find_all('li',{'class':'pagination_element-page'}))

            else:
                howmManyPages=1
            return howmManyPages
        #if div container with pagination was not found assume, that there is only 1 page
        except:
            howmManyPages=1
            return howmManyPages

    def __bringRawData(self,howmManyPages):
        rawJobOfferList=[]
        for pageNr in range(1,howmManyPages+1):

            #modify link with valid page number
            self.__validLink=self.__link+"&pn="+str(pageNr)
            soup = self.__launchBrowser()

            # list of job offers
            jobOffersList = soup.find('div', class_='page').find('ul', class_="results__list-container").find_all('li',{'class': ('results__list-container-item','results__list-container-item offer-container')})
            rawJobOfferList.extend(jobOffersList)

        return rawJobOfferList
    def parseData(self):

        #How many pages with job offers to load
        howmManyPages=self.__checkHowManyPages()
        rawJobOfferList=self.__bringRawData(howmManyPages)

        jobOffersListFiltered = filter(lambda jobOffer: 0 if "ad-container--show-mobile" in jobOffer.attrs['class'] else 1, rawJobOfferList)
        #print(len(list(jobOffersListFiltered)))
        for joboffer in jobOffersListFiltered:

            #checking if job Offer has valid data quantity
            if len(list(joboffer.descendants))>50:

                self.__jobOffer=joboffer

                # self.GetTheNAmeOfTheJob()
                self.__jobName = list(joboffer.find('div', class_="offer-details__text").h2.stripped_strings)[0]

                self.__jobLinkAndTag=self.__dealWithJobLink()

                self.__companyName, self.__companyLink =self.__GetCompanyNAmeAndLink()

                self.__GetJobLocationForOffersWithOnePlant()

                self.__dateOfPub = self.__jobOffer.find('span', class_="offer-actions__date").text

                self.__offerSpec=[singleOfferSpecific.text for singleOfferSpecific in self.__jobOffer.find('ul', class_="offer-labels offer-labels--hide-on-mobile").find_all('li')]

                # instatce of JobOffer obj
                offer = JobOffer(self.__jobName,self.__jobLinkAndTag[0], self.__companyName, self.__companyLink,self.jobLocation,self.__offerSpec,self.__dateOfPub)

                #pushing jobOffer to list
                self.__jobOffersCol.append(offer)

        return self.__jobOffersCol


    def __launchBrowser(self):

        s = Service('/usr/local/bin/chromedriver')
        driver = webdriver.Chrome(service=s)
        driver.get(self.__validLink)

        soup=BeautifulSoup(driver.page_source,'html.parser')

        return soup

    def __dealWithJobLink(self):

        # link
        linkWrapper = list(self.__jobOffer.find('h2', class_="offer-details__title").children)
        if "\n" in linkWrapper:
            linkWrapper.remove("\n")
        tagWithLink =linkWrapper[0]

        tag_name=tagWithLink.name
        if tag_name == "a":

            return [tagWithLink.attrs['href'],tag_name]
        #if button exists there more than one job locations
        elif tag_name == "button":

            jobLinks=[oneJobLocation['href'] for oneJobLocation in  self.__jobOffer.find('div', class_='offer-regions').find_all('a')]

            self.jobLocation.append(jobLinks[0])

            return [jobLinks,tag_name]
        else:
            return ["error",tag_name]


    def __GetCompanyNAmeAndLink(self):

        companyNames = list(self.__jobOffer.find('p', class_="offer-company").children)
        # without new line
        filteredCompanyNames = list(filter(lambda companyName: 1 if companyName != "\n" else "", companyNames))
        chosenCompanyName = filteredCompanyNames[1].find('a').text

        # comapnyLink
        companyLink = filteredCompanyNames[1].find('a')['href']
        return (chosenCompanyName, companyLink)

    def __GetJobLocationForOffersWithOnePlant(self,):
        # job location for offers with only one location
        if self.__jobLinkAndTag[1] == "a":
            wrapper = self.__jobOffer.find('li', class_="offer-labels__item offer-labels__item--location")
            self.jobLocation.append(wrapper.text)

    def __parseParticularJobOffer(self,soup):

        soup=soup.select('div[data-scroll-id="requirements-expected-1"]')

        jobReq=[]

        for each in soup:
            jobReq.append(each.text)
        return jobReq






