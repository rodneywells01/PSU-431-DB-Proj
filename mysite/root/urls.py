from django.conf.urls import url 
from . import views 

urlpatterns = [
    url(r'remedy_list', views.RemedyListView.as_view(), name='remedy_list'),
    url(r'illness_list', views.IllnessListView.as_view(), name='illness_list'),
    url(r'remid(?P<pk>[0-9]*)/detail/$', views.RemedyDetailView.as_view(), name='remedy_detail'),
    url(r'illid(?P<pk>[0-9]*)/detail/$', views.IllnessDetailView.as_view(), name='illness_detail'),
	url(r'^$', views.index, name='index'),
	url(r'newaccount/', views.newaccount, name='newaccount'),
	url(r'searchDiseases/', views.searchDiseases, name='searchDiseases'),
	url(r'startDiagnosis/', views.startDiagnosis, name='startDiagnosis'),
	url(r'diagnosisResults/', views.DiagnosisResultsView.as_view(), name='diagnosisResults'),
	url(r'aboutUs/', views.aboutUs, name='aboutUs'),
	url(r'contact/', views.contact, name='contact'),
	url(r'privacyPolicy/', views.privacyPolicy, name='privacyPolicy'),
	url(r'termsConditions/', views.termsConditions, name='termsConditions'),
	url(r'createaccount/', views.createnewaccount, name ='createnewaccount'),
	url(r'login_user/', views.login_user, name ='login_user'),
	url(r'logout_user/', views.logout_user, name='logout_user'),
	url(r'profile/', views.profile, name='profile'),
	url(r'changePayment/', views.changePayment, name='changePayment'),
	url(r'addToCart/', views.addRemedyToCart, name='addRemedyToCart'),
	url(r'addDiagnosis/', views.addDiagnosis, name='addDiagnosis'),
	url(r'addReview/', views.addReview, name='addReview'),
	url(r'ReviewPage/', views.ReviewPage, name='ReviewPage'),
	url(r'doctor_list/', views.DoctorListView.as_view(), name='doctor_list')
]