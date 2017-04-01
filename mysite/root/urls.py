from django.conf.urls import url 
from . import views 

urlpatterns = [
	url(r'home', views.home, name='home'),
    url(r'remedy_list', views.RemedyListView.as_view(), name='remedy_list'),
    url(r'illness_list', views.IllnessListView.as_view(), name='illness_list'),
    url(r'remid(?P<pk>[0-9]*)/detail/$', views.RemedyDetailView.as_view(), name='remedy_detail'),
    url(r'illid(?P<pk>[0-9]*)/detail/$', views.IllnessDetailView.as_view(), name='illness_detail'),
	url(r'^$', views.index, name='index'),
	url(r'newaccount/', views.newaccount, name='newaccount'),
<<<<<<< HEAD
	url(r'searchDiseases/', views.searchDiseases, name='searchDiseases'),
	url(r'startDiagnosis/', views.startDiagnosis, name='startDiagnosis'),
	url(r'aboutUs/', views.aboutUs, name='aboutUs'),
	url(r'contact/', views.contact, name='contact'),
	url(r'privacyPolicy/', views.privacyPolicy, name='privacyPolicy'),
	url(r'termsConditions/', views.termsConditions, name='termsConditions'),
=======
	url(r'createaccount/', views.createnewaccount, name ='createnewaccount')
>>>>>>> e8c365094186e9f8703ff04aca9245b6c47ced63
]