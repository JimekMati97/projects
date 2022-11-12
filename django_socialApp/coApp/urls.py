from multiprocessing import context
from django.contrib import admin
from django.urls import path
from . import views
from django.views.generic import TemplateView,RedirectView

urlpatterns=[

    path('',views.Home.as_view(), name="home"),
    path('register',views.RegisterView.as_view(),name="register"),
    path('logout',views.Logout.as_view(), name="logout"),
    path('home',views.Home.as_view(),name="home"),
    path('profile/<int:pk>',views.Profile.as_view(), name="profile"),
    path('profile/<int:pk>/create',views.CreatePost.as_view(), name="createPost"),
    path("main",views.MainView.as_view(),name="main"),
    path("login",views.LoginView.as_view(),name="login"),
    path("main/comment/<int:postId>",views.CommentRid.as_view(),name="comRid"),
    path("main/like/<int:postId>",views.LikeRid.as_view(),name="likeRid"),
    path("search",views.SearchContacts.as_view(),name="search"),
    path("search/<int:addressee>",views.SendInvit.as_view(), name="sendIvit"),
    path('notifications/<int:userId>',views.Notifs.as_view(),name="notifs"),
    path('notifications/<int:userId>/relationId/<int:relationId>/accept',views.UpdateSuccessNotif.as_view(),name="acceptInvit"),
    path('notifications/<int:userId>/relationId/<int:relationId>/decline',views.UpdateNotifOnDeclination.as_view(),name="declineInvit"),
    path('conv/<int:userAddressee>/<str:lastMessegeId>',views.MessegeRid.as_view(),name="msgRid"),
    path('messege',views.SaveMsg.as_view())
]
