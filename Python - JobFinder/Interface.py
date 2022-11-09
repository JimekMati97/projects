#wygląd okna;

from functools import partial
import tkinter
from db import Db
from tkinter import *
from Req import Req
from SavedOfferInt import SavedOfferInt
from Link import Link



class Interface:

    """
    class used to highlight data, interract with user
     ...
    Attributes

    offersToSave:list

    ----------
    Methods
    sendData()
        sending data from inputs and checkboxes after cliking submit button
    sendDataToLinkBuilder():returns:str
        creating Link object and

    """

    offersToSave=[]

    def __init__(self):
        self.__root=Tk()
        self.__windowSize=self.__root.geometry("1310x840")

        #frame on entry level

        self.__frameEntry=LabelFrame(self.__root,text="Entry-Frame",width=300,height=50)
        self.__frameEntry.grid(row=0,column=0,sticky="nsew",rowspan=1)

        #JobInput

        self.__frameEntryJobLabel=Label(self.__frameEntry,text="Stanowisko",anchor=tkinter.W)
        self.__frameEntryJobLabel.config(width=25)
        self.__frameEntryJobLabel.grid(row=0, column=0)
        self.__frameEntryJob=Entry(self.__frameEntry,width=25)
        self.__frameEntryJob.insert(0,'programista')
        self.__frameEntryJob.grid(row=1,column=0)

        #RegionInput
        self.__frameEntryRegionLabel=Label(self.__frameEntry,text="Region")
        self.__frameEntryRegionLabel.grid(row=0,column=1)
        self.__frameEntryRegion=Entry(self.__frameEntry,width=25)
        self.__frameEntryRegion.insert(0,'Gliwice')
        self.__frameEntryRegion.grid(row=1,column=1)

        #ExpCheckboxes
        self.__chBtn1=StringVar()
        self.__frameEntryCheck1=Checkbutton(self.__frameEntry,text="Praktykant/Stażysta",anchor=tkinter.W,variable=self.__chBtn1,onvalue="1",offvalue="")
        self.__frameEntryCheck1.config(width=25)
        self.__frameEntryCheck1.grid(row=2,column=0)

        self.__chBtn2 = StringVar()
        self.__frameEntryCheck2=Checkbutton(self.__frameEntry,text="Asystant",anchor=tkinter.W,variable=self.__chBtn2,onvalue="3",offvalue="")
        self.__frameEntryCheck2.config(width=25)
        self.__frameEntryCheck2.grid(row=3,column=0)

        self.__chBtn3 = StringVar()
        self.__frameEntryCheck3=Checkbutton(self.__frameEntry,text="Mlodszy specjalista(Junior)",anchor=tkinter.W,variable=self.__chBtn3,onvalue="17",offvalue="")
        self.__frameEntryCheck3.config(width=25)
        self.__frameEntryCheck3.grid(row=4,column=0)

        self.__chBtn4 = StringVar()
        self.__frameEntryCheck4=Checkbutton(self.__frameEntry,text="Specjalista(Mid/Regular)",anchor=tkinter.W,variable=self.__chBtn4,onvalue="4",offvalue="")
        self.__frameEntryCheck4.config(width=25)
        self.__frameEntryCheck4.grid(row=5,column=0)

        self.__chBtn5 = StringVar()
        self.__frameEntryCheck5=Checkbutton(self.__frameEntry,text="Starszy specjalista(Senior)",anchor=tkinter.W,variable=self.__chBtn5,onvalue="18",offvalue="")
        self.__frameEntryCheck5.config(width=25)
        self.__frameEntryCheck5.grid(row=6,column=0)

        #Button Form Submit

        self.__btnSubmit=Button(self.__frameEntry,text="Szukaj",command=self.__prepareData)
        self.__btnSubmit.grid(row=2,column=1,rowspan=2)

        #Button Saved Job Offers
        self.__btnSavedOffers=Button(self.__frameEntry,text="Zapisane oferty",command=self.__showSavedData)
        self.__btnSavedOffers.grid(row=4,column=1)

        #frame showing preview of chosen job offer

        self.__framePreview=LabelFrame(self.__root,text="Wymagania")
        self.__framePreview.grid(row=1,column=0,columnspan=1,sticky="nsew")
        self.__root.mainloop()

        #jobOffers

        self.__jobOffer=None
        self.__jobOfferCollection=None
        self.__singleJobFrame=None

    def __prepareData(self):
        """Checking if inputs have been filled and checkboxes marked"""
        #check if at least one of checkboxes has been marked:boolean
        checkboxes:list=[self.__chBtn1,self.__chBtn2,self.__chBtn3,self.__chBtn4,self.__chBtn5]

        #getting list of marked checkedboxes
        markedCheckboxes:list=list(filter(len,list(map(lambda chbox:"2c"+chbox.get() if chbox.get() != ""  else "",checkboxes))))
        #################################################################make for loop od conditions
        checkboxRule:bool=True if len(markedCheckboxes)>0 else False

        #check if Stanowisko input has been filled:boolean
        inputStanowisko:str=self.__frameEntryJob.get()
        stanowiskoRule:bool=True if inputStanowisko else False

        # check if Region input has been filled:boolean
        inputRegion:str=self.__frameEntryRegion.get()
        regionRule:bool=True if inputRegion else False

        #if stanowiskoRule or regionRule is false, return info about filling inputs.
        if (not checkboxRule or not stanowiskoRule or not regionRule):
             return "You need to mark at least 1 checkbox and fill region and stanowisko inputs"

        #if rules are all true, then build link
        preparedLink:str=self.__sendDataToLinkBuilder(markedCheckboxes,[inputStanowisko,inputRegion])

        reqModule=Req(preparedLink)
        jobOfferCol=reqModule.parseData()

        self.__putData(jobOfferCol)


    def __sendDataToLinkBuilder(self,markedCheckboxes,inputs):

        #Link class
        #put only in construcotr marked checkboxes
        # linkBuilder=Link(self.frameEntryJob.get(),self.frameEntryRegion.get(),self.chBtn1.get(),self.chBtn2.get(),self.chBtn3.get(),self.chBtn4.get(),self.chBtn5.get())
        linkBuilder=Link(markedCheckboxes,inputs)

        #no need for calling this method, because it should be called in construcotr directly
        preparedLink=linkBuilder.createLink()

        return preparedLink


    def __putDataInRequiriments(self,req):

        if(len(list(self.__framePreview.children))>0):
            for child in self.__framePreview.pack_slaves():
                child.destroy()

        for single in req:
            text=Label(self.__framePreview,text=single,wraplength=400)
            text.pack(fill=BOTH)


    #putting job offers into tkinter interface
    def __putData(self,jobOfferCol:list):

        # removing old data from collection
        # self.removeDataFromCol(jobOfferCol)

        #make possible to access to jobCol for all methodsin Interface cls
        self.__jobOfferCollection = jobOfferCol

        #if the job offers window has been removed, create again job offers frame
        self.__createJobOffersFrame()

        frame=self.__makeCanvas()

        if (len(jobOfferCol) == 0):
            noResultsLabel=Label(frame,text="Brak ofert, które spełniałyby podane przez Ciebie kryteria wyszukiwania")
            noResultsLabel.pack()
        else:

            for jO in jobOfferCol:

                self.__jobOffer=jO

                self.__createSingleJobFrame(frame)

                self.__createJobNameLabel()

                self.__createCompanyNameLabel()

                self.__createCompanyDate()

                self.__createJobLabelOfferSpec()

                self.__createSavingOfferChbox()


    def __createJobOffersFrame(self,):

        if len(self.__root.grid_slaves()) == 2:

            self.__frameJobs = LabelFrame(self.__root, text="JobsOffers", width=850, height=800)
            self.__frameJobs.grid(row=0, column=1,rowspan=2)

        elif len(self.__root.grid_slaves()) == 3:
            self.__root.grid_slaves()[0].destroy()

            self.__frameJobs = LabelFrame(self.__root, text="JobsOffers", width=850, height=800)
            self.__frameJobs.grid(row=0, column=1,rowspan=2)

    def __makeCanvas(self):

        canvas = Canvas(self.__frameJobs, width=850, height=800)
        canvas.pack(side=LEFT, fill=X)

        scrollbar = Scrollbar(self.__frameJobs, command=canvas.yview)
        scrollbar.pack(side=RIGHT, fill='y')

        canvas.configure(yscrollcommand=scrollbar.set)

        canvas.bind('<Configure>', lambda e: canvas.configure(scrollregion=canvas.bbox("all")))

        # --- put frame in canvas ---

        frame = Frame(canvas)
        canvas.create_window((0, 0), window=frame, anchor='nw')

        return frame


    def __createSingleJobFrame(self,frame):
        self.__singleJobFrame = Frame(frame, borderwidth=2, relief="groove")
        self.__singleJobFrame .pack(fill=BOTH, padx=5, pady=5)

    def __createJobNameLabel(self):
        # job name
        jobOfferName = Label(self.__singleJobFrame, text=self.__jobOffer.getJobName, width=30, cursor="hand2", wraplength=200)
        jobOfferName.grid(row=0, column=0, sticky="nsew")
        jobOfferName.grid_columnconfigure(0, weight=1)
        jobOfferName.bind("<Button-1>", partial(self.__bringParticularJobInfo, self.__jobOffer.getJobLink))
        jobOfferName.configure(font=("courier", 11, "bold"))

    def __createCompanyNameLabel(self):
        # companyName
        companyName = Label(self.__singleJobFrame, text=self.__jobOffer.getCompanyName,width=30)
        companyName.grid(row=0, column=1,sticky="nsew")
        companyName.grid_columnconfigure(1, weight= 1)

    def __createCompanyDate(self):
        # dateofPub
        companyDate = Label(self.__singleJobFrame, text=self.__jobOffer.getDate, justify="right", width=30)
        companyDate.grid(row=0, column=2, sticky="nsew")
        companyDate.grid_columnconfigure(2, weight=1)

    #creating checbox for each offer
    def __createSavingOfferChbox(self):
        var1=IntVar()
        #checbox pass positive id of jobOffer if clicked=True, else pass negative id if clicked=False
        chbox = Checkbutton(self.__singleJobFrame, text="Zapisz", variable=var1,
                            command=partial(self.__changeGroupOfChecked,self.__jobOffer.offerId)) #lambda prevents automatic invoking a method
        chbox.grid(row=0,column=3,sticky="nsew")

    #putting and deleting ids of job offers from a list
    def __changeGroupOfChecked(self,id):

        # adding confirm button, in order to send checked job offers to database
        if len(self.offersToSave)==0:
            confirmBtn=Button(self.__frameEntry,text="Zatwierdź",command=self.__insertRows)
            confirmBtn.grid(row=5,column=1,rowspan=2)
            self.offersToSave.append(id)
        else:
            # checkbox has been checked, so add jobOffer to observed, adding offer's id to a list
            if not id in self.offersToSave:
                self.offersToSave.append(id)
            else:
                self.offersToSave.remove(id)

    #Connecting with mysql db
    def __insertRows(self):

        con=Db()
        #bring all data from checked offers to save
        dataToSave=self.__getDataOfOffersToSave()

        con.insertData(dataToSave)

    def __getDataOfOffersToSave(self):
        jobOffersToSave=[]
        for offerId in self.offersToSave:
            for jobOfferInCol in self.__jobOfferCollection:
                if jobOfferInCol.offerId == offerId:
                    jobOffersToSave.append(jobOfferInCol)
                    break
        return jobOffersToSave

    #crating new window with saved job offers
    def __showSavedData(self):

        savedOffers=SavedOfferInt()


    def __createJobLocationLabel(self):
        # location
        jobLoc = self.__jobOffer.getLocation
        jobLocStr = ", ".join(jobLoc)
        jobLocStrLabel = Label(self.__singleJobFrame, text=jobLocStr, wraplength=100)
        jobLocStrLabel.grid(row=1, column=0, columnspan=3, sticky="w")

    def __createJobLabelOfferSpec(self):
        # spec
        jobSpec = self.__jobOffer.getOfferSpec
        jobSpecStr = ", ".join(jobSpec)
        jobSpecStrLabel = Label(self.__singleJobFrame, text=jobSpecStr, wraplength=730)
        jobSpecStrLabel.grid(row=2, column=0, columnspan=3, sticky="nsew")


    def __bringParticularJobInfo(self,link,x):

        req=Req(link)
        result=req.setValLink(link)

        self.__putDataInRequiriments(result)