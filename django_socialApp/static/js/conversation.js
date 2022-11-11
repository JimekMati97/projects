const conv=document.querySelector("#conv")

const allActiveFriendsAccounts=document.querySelectorAll(".activePersonName")

let screen={
    "conversationList":[],
    "prepareData":function(activePersonAccount,convId,e){
        if(!screen.conversationList.some((singleConv)=>(convId===singleConv.convId))){
            //init and adding Conversation object to screen object conversationList property
            let convWindow=new Conversation(convId,e.target.innerText,e.target.id)//(conversation id:string,name of Addresse, id of addresse Account)
            screen.conversationList.push(convWindow)

            const quantityOfOpenedCOnv=screen.conversationList.length

            convWindow.createConvWindowInterface(quantityOfOpenedCOnv)

            //check if interface is ready fill it with messeges from database
            if(convWindow.isCreated){
                
                findButtonsForSendingMsg(activePersonAccount.id,convWindow)
            }
        }else{
            alert("You have already opened conversation window with "+screen.conversationList.filter(singleConv=>singleConv.convId==convId)[0].addressee)
        }
    },
    "maxConvInRow":function(){
        return Math.floor(800/263)
    }
}

allActiveFriendsAccounts.forEach(activePerson => {
    activePerson.addEventListener("click",function(e){

     
        e.preventDefault()
        //create id tag of conversation window based on id of Account model
        let convId="conv#"+String(e.target.id)

        //check if any conversion window is opened
        if(screen.conversationList.length>0){
           
            //if you click on a person with you are already chatting, window will not be reopened.
            //let ifExists=screen.checkIfIdExists(convId)  
            screen.prepareData(activePerson,convId,e)

        //if there are no conversation opened
        }else{
            screen.prepareData(activePerson,convId,e)
        }
   
          
    })
});  
//(conversation id:string,name of Addresse, id of addresse Account)
function Conversation(convId,addressee,originalIdOfPerson){
    this.addressee=addressee
    this.convId=convId
    this.originalIdOfPerson=originalIdOfPerson
    this.isCreated=false
    this.askedFirstTime=false
    this.isVisible=true
}

Conversation.prototype.createConvWindowInterface=function(quantityOfOpenedCOnv){

    if(quantityOfOpenedCOnv>3){
        alert("you cannot add more than 3 convs")
    }else{

        quantityOfOpenedCOnv=(quantityOfOpenedCOnv==1)?0:quantityOfOpenedCOnv-1
        
        const mainContainer=document.getElementById("mainContainer")
        const singleConv=document.createElement("div")
        // const divCreator=document.createElement("div")
        
        const [header,addressee,body,footer,closeConvBtn, msgInput, msgBtn]=[document.createElement("div"),document.createElement("div"),document.createElement("div"),
        document.createElement("div"),document.createElement("button"),document.createElement("input"),document.createElement("button")]

        //addressee.id=idOfAPerson//nie dziala - iundefinded

        //setting class names with bootstrap
        header.className="d-flex row-padding convHeader col-12 p-2"
        body.className="row-padding col-12 convBody"
        footer.className="d-flex row-padding col-12 convFooter"
        addressee.className="self-align-start col-11"
        closeConvBtn.className="self-align-end col-1 d-flex justify-content-center"

        closeConvBtn.addEventListener("click",()=>this.closeConvWindow(this.convId))

        closeConvBtn.innerText="X"
        addressee.innerText=this.addressee
        
        singleConv.appendChild(header)
        singleConv.firstChild.appendChild(addressee)
        singleConv.firstChild.appendChild(closeConvBtn)
        singleConv.appendChild(body)
        singleConv.appendChild(footer)
        singleConv.lastChild.appendChild(msgInput)
        singleConv.lastChild.appendChild(msgBtn)
        // singleConv.childNodes[1].innerText="gege"
        singleConv.lastChild.childNodes[1].innerText="Send"
        singleConv.lastChild.childNodes[1].id="msgBtnSender"+this.convId

        msgBtn.className="col-2 sendMsgBtn btn btn-success d-flex justify-content-center"
        msgInput.className="col-10"

        singleConv.className="singleConvBody"
        singleConv.id=screen.conversationList[screen.conversationList.length-1].convId
        singleConv.style.position="absolute"
        singleConv.style.right=quantityOfOpenedCOnv*270 + quantityOfOpenedCOnv*13
        singleConv.style.marginLeft=6.5
        singleConv.style.marginRight=6.5
        singleConv.style.bottom=0
        mainContainer.appendChild(singleConv)
        
        this.isCreated=true
        
    }

   

}

Conversation.prototype.closeConvWindow=function(idOfDelConv){
        
        screen.conversationList.some(function(singleConv){
            if(idOfDelConv==singleConv.convId){
                singleConv.isVisible=false
            }
        })   
   
}


Conversation.prototype.askFirstTime=function(convId,addresseeId){
                // GET AJAX request
                let serializedData=addresseeId //addresseId
                let idOflastMessege="-1"
                

                askServer(convId,serializedData,idOflastMessege)
                demo(this,convId,serializedData)
                
                
}
Conversation.prototype.askConstantly=function(convId,addresseeId){
    // GET AJAX request
    let i=0
    // const idConv="conv#2"

    var serializedData=addresseeId
    let myId=document.getElementById("smallPostProfileImg")
    myId=myId.getAttribute("href").match(/\/(\d+)/)[1]
    let idOflastMessege;
   //at first time download all
    //check the repsonse - if it's empty continue listining: if it's not take 
   //
    //check if there are any messeges already sent

    let id=setInterval(function(){
        //check if window is still visible
        let convToDelete=screen.conversationList.filter(singleConv=>(singleConv.convId==convId && singleConv.isVisible==false))
        console.log(id)
        if(convToDelete.length>0){
            stopInterval(convToDelete[0])
        }else{
        // if(screen.conversationList.some(singleConv=>(singleConv.convId==convId && singleConv.isVisible==true))){

            
            if(document.getElementById(convId).childNodes[1].hasChildNodes()){
                
                idOflastMessege= document.getElementById(convId).childNodes[1].lastChild.id
            
            }else{
                
                idOflastMessege=-1
               
            }
            askServer(convId,serializedData,idOflastMessege)
            i+=1

        }
        },1000);
    
    function stopInterval(convToDelete){
        clearInterval(id)
            
        console.log(convId)
        const mainContainer=document.getElementById("mainContainer")

        const indexOfDeletedConv=screen.conversationList.indexOf(convToDelete)

        screen.conversationList.splice(screen.conversationList.indexOf(convToDelete),1)
        
        let convToRemove=document.getElementById(convToDelete.convId)
        mainContainer.removeChild(convToRemove)
        
        for (convWindow of screen.conversationList.slice(indexOfDeletedConv)){            
            document.getElementById(convWindow.convId).style.right=Number(document.getElementById(convWindow.convId).style.right.match(/(\d+)(px)/)[1])-283
        }
        console.log(screen.conversationList)
    }
    
}
function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

async function demo(self,convId,serializedData) {
    
    for (let i = 0; i <=1 ; i++) {
        // console.log(`Waiting ${i} seconds...`);
        await sleep(i * 1000);
    }
    self.askedFirstTime=true
    if(self.askedFirstTime){
        // console.log("asked")
        self.askConstantly(convId,serializedData)
    }
}


function askServer(convId,serializedData,idOflastMessege){

    let myId=document.getElementById("smallPostProfileImg")
    myId=myId.getAttribute("href").match(/\/(\d+)/)[1]

    $.ajax({
                
        type: 'GET',
        url: "http://127.0.0.1:8000/conv/"+serializedData+"/"+idOflastMessege,
        dataType:"json",
        // data: {"userAddressee": serializedData},
        success: function (response) {         
                             
            // e.target.value=response['instance']
            let convField=document.getElementById(convId).childNodes[1]
            if(response['empty']==false){
                for(msg of response['instance']){
                    
                    
                    let msgPar=document.createElement('p')
                    msgPar.className="singleMsg w-75 text-wrap"
                    msgPar.style.borderRadius="5px"
                    msgPar.style.backgroundColor="DodgerBlue"
                    msgPar.style.color="white"
                    msgPar.id=msg.messegeId
                    if(myId==msg.authorId){
                        msgPar.style.marginLeft=50
                    }
                
                    msgPar.style.fontSize="10px"
                    msgPar.style.width=50%
                                  
                    convField.appendChild(msgPar)
                    msgPar.innerText=msg.messegeText+"\n"
                    convField.scrollTo(0,convField.scrollHeight)
                }   
            }  else{
               
            } 
        },
        error: function (response) {
            // console.log(response)
        }
    })
}
function findButtonsForSendingMsg(addresseeAccountID,convWindow){

    //checking what type of query should be send to server
    // for(const singleConv of screen.conversationList){
        if(!convWindow.askedFirstTime){
            
            convWindow.askFirstTime(convWindow.convId,convWindow.originalIdOfPerson)
            //singleConv.askedFirstTime=true
        }else{
            convWindow.askConstantly(convWindow.convId,convWindow.originalIdOfPerson)
        }
    // }

    msgBtns=document.querySelectorAll(".sendMsgBtn")
    msgBtns.forEach(msgBtn => {
       
        msgBtn.addEventListener("click",function (e) {
            
            let inputElement=e.target.parentNode.firstChild
            let inputElementVal=inputElement.value

            inputElement.value=""

            e.preventDefault();
            
            // console.log(inputElement)
            var serializedData=addresseeAccountID

            function getCookie(c_name)
            {
                if (document.cookie.length > 0)
                {
                    c_start = document.cookie.indexOf(c_name + "=");
                    if (c_start != -1)
                    {
                        c_start = c_start + c_name.length + 1;
                        c_end = document.cookie.indexOf(";", c_start);
                        if (c_end == -1) c_end = document.cookie.length;
                        return unescape(document.cookie.substring(c_start,c_end));
                    }
                }
                return "";
             }
            $.ajax({
                
                type: 'POST',
                url: "http://127.0.0.1:8000/messege",
                dataType:"json",
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                headers:{"X-CSRFToken":getCookie("csrftoken") },
                data: {"userAddressee": serializedData,"msg":inputElementVal},
                
                success: function (response) {         
                    // console.log(response['instance'])                     
                    // e.target.value=response['instance']
                    // document.getElementById("likes{{post.id}}").innerText="Likes: "+response['likes']
                },
                error: function (response) {
                    // console.log(response)
                }
    });
     })
});
}
