import time
from tkinter import *
from db import Db


class SavedOfferInt():

    offerToDelete=[]
    def __init__(self):

        self.__root=Tk()
        self.__windowSize = self.__root.geometry("1100x900")


        self.__jobOfferFrame=LabelFrame(self.__root,height=800)
        self.__root.columnconfigure(0,weight=1)
        self.__jobOfferFrame.grid(row=0,column=0,sticky=NW)


        self.__singleOffer = LabelFrame(self.__root,background="green")
        self.__root.columnconfigure(1, weight=1)
        self.__singleOffer.grid(row=0, column=1)




        self.__displayData()
    def __displayData(self):

        #del Btn
        confirmBtn = Button(self.__jobOfferFrame, text="Usuń zaznaczone", command=self.__deleteRows)
        confirmBtn.pack()

        self.__db=Db()

        savedJobOffers=self.__db.getSavedJobOffers()

        canvasFrame=self.__makeCanvas()

        for jobOffer in savedJobOffers:

            singlejobFrame=Frame(canvasFrame,borderwidth=2, relief="groove")
            singlejobFrame.pack(fill=BOTH)
            #numer miesjca pracy
            idOfJob=Label(singlejobFrame,text=jobOffer[0])
            idOfJob.grid(row=0,column=0,sticky=NW)

            singlejobFrame.columnconfigure(0, weight=2)
            singlejobFrame.columnconfigure(1, weight=2)
            singlejobFrame.columnconfigure(2, weight=2)
            singlejobFrame.columnconfigure(3, weight=1)


            #stanowisko
            nameOfJob=Label(singlejobFrame,text=jobOffer[1],wraplength=190)
            nameOfJob.grid(row=1,column=0)
            nameOfJob.configure(font=("courier", 11, "bold"))

            #link do oferty
            # linkToOffer=Label(singlejobFrame,text=jobOffer[2])
            # linkToOffer.grid(row=0,column=1)

            #nazwa firmy
            nameOfCompany=Label(singlejobFrame,text=jobOffer[3],wraplength=190)
            nameOfCompany.grid(row=1,column=1)

            #specyfikacja oferty
            jobDesc=Label(singlejobFrame,text=jobOffer[4],wraplength=190)
            jobDesc.grid(row=2,column=0)

            #data publikacji
            dateOfPublish=Label(singlejobFrame,text=jobOffer[5])
            dateOfPublish.grid(row=1,column=2)

            #lokalizacja
            loc=Label(singlejobFrame,text=jobOffer[6])
            loc.grid(row=2,column=1)

            #delete
            self.__createDeletingOfferChbox(singlejobFrame,jobOffer[0])

            #doffer preview
            val=IntVar()
            delBtn=Button(singlejobFrame,text="Pokaż")
            delBtn.grid(row=2,column=3)

    def __makeCanvas(self):
        canvas = Canvas(self.__jobOfferFrame, width=540, height=800)
        canvas.pack(side=LEFT, fill=X)

        scrollbar = Scrollbar(self.__jobOfferFrame, command=canvas.yview)
        scrollbar.pack(side=RIGHT, fill='y')

        canvas.configure(yscrollcommand=scrollbar.set)

        canvas.bind('<Configure>', lambda e: canvas.configure(scrollregion=canvas.bbox("all")))

        # --- put frame in canvas ---

        frame = Frame(canvas)
        canvas.create_window((0, 0), window=frame, anchor='nw')

        return frame

    # #creating checbox for each offer
    def __createDeletingOfferChbox(self,singlejobFrame,jobOfferId):

        var1 = IntVar()
        var1.set(jobOfferId)

        delBtn = Checkbutton(singlejobFrame, text="Usuń", variable=var1, onvalue=jobOfferId,
                             offvalue=(-jobOfferId),
                             command=lambda: self.__changeGroupOfChecked(var1.get()))
        delBtn.grid(row=1, column=3)

    #inserting and deleting ids of job offers from a list
    def __changeGroupOfChecked(self,offerId):

        # adding confirm button, in order to send checked job offers to database
        if len(self.offerToDelete)==0:

            self.offerToDelete.append(offerId)

        else:
            #we need to change negative id value to positive in order to find it in a list and remove a propper one
            offerId=abs(offerId)

            #check if offer id exists in a list. if it's true then it means that checbox has been unchecked
            if offerId in self.offerToDelete:
                self.offerToDelete.remove(offerId)
            #adding offer's id to a list
            else:
                self.offerToDelete.append(offerId)

    def __deleteRows(self):

        con = Db()
        # bring all data from checked offers to delete

        con.deleteData(self.offerToDelete)

        #deleting canvas
        print(self.__jobOfferFrame.pack_slaves())
        for element in self.__jobOfferFrame.pack_slaves():
            element.destroy()
        print(self.__jobOfferFrame.pack_slaves())

        self.__displayData()
