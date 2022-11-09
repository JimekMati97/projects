import mysql.connector

class Db:


    def __init__(self):
        self.__db=self.__connect()

    def __connect(self):

        db=mysql.connector.connect(
        host="localhost",
        user="phpmyadmin",
        password="admin",
        database="jobOffers"
        )
        return db

    def insertData(self,dataToSave):

        mycursor = self.__db.cursor()

        for singleJobOffer in dataToSave:
            sJO = singleJobOffer
            sql = "INSERT INTO `jobOffers`( `jobName`, `linkToOffer`, `companyName`, `offerSpec`, `dateOfPub`, `jobLocation`, `companyLink`) VALUES ( %s, %s, %s, %s,%s,%s, %s)"
            param = (sJO.getJobName, sJO.getJobLink[0], sJO.getCompanyName, sJO.getOfferSpec[0], sJO.getDate,
                     sJO.getLocation[0], sJO.getOfCompanyLink)
            mycursor.execute(sql, param)

            self.__db.commit()

    # show savd job offers
    def getSavedJobOffers(self):

        mycursor = self.__db.cursor()

        sql = "SELECT * FROM jobOffers"

        mycursor.execute(sql)
        myresult = mycursor.fetchall()

        return myresult
    def deleteData(self,offerToDelete):

        mycursor = self.__db.cursor()

        for idToDelete in offerToDelete:

            sql = "DELETE FROM jobOffers WHERE id=%s"
            param=(idToDelete,)
            mycursor.execute(sql,param)

            self.__db.commit()