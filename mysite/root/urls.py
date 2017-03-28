from django.conf.urls import url 
from . import views 

urlpatterns = [
	url(r'^$', views.index, name='index'),
	url(r'newaccount/', views.newaccount, name='newaccount'),
	url(r'createaccount/', views.createnewaccount, name ='createnewaccount')
]