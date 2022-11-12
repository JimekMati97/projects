from datetime import datetime, tzinfo
from decimal import ROUND_DOWN, Decimal
import email
from email import message
from email.message import Message
from http.client import HTTPResponse
import math
from multiprocessing import context, get_context
from nis import match
import re
from time import timezone
from urllib import request
from wsgiref import validate
from django.views.generic import ListView
from django.views.generic import TemplateView,RedirectView, FormView, CreateView,DetailView,UpdateView,DeleteView
from re import template
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import get_object_or_404, render
from django.shortcuts import render
from django.shortcuts import render, redirect
from django.views import View
from .models import Account, AccountsRelation, Commentt, Conversation, Like, Post, PostComentee, PostLikee, Messege
from .forms import AccountAuthenticationForm, PostAddingForm, RegisterForm, CommentForm, LikeForm, RegisterForm, SearchForm
from django.contrib.auth import authenticate, login, logout
import datetime
from django.http import JsonResponse
from django.core import serializers
from django.contrib import messages
from django.db.models import Q


class LikeRid(RedirectView):
    pattern_name="main"

    def dispatch(self, request,*args, **kwargs):
             
        author=self.request.user

        post=get_object_or_404(Post,pk=kwargs['postId'])
        
        print(post)
        if request.POST.get('liked')=="Like":
            
            Like.objects.create(author=author)

            lastAddedLike=Like.objects.filter(author=author).order_by("-time")
            #print(lastAddedLike)
        
            PostLikee.objects.create(post=post,like=lastAddedLike[0])

            likesQ=PostLikee.objects.filter(post=post).count()
            return JsonResponse({"instance": "Unlike",'likes':likesQ})
        else:
            postlike=PostLikee.objects.filter(post=post).filter(like__author=author).first()

            Like.objects.filter(id=postlike.like.id).delete()
        
            likesQ=PostLikee.objects.filter(post=post).count()

            return JsonResponse({"instance": "Like",'likes':likesQ})


class MainView(TemplateView):

    from inspect import getmembers
    from pprint import pprint
    from django import template

    template_name="main.html"
    #form_class=CommentForm
    #success_url="/main/comment/postId"
    def get(self,request,*args,**kwargs):
        
        commentForm=CommentForm
        likeForm=LikeForm
        from itertools import chain
        context=dict()
        # context['posts']=Post.objects.filter(Q(author=self.request.user.id)|Q(author__in = AccountsRelation.objects.filter((Q(sender=request.user)|Q(addressee=request.user))
        # &Q(verified="accepted")).values('addressee')))

        addresseePosts=Post.objects.filter(Q(author=self.request.user.id)|Q(author__email__in = AccountsRelation.objects.filter((Q(sender=request.user))
        &Q(verified="accepted")).values('addressee'))).order_by("-time")

        senderPosts=Post.objects.filter(Q(author__email__in = AccountsRelation.objects.filter((Q(addressee=request.user))
        &Q(verified="accepted")).values('sender'))).order_by("-time")
        
        context['posts']=list(chain(addresseePosts,senderPosts))

        accountsRelations=AccountsRelation.objects.filter(Q(verified="accepted")&(Q(sender=request.user)|Q(addressee=request.user))).values('addressee','sender')
        accountList=list(list(el.values()) for el in accountsRelations)
        accounts=set()
        for accountPair in accountList:
            for account in accountPair:
                accounts.add(account)

        #removing self from set
        if request.user.email in accounts:
            accounts.remove(request.user.email)
        context['activeFriends']=Account.objects.filter(email__in=accounts)
        # print(accounts)
        context['notifs']=AccountsRelation.objects.filter((Q(sender=request.user)&(Q(verified="accepted")|Q(verified="rejected"))&Q(senderInformed="no"))|
        Q(addressee=request.user)&Q(addresseeInformed="no")&Q(verified="noResponse")).count()
        print( context['notifs'])
        for post in context['posts']:
            
             likedOrNot=PostLikee.objects.filter(post=post).filter(like__author=self.request.user.id)
             if len(likedOrNot)>0:
                 post.liked=True
             else:
                post.liked=False
            
        # for post in context['posts']:
        #     MainView.parseTime(post)

        return self.render_to_response({'commentForm':commentForm,"likeForm":likeForm,"posts":context['posts'],'notifs':context['notifs'],'activePeople':context['activeFriends']})
    


    def post(self,request,*args,**kwargs):
        

        if request.POST.get('form_type')=='commentType':
        
                form=CommentForm(self.request.POST)
                if form.is_valid():
                    text=form.cleaned_data['text']
                    instance=form.save(commit=False)
                    instance.author=self.request.user
                    instance.save()

                    lastAddedComment=Commentt.objects.filter(author=instance.author).order_by("-time")
                    post=get_object_or_404(Post,pk=kwargs['postId'])
                    PostComentee.objects.create(post=post,comment=lastAddedComment[0])
                    return redirect("main")
                else:
                    return render("main.html")

        elif request.POST.get('form_type')=='likeType':

            if self.request.method == "POST":
                form =LikeForm
                if form.is_valid(self):
                    instance = form.save()
                    ser_instance = serializers.serialize('json', [ instance, ])
                    # send to client side.
                    return JsonResponse({"instance": ser_instance}, status=200)
                else:
                    return JsonResponse({"error": form.errors}, status=400)

            return JsonResponse({"error": ""}, status=400)



    

    @staticmethod
    def parseTime(post):
        
        import itertools as i
        from django.utils import timezone

        timestamp=timezone.localtime()
        
        timeDiffAfterPub=timestamp-post.time
       
        validTime=dict()
        #check if post has been added more than 24 hours late

        if "day" in str(timeDiffAfterPub) or "days" in str(timeDiffAfterPub):
            
            import re
        
            pattern=re.compile("([0-9]+ (?:day|year|month|days))")
            matches=pattern.findall(str(timeDiffAfterPub))
            timeCounterAndItsType=tuple(matches[0].split(" "))

            
            dayCount=int(timeCounterAndItsType[0])

            if dayCount>30 and dayCount<=365:
                validTime.setdefault("month",math.floor(dayCount/30))
                
            elif dayCount>365:
                validTime.setdefault("year",math.floor(dayCount/365))

            else:
                validTime.setdefault("day",dayCount)
                
        else:
            timePeriods=("hour","minute","second")
            dividedTime=list(int(round(float(el))) for el in str(timeDiffAfterPub).split(":"))

            pairs=i.zip_longest(timePeriods,dividedTime)
            
            usedTimePeriods=i.dropwhile(lambda a:a[1]==0,pairs)
            firstUsedTimePeriods=list(usedTimePeriods)[:1]
           
            validTime.setdefault(firstUsedTimePeriods[0][0],firstUsedTimePeriods[0][1])

        validTime=list(validTime.items())
        
        #checking if index schould be plural
        key=validTime[0][0]
        if validTime[0][1]>1:
            key=validTime[0][0]+"s"

        modifiedTimeKey=(key,validTime[0][1])
      
        #update
        post.timestamp={modifiedTimeKey[0]:modifiedTimeKey[1]}
        

    def form_valid(self,form):       
        
        return super().form_valid(form)

class CommentRid(RedirectView):


    url="/main"

    def get_redirect_url(self, *args, **kwargs):
        
        text=self.request.POST['text']
        author=self.request.user
        post=get_object_or_404(Post,pk=kwargs['postId'])
        #insert into comment model
        Commentt.objects.create(text=text,author=author)
        lastAddedComment=Commentt.objects.filter(author=author).order_by("-time")[0]
       
        PostComentee.objects.create(post=post,comment=lastAddedComment)

        return super().get_redirect_url(*args, **kwargs)

#opening conversation
class MessegeRid(RedirectView):

    url="/main"

    def get(self, *args, **kwargs):
        
        addresse=kwargs.get("userAddressee")
        idOfLastAddedMsg=kwargs.get("lastMessegeId")
        # firstRequest=kwargs.get("isFirstReq")
        me=self.request.user
        #verify if conversation exists
        conv=Conversation.objects.filter((Q(user1=me)&Q(user2__id=addresse))|(Q(user1__id=addresse)&Q(user2=me)))
        if(len(conv)>0):
            
            
        
            #insert into comment model
            
            if idOfLastAddedMsg=="-1":
                messages=Messege.objects.filter(convId=conv[0].id).values_list("id","author","messege").order_by("time")
            else:
                messages=Messege.objects.filter(convId=conv[0].id,id__gt=idOfLastAddedMsg).values_list("id","author","messege").order_by("time")
            new=[]
            def convert(tup,dict):
                for indx,val in tup:
                    dict.setdefault(indx,val)
                return dict
            
            dictionary={}
            msgObjKeys=("messegeId","authorId","messegeText")
            
            for msgObj in messages:
                dictCopy=dictionary.copy()
                new.append(convert(list(zip(msgObjKeys,msgObj)),dictCopy))
            print(new)
            #dopisac procedure błędu
            return JsonResponse({"instance": new,"empty":False}, status=200)
        else:
            return JsonResponse({"empty":True}, status=200)

        
class SaveMsg(RedirectView):
    
    url="/main"

    def post(self,*args,**kwargs):

        addresse=self.request.POST.get("userAddressee")
        message=self.request.POST.get("msg")
        me=self.request.user
        # print(me,addresse)
        # conv=Conversation.objects.filter((Q(user1=me)&Q(user2__id=addresse))|(Q(user1__id=addresse)&Q(user2=me)))
        # #insert into comment model
       
        # Messege.objects.create(convId=conv[0],author=me,messege=message)
        # return JsonResponse({"instance": "sent"}, status=200)
    
        global conv2
        conv2=Conversation.objects.filter((Q(user1=me)&Q(user2__id=addresse))|(Q(user1__id=addresse)&Q(user2=me)))
        #sprawdzić
        
        if len(conv2)==0:
            addressee=Account.objects.filter(id=addresse)
            print("xd",addresse)
            Conversation.objects.create(user1=me,user2=addressee[0])
            conv2=Conversation.objects.filter((Q(user1=me)&Q(user2__id=addresse))|(Q(user1__id=addresse)&Q(user2=me)))
            print(conv2)
        #insert into comment modeli
       
        Messege.objects.create(convId=conv2[0],author=me,messege=message)
        return JsonResponse({"instance": "sent"}, status=200)

class RegisterView(CreateView):

    template_name="register.html"
    form_class=RegisterForm
    success_url="/login"
    
    def form_valid(self,form):
        form.save()
        messages.success(self.request,'Account was created for ' + form.cleaned_data.get('name')+ " "+ form.cleaned_data.get('surname'))
        return super().form_valid(form)
    

class LoginView(FormView):

    template_name="login.html"
    form_class=AccountAuthenticationForm
    success_url="/main"

    def form_valid(self,form):
        
        email=form.cleaned_data['email']
        password=form.cleaned_data['password']
        
        user=authenticate(email=email,password=password)

        if user is not None:
          
            login(self.request, user)
            Account.objects.filter(id=self.request.user.id).update(is_loggedIn=True)
            return super().form_valid(form)
        else:
         
            return super().form_invalid(form)


class Logout(View):
    
    def get(self,request):
        Account.objects.filter(id=request.user.id).update(is_loggedIn=False)
        logout(request)
        
        return redirect('home')

class Home(TemplateView):

    model=Post
    template_name="home.html"
    
    def get_context_data(self, **kwargs):
        context=super().get_context_data(**kwargs) 
        context["data"]={1,2,3,4,5}
        return context

class Profile(ListView):
    
    template_name="profile.html"
    context_object_name="posts"

    
    def get_context_data(self, **kwargs):

        context= super().get_context_data(**kwargs)
        context['posts']=Post.objects.filter(author=self.request.user.id)
        context['commentForm']=CommentForm
        return context

    def get_queryset(self):
        self.queryset=Post.objects.filter(author=self.request.user.id)
        return super().get_queryset()

    def post(self,request,*args,**kwargs):
    

        if request.POST.get('form_type')=='commentType':
        
                form=CommentForm(self.request.POST)
                if form.is_valid():
                    text=form.cleaned_data['text']
                    instance=form.save(commit=False)
                    instance.author=self.request.user
                    instance.save()
                    return redirect("main")
                else:
                    return render("main.html")

        elif request.POST.get('form_type')=='likeType':

            if self.request.method == "POST":
                form =LikeForm
                if form.is_valid(self):
                    instance = form.save()
                    ser_instance = serializers.serialize('json', [ instance, ])
                    # send to client side.
                    return JsonResponse({"instance": ser_instance}, status=200)
                else:
                    return JsonResponse({"error": form.errors}, status=400)

            return JsonResponse({"error": ""}, status=400)
    
class CreatePost(CreateView):

    template_name="createPost.html"
    form_class=PostAddingForm
    success_url="/main"
    

    def form_valid(self, form):
        instance=form.save(commit=False)
        instance.author=self.request.user
        instance.save()
        return super().form_valid(form)
class Notifs(ListView):

    template_name="notifications.html"
    context_object_name="notifList"

    def get_queryset(self):
        self.queryset=AccountsRelation.objects.filter((Q(sender=self.request.user)&(Q(verified="accepted")|Q(verified="rejected"))&Q(senderInformed="no"))|
        Q(addressee=self.request.user)&(Q(addresseeInformed="no")|Q(addresseeInformed="yes"))&Q(verified="noResponse"))
        import copy
        query=super().get_queryset()
        query2=copy.copy(query)
     
        AccountsRelation.objects.filter(Q(sender=self.request.user)&(Q(verified="accepted")|Q(verified="rejected"))&Q(senderInformed="no")).update(senderInformed="yes")
        AccountsRelation.objects.filter(Q(addressee=self.request.user)&(Q(verified="noResponse"))&Q(senderInformed="no")).update(addresseeInformed="yes")


        return query2

class UpdateNotifOnDeclination(RedirectView):

    #url="/search"

    def get_redirect_url(self, *args, **kwargs):
     
        AccountsRelation.objects.filter(id=kwargs.get('relationId')).update(verified="rejected",addresseeInformed="yes")
        
        self.url="/notifications/"+str(self.request.user.id)
        return super().get_redirect_url(*args, **kwargs)

class UpdateSuccessNotif(RedirectView):

    #url="/search"

    def get_redirect_url(self, *args, **kwargs):
     
        AccountsRelation.objects.filter(id=kwargs.get('relationId')).update(verified="accepted",addresseeInformed="yes")
        
        self.url="/notifications/"+str(self.request.user.id)
        return super().get_redirect_url(*args, **kwargs)
    

class SearchContacts(FormView):

    template_name="search.html"
    form_class=SearchForm
    success_url="search"
    
    # def get_context_data(self, **kwargs):
    #     context= super().get_context_data(**kwargs)
    #     username=self.request.POST.get('contact')
    #     context['contacts']=Account.objects.filter(Q(email__startswith=username)|Q(email__contains=username))
    #     return context
    
    # def form_valid(self,form):
    #     username=form.cleaned_data['contact']
    #     accounts=Account.objects.filter(Q(email_startswith=username)|Q(email_contains=username))
    def post(self,request):
        username=request.POST.get('contact')
        accounts=Account.objects.filter(Q(email__startswith=username)|Q(email__contains=username)).exclude(email=request.user.email)
        # --> filter AccounsRel(context)
        listOfUsers=[]
        for account in accounts:     
            #checking what type of relation are we connected with found account
            singleRelationOfFoundAccount=AccountsRelation.objects.filter(Q(sender=account) & Q(addressee=request.user)|Q(sender=request.user) & Q(addressee=account))
            if len(singleRelationOfFoundAccount)==0:
                listOfUsers.append((account,"Send Invitation"))
            else:
                listOfUsers.append((account,singleRelationOfFoundAccount[0]))
        print(listOfUsers)
        return render(request,"search.html",{'contacts':listOfUsers,'form':self.form_class})
    
class SendInvit(RedirectView):
    url="/search"

    def get_redirect_url(self, *args, **kwargs):
     
        sender=self.request.user
        addressee=Account.objects.get(pk=kwargs.get("addressee"))
        AccountsRelation.objects.create(sender=sender,addressee=addressee)
        messages.success(self.request,'Invitation sent to ' + addressee.email)
        return super().get_redirect_url(*args, **kwargs)


class DeletePost(DeleteView):
    pass
class UpdatePost(UpdateView):
    pass
    # def get_queryset(self):
    #     kwargs=self.get_form_kwargs()
    #     user=Account.objects.filter(email=kwargs.get('username'))
    #     self.queryset=Post.objects.filter(author=user).order_by("-time",)
    #     print(self.queryset)
    #     return super().get_queryset()

    # def get_form_kwargs(self):
    #     return super().get_form_kwargs()

    # def get_context_data(self, **kwargs):
    #     context= super().get_context_data(**kwargs)
    #     user=Account.objects.filter(email=kwargs.get('username'))
    #     posts=Post.objects.filter(author=user).order_by("-time",)

    #     context['posts']=posts
    #     #print(context)
    #     return context

    # def get(self,request,**kwargs):
    #     accountDetails=request.user
    #     posts=Post.objects.filter(author=request.user).order_by("-time",)
        #friends=AccountsRelation.objects.filter((Q(sender=request.user)|Q(addressee=request.user) & Q(verified="accepted"))).count()
        # if AccountsRelation.objects.filter(account=request.user.id).exists():
        #     friends_Ids=AccountsRelation.objects.filter(account=request.user.id)
        #     context=None
        #     friends=[]
        #     for friendId in friends_Ids:
        #         friends.append(Account.objects.filter(id=friendId.account_related_to)[0].name)
        #     if friends is not None:
        #         context=friends
        #     else:
        #         context="make some"

        #return render(request,"profile.html",{"accountDetails":accountDetails,"posts":posts,"friendsCount":friends})
        #return render(request,"profile.html",{"accountDetails":accountDetails,"posts":posts})

# def main(request):

#     if request.method=="POST":
#         form=DateForm(request.POST)
#         if form.is_valid():
#             import datetime
#             wpisanaData=request.POST['date']

#             newDate=datetime.datetime.now()
          
#             tz_pl=newDate.astimezone(pytz.timezone('Poland'))

#             print(tz_pl.second)
#             return render(request,"home.html",{'form':form})
#     else:
#         form=DateForm()
        
#     return render(request,"home.html",{'form':form})
