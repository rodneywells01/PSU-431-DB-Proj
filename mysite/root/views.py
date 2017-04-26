from django.shortcuts import get_object_or_404, render, HttpResponseRedirect
from django.http import HttpResponse, HttpResponseRedirect
from django.template import loader, Context
from django.urls import reverse
from .models import *
from django.views import generic
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User

import operator, traceback
from functools import reduce

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

def privacyPolicy(request):
	template = loader.get_template('root/privacyPolicy.html')
	context = { }
	return HttpResponse(template.render(context, request))	

def termsConditions(request):
	template = loader.get_template('root/termsConditions.html')
	context = { }
	return HttpResponse(template.render(context, request))

def login_user(request):
	# Attempt to login the user.
    username = request.POST['username']
    password = request.POST['password']
    print("Looking to authenticate user: " + username)
    user = authenticate(username=username, password=password)
    if user is not None:
        login(request, user)
        # Redirect to a success page.
        # User profile .../profile/uid=?
        return HttpResponseRedirect('/')
    else:
        # Return an 'invalid login' error message.
        # ...
        return HttpResponseRedirect('/')

def logout_user(request):
	# Attempt to logout the user
    logout(request)
    print("Logging out")
    return HttpResponseRedirect('/')

def createnewaccount(request):
	# Create a new account in our system. 
	try: 
		username = request.POST["username"]
		password = request.POST["password"] #TODO Needs encryption
		email = request.POST["email"]
		first_name = request.POST["firstname"]
		last_name = request.POST["lastname"]
		print(username + " " + password)
		user = User.objects.create_user(username, email, password)
		user.first_name = first_name
		user.last_name = last_name
		user.save()
		height = request.POST["height"]
		payment = Payment_Information(card_number = 0, address="default")
		payment.save()
		client = Clients(user=user, payment = payment)
		client.height = height
		client.save()
	except:
		tb = traceback.format_exc()
		return HttpResponse(tb)

	print("We hit create new account! Awesome!!")
	template = loader.get_template('root/index.html')
	context = { }
	return HttpResponseRedirect("/")
	# return index(request);

class IllnessListView(generic.ListView):
	template_name = 'root/illness_list.html'
	context_object_name = 'illness_list'

	def get_queryset(self):
		"""Illness List."""
		# Put 'more likely' illnesses at the top.
		result = Illness.objects.order_by('illid')
		query = self.request.GET.get('q')
		prevalence_upper_bound = self.request.GET.get('prevalence_upper_bound')
		prevalence_lower_bound = self.request.GET.get('prevalence_lower_bound')
		severity_upper_bound = self.request.GET.get('severity_upper_bound')
		severity_lower_bound = self.request.GET.get('severity_lower_bound')
		if query:
			result = result.filter(name__icontains=query)
		if prevalence_upper_bound:
			result = result.filter(prevalence__lte=prevalence_upper_bound)
			result = result.filter(prevalence__gte=prevalence_lower_bound)
		if severity_upper_bound:
			result = result.filter(severity__lte=severity_upper_bound)
			result = result.filter(severity__gte=severity_lower_bound)
		return result

class DiagnosisResultsView(generic.ListView):
	template_name = 'root/diagnosisResults.html'
	context_object_name = 'symptom_search'
	def get_queryset(self):
		"""Symptom Search"""
		result = Illness.objects.order_by('-prevalence')
		query = self.request.GET.get('q')
		if query:
			result = result.filter(exhibits__symptom__name__icontains=query)
		return result

class RemedyListView(generic.ListView):
    template_name = 'root/remedy_list.html'
    context_object_name = 'remedy_list'

    def get_queryset(self):
        """Remedy List."""
        remedies = Remedy.objects.all()
        query = self.request.GET.get('q')
        if query:
            remedies = remedies.filter(treatedby__illness__illid=query)
        return remedies

class RemedyDetailView(generic.DetailView):
    model = Remedy
    template_name = 'root/remedy_detail.html'

class IllnessDetailView(generic.DetailView):
    model = Illness
    template_name = 'root/illness_detail.html'

def profile(request):
	template = loader.get_template('root/profile.html')
	remedies = Remedy.objects.all()
	username = request.user.username
	remedies = remedies.filter(cart__user__user__username=username)
	illnesses = Illness.objects.all()
	illnesses = illnesses.filter(diagnosis__client__user__username=username)
	orders = Order.objects.all()
	orders = orders.filter(client__user__username=username)
	context = Context({"shopping_cart": remedies, "diagnoses": illnesses, "orders": orders})
	return HttpResponse(template.render(context, request))	

def changePayment(request):
	try:
		client = request.user.clients
		creditcard = request.POST.get("cardnumber")
		address = request.POST.get("address")
		client.payment.card_number = creditcard
		client.payment.address = address
		client.payment.save()
	except:
		tb = traceback.format_exc()
		return HttpResponse(tb)
	return HttpResponseRedirect("/profile")

def addRemedyToCart(request):
	query = request.GET.get('q')
	remedy=Remedy.objects.all()
	remedy=remedy.get(remid=query)
	try:
		client = request.user.clients
		shopping_cart=Cart(user=client, remedy=remedy)
		print("Cart retrieved")
		shopping_cart.save()
		#TODO: Add desired remedy to this relation
	except:
		tb = traceback.format_exc()
		return HttpResponse(tb)
	return HttpResponseRedirect("/profile")

def addDiagnosis(request):
	query = request.GET.get('q')
	illness=Illness.objects.all()
	illness=illness.get(illid=query)
	try:
		client = request.user.clients
		diagnosis=Diagnosis(client=client, illness=illness)
		print("Diagnosis saved")
		diagnosis.save()
	except:
		tb = traceback.format_exc()
		return HttpResponse(tb)
	return HttpResponseRedirect("/profile")

def addReview(request):
	review = request.GET.get('review')
	score = request.GET.get('score')
	doctor_id = request.GET.get('doctor_id')
	remedy_id = request.GET.get('remedy')
	print(score)
	print(review)
	client = request.user.clients
	rating = Rating(review = review, score = score)
	rating.save()
	if(remedy_id):
		remedy = Remedy.objects.all()
		remedy = remedy.get(remid=remedy_id)
		review = Remedy_Rating(remedy=remedy, rating=rating, client=client)
		review.save()
		return HttpResponseRedirect("/remid"+remedy_id+"/detail/")
	if(doctor_id):
		doctor = Doctor.objects.all()
		doctor = doctor.get(doctor_id=doctor_id)
		review = Doctor_Rating(doctor=doctor, rating=rating, client=client)
		review.save()
		return HttpResponseRedirect("/doctor_id"+doctor_id+"/detail/")

def ReviewPage(request):
	remedy_id = request.GET.get('remid')
	doctor_id = request.GET.get('doctor_id')
	if(remedy_id):
		remedy_ratings = Remedy_Rating.objects.all()
		remedy_ratings = remedy_ratings.filter(remedy_id=remedy_id)
		context=Context({"review_list": remedy_ratings})
		template = loader.get_template('root/ratings.html')
		return HttpResponse(template.render(context, request))
	if(doctor_id):
		doctor_ratings = Doctor_Rating.objects.all()
		doctor_ratings = doctor_ratings.filter(doctor_id=doctor_id)
		context=Context({"doctor_review_list": doctor_ratings})
		template = loader.get_template('root/ratings.html')
		return HttpResponse(template.render(context, request))


class DoctorListView(generic.ListView):
    template_name = 'root/doctor_list.html'
    context_object_name = 'doctor_list'

    def get_queryset(self):
        """Doctor List."""
        remedies = Doctor.objects.all()
        query = self.request.GET.get('q')
        if query:
            remedies = remedies.filter(specialist__illness__illid=query)
        return remedies

class DoctorDetailView(generic.DetailView):
    model = Doctor
    template_name = 'root/doctor_detail.html'