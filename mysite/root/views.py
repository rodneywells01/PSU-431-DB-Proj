from django.shortcuts import get_object_or_404, render
from django.http import HttpResponse, HttpResponseRedirect
from django.template import loader
from django.urls import reverse 

from root.models import UserCredentials

# Create your views here.
def index(request):	
	template = loader.get_template('root/index.html')
	context = { }
	return HttpResponse(template.render(context, request))

def newaccount(request):
	template = loader.get_template('root/newaccount.html')
	context = { }
	return HttpResponse(template.render(context, request))	

def login(request):
	# Attempt to login the user. 
	pass

def createnewaccount(request):
	# Create a new account in our system. 
	try: 
		username = request.POST["username"]
		password = request.POST["password"] #TODO Needs encryption
		print(username + " " + password)
		# Check to see if username is taken. 
		if len(UserCredentials.objects.filter(username = username)) > 0:
			print("This user has already been inserted into the database!")
		else:
			# Save the user. 
			user = UserCredentials(username = username, password = password)
			user.save(); 
			print("User has been added to the database!")

	except:
		print("Error getting post values")


	print("We hit create new account! Awesome!!")
	template = loader.get_template('root/index.html')
	context = { }
	return HttpResponse(template.render(context, request))