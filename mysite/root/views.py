from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader

# Create your views here.
def index(request):	
	template = loader.get_template('root/index.html')
	context = { }
	return HttpResponse(template.render(context, request))

def newaccount(request):
	template = loader.get_template('root/newaccount.html')
	context = { }
	return HttpResponse(template.render(context, request))	

def searchDiseases(request):
	template = loader.get_template('root/searchDiseases.html')
	context = { }
	return HttpResponse(template.render(context, request))	

def startDiagnosis(request):
	template = loader.get_template('root/startDiagnosis.html')
	context = { }
	return HttpResponse(template.render(context, request))	

def aboutUs(request):
	template = loader.get_template('root/aboutUs.html')
	context = { }
	return HttpResponse(template.render(context, request))	

def contact(request):
	template = loader.get_template('root/contact.html')
	context = { }
	return HttpResponse(template.render(context, request))	