from dataclasses import fields
from urllib import request
from django.contrib.auth.forms import UserCreationForm
from distutils.command.clean import clean
from distutils.command.upload import upload
import email
from xml.dom import ValidationErr
from django import forms
from datetime import date, datetime
from django.forms import DateField, ModelForm, PasswordInput, ValidationError
from django.utils.translation import gettext_lazy as _
from django.contrib.auth import authenticate
from django.contrib.auth import authenticate, login, logout

from coApp.models import Account, Commentt, Like, Account, Post

class RegisterForm(UserCreationForm,forms.ModelForm):

    confirmChbx=forms.BooleanField(error_messages={'required':'You have to agree with us..'},label="Policy of our servise")


    class Meta:

        BIRTH=list(year for year in range(1900,2022))

        model=Account
        
        fields=('email','password1','password2','country','gender','name','surname','dateOfBirth','profileImg')
        labels={
            'dateOfBirth':'Date Of Birth',
            'profileImg':'Set your Profile Image'
        }
        widgets={
            'name':forms.TextInput(attrs={"class":"form-control",'id':"name","placeholder":"Name"}),
            'surname':forms.TextInput(attrs={"class":"form-control","id":"surname","placeholder":"Surname"}),
            'email':forms.EmailInput(attrs={"class":"form-control","placeholder":"Email","id":"email"}),
            'dateOfBirth':forms.SelectDateWidget(years=BIRTH),
            'country':forms.Select(attrs={'class':'country_opt'}),
            'password1':forms.PasswordInput(attrs={"class":"form-control","placeholder":"Password"}),
            'profileImg':forms.ClearableFileInput(attrs={"class":"form-control"})
        }

    def clean_dateOfBirth(self):
        date=self.cleaned_data.get('dateOfBirth')
        if date.year>=2004:
            raise ValidationError(
                ('%(exep)s means, that you have less than 18 years old.'),
                params={'exep':date}
            )
        else:
            return date


class AccountAuthenticationForm(forms.Form):
    
    password=forms.CharField(label="Password",widget=forms.PasswordInput(attrs={"class":"form-control","placeholder":"password"}))
    email=forms.EmailField(label="Email",widget=forms.EmailInput(attrs={"class":"form-control","placeholder":"email"}))

                
class PostAddingForm(forms.ModelForm):
    class Meta:
        model=Post
        fields=("body","title")
        widgets={
            "title":forms.TextInput(attrs={"class":"form-control"}),
            "body":forms.Textarea(attrs={"class":"postTextarea w-100","placeholder":"What's on your mind.."}),
            #"author":forms.TextInput(attrs={"class":"userId","value":"xd"}),
        }
class SearchForm(forms.Form):
    contact=forms.CharField(max_length=50,widget=forms.TextInput(attrs={"class":"form-control mb-4","placeholder":"Find a person"}))
    
class CommentForm(forms.ModelForm):
    class Meta:

        model=Commentt
        fields=("text",)
        labels={
            "text":"Add a comment"
        }

        widgets={
            'text':forms.TextInput(attrs={"class":"commentInput w-100","placeholder":"comment"})
        }

class LikeForm(forms.ModelForm):

    hidden=forms.BooleanField.hidden_widget(attrs={"class":"likedOrNot","value":False,"name":"likedOrNot"})

    class Meta:
        model=Like
        fields=("author",)
