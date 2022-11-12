from xml.etree.ElementTree import Comment
from django.contrib import admin

# Register your models here.

from .models import Account, Commentt, Conversation,Like, Messege,Post,PostComentee,PostLikee,AccountsRelation
from django.contrib.auth.admin import UserAdmin

from django.contrib import admin
from django.contrib.auth.admin import UserAdmin

from .models import Account,Post

# Register your models here.

class AccountAdmin(UserAdmin):
    
    ordering = ('email',)
    list_display=('email','date_joined','last_login','is_admin','is_staff')
    search_fields=('email',)
    readonly_fields=('id','date_joined','last_login')
    add_fieldsets=(
        (None, {'fields': ('name','surname','dateOfBirth','gender','email','password')}),
    )
    # filter_horizontal=()
    list_filter=()
    fieldsets=()

admin.site.register(Account)
admin.site.register(Post)
admin.site.register(Like)
admin.site.register(Commentt)
admin.site.register(PostComentee)
admin.site.register(PostLikee)
admin.site.register(AccountsRelation)
admin.site.register(Conversation)
admin.site.register(Messege)