import email
from pyexpat import model
from tkinter import CASCADE
from django.db import models

from django.utils.timezone import now
# Create your models here.
from django.contrib.auth.models import AbstractBaseUser,BaseUserManager, PermissionsMixin
from django.utils.timezone import now
import datetime
from django.utils import timezone

class MyAccountManager(BaseUserManager):

    def create_user(self, email, password=None):

        if not email:
            raise ValueError("Users must have an email address")



        user=self.model(
            email=self.normalize_email(email),
            )
        

        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self,email,password,**kwargs):
        
        user=self.create_user(
            email=self.normalize_email(email),
            password=password,
            )
        user.is_admin=True
        user.is_staff=True
        user.is_superuser=True
        user.save(using=self._db)
        return user


class Account(AbstractBaseUser, PermissionsMixin):

    name=models.CharField(blank=False,error_messages={'required':'Name has to be set'},max_length=20)
    surname=models.CharField(blank=False,max_length=20)
    email=models.EmailField(blank=False,max_length=40,unique=True)
    dateOfBirth=models.DateField(blank=False,max_length=10,null=True)
    gender=models.CharField(blank=False,max_length=10,choices=[('male','male'),('female','female')])
    country=models.CharField(blank=False, max_length=10, choices=[('Poland','Poland'),('England','England')])
    profileImg=models.ImageField(null=True,blank=True, upload_to='')
    is_loggedIn=models.BooleanField(null=False,default=False)
    last_login=models.DateTimeField(verbose_name="last login",auto_now=True)
    date_joined=models.DateTimeField(verbose_name="date joined",auto_now=True) 
    notifications=models.IntegerField(default=0)

    is_admin=models.BooleanField(default=False)
    is_active=models.BooleanField(default=True)
    is_superuser=models.BooleanField(default=False)
    is_staff=models.BooleanField(default=False)

    
    hide_email=models.BooleanField(default=True)

    objects=MyAccountManager()

    USERNAME_FIELD='email'

    def save(self,*args,**kwargs):
        

        if self.gender=="male" and not self.profileImg:
            self.profileImg="maleDef.png"
        elif self.gender=="female" and not self.profileImg:
            self.profileImg="femaleDef.png"
        
        super().save(*args,**kwargs)

    def __str__(self) -> str:
        return self.email

    def has_perm(self,perm,obj=None):
        return True

    def has_module_perms(self,app_label):
        return True

        
class Commentt(models.Model):

    author=models.ForeignKey(Account,on_delete=models.CASCADE)
    text=models.CharField(max_length=200,null=False,blank=True)
    time=models.DateTimeField(default=timezone.now)

    def __str__(self):
        return self.text

class Conversation(models.Model):
    user1=models.ForeignKey(Account,to_field="email", related_name="user1", on_delete=models.CASCADE)
    user2=models.ForeignKey(Account,to_field="email",related_name="user2",on_delete=models.CASCADE)

class Messege(models.Model):
    convId=models.ForeignKey(Conversation,on_delete=models.CASCADE)
    messege=models.CharField(max_length=1000,blank=True,null=False)
    author=models.ForeignKey(Account,on_delete=models.CASCADE)
    time=models.DateTimeField(default=timezone.now)

class Like(models.Model):

    author=models.ForeignKey(Account,on_delete=models.CASCADE)
    time=models.DateTimeField(default=timezone.now)

    def __str__(self) -> str:
        return f"From:{self.author.name}"


class Post(models.Model):

    title=models.CharField(max_length=100,null=False,blank=True)
    body=models.CharField(max_length=1000,null=False,blank=True)
    author=models.ForeignKey(Account,on_delete=models.CASCADE)
    comments=models.ManyToManyField(Commentt,through='PostComentee')
    likes=models.ManyToManyField(Like,through='PostLikee')
    time=models.DateTimeField(default=timezone.now)


    def __str__(self):
        return self.title

class PostComentee(models.Model):
    comment=models.ForeignKey(Commentt,on_delete=models.CASCADE)
    post=models.ForeignKey(Post,on_delete=models.CASCADE)
    time=models.DateTimeField(default=timezone.now)


class PostLikee(models.Model):
    post=models.ForeignKey(Post,on_delete=models.CASCADE)
    like=models.ForeignKey(Like,on_delete=models.CASCADE)
    time=models.DateTimeField(default=timezone.now)

class AccountsRelation(models.Model):
    
    sender=models.ForeignKey(Account,to_field="email", related_name="sender", on_delete=models.CASCADE)
    addressee=models.ForeignKey(Account,to_field="email",related_name="addressee",on_delete=models.CASCADE)
    date_of_relation_est=models.DateTimeField(auto_now=True)
    verified=models.CharField(max_length=40,blank=False,null=False,default="noResponse", choices=[("noResponse","noResponse"),("rejected","rejected"),("accepted","accepted")])
    senderInformed=models.CharField(max_length=10, null=False,blank=True, choices=[('yes',True),('no',False)],default="no")
    addresseeInformed=models.CharField(max_length=10, null=False,blank=True, choices=[('yes',True),('no',False)],default="no")
    dateOfSending=models.DateTimeField(null=True,editable=True)

    def save(self, *args, **kwargs):

        from django.utils import timezone
        ''' On save, update timestamps '''
        
        if not self.id:
            self.dateOfSending = timezone.now()
        self.dateOfSending = timezone.now()
        return super(AccountsRelation, self).save(*args, **kwargs)
