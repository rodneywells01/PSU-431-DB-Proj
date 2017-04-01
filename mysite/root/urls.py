from django.conf.urls import url 
from . import views 

urlpatterns = [
	url(r'^$', views.index, name='index'),
	url(r'newaccount/', views.newaccount, name='newaccount'),
	url(r'searchDiseases/', views.searchDiseases, name='searchDiseases'),
	url(r'startDiagnosis/', views.startDiagnosis, name='startDiagnosis'),
	url(r'aboutUs/', views.aboutUs, name='aboutUs'),
	url(r'contact/', views.contact, name='contact'),
	url(r'privacyPolicy/', views.privacyPolicy, name='privacyPolicy'),
	url(r'termsConditions/', views.termsConditions, name='termsConditions'),
]