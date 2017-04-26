from django.db import models
from django.contrib.auth.models import User


# Create your models here.
#Entities listed below -- Relations located at the bottom of the file.

class Symptom(models.Model):
	name = models.CharField(max_length=100)
	sid = models.AutoField(primary_key=True)
	def __str__(self):
		return self.name

class Payment_Information(models.Model):
	paymentid = models.AutoField(primary_key=True, default = '1')
	card_number = models.IntegerField() #each credit card number will be unique
	address = models.CharField(max_length=60)
	def _str_ (self):
    		return self.client.user.username

class Rating(models.Model):
	review = models.CharField(max_length = 500)
	rating_id = models.AutoField(primary_key = True)
	score = models.DecimalField(max_digits = 10, decimal_places = 2)
	def _str_ (self):
    		return self.name

class Remedy(models.Model):
	name = models.CharField(max_length=100)
	remid = models.AutoField(primary_key=True)
	purchasable = models.BooleanField(default = False)
	supplier = models.CharField(max_length=100)
	directcost = models.DecimalField(max_digits=9, decimal_places=2, default=0.00)
	review_list = models.ManyToManyField(Rating, through='Remedy_Rating')
	def __str__(self):
		return self.name

class Illness(models.Model):
	name = models.CharField(max_length=200)
	illid = models.AutoField(primary_key=True)
	description = models.CharField(max_length=500, default="Description")
	prefgender = models.BooleanField(default=False)
	symptoms = models.ManyToManyField(Symptom, through='Exhibits')
	remedies = models.ManyToManyField(Remedy, through='TreatedBy')
	prevalence = models.IntegerField(default=0)
	severity = models.IntegerField(default=0)
	category = models.CharField(max_length=20, default='Common')
	def __str__(self):
		return self.name

class Clients(models.Model):
	#Rather than making our own user model, make a one-to-one relationship with Django's built in user model.
	# We can extend any desired attributes through the related "client" model.
	user = models.OneToOneField(User, on_delete=models.CASCADE)
	shopping_cart = models.ManyToManyField(Remedy, through='Cart')
	#Django's user model includes first and last name, email address, and username.
	uid = models.AutoField(primary_key=True)
	payment = models.OneToOneField(Payment_Information)
	gender = models.BooleanField(default=False)
	height = models.DecimalField(max_digits=5, decimal_places=2, default=0)
	weight = models.DecimalField(max_digits=5, decimal_places=2, default=0)
	symptoms = models.ManyToManyField(Symptom, through='SuffersFrom')
	diagnoses = models.ManyToManyField(Illness, through='Diagnosis')
	def __str__(self):
		return self.user.username

class Doctor(models.Model):
	name = models.CharField(max_length = 40)
    #potential change
	doctor_id = models.AutoField(primary_key = True)
	rating = models.DecimalField(max_digits = 4, decimal_places=2)
	address = models.CharField(max_length = 60)
	def __str__(self):
    		return self.name

class InsuranceCompany(models.Model):
	insurance_id = models.AutoField(primary_key = True) #auto incremting number for each insurance company.
	name = models.CharField(max_length = 100)
	def _str_ (self):
    		return self.name

class Order(models.Model):
	date = models.DateTimeField(auto_now_add = True)
	order_id = models.AutoField(primary_key = True)
	user_id = models.IntegerField() #user that purchased the order
	repurchase_date = models.DateTimeField(auto_now_add = True)
	def _str_ (self):
		 	return self.name

class Delivery(models.Model):
	delivery_id = models.AutoField(primary_key = True)
	address = models.CharField(max_length = 100)
	priority = models.IntegerField() # 1 - 10, 1 will be the highest priority.
	def _str_ (self):
    		return self.name

class Auction(models.Model):
	reserve_price = models.DecimalField(max_digits = 5, decimal_places = 2)
	auction_id = models.AutoField(primary_key = True)
	end_date = models.DateField(auto_now_add=True)
	remedy_id = models.IntegerField() #need to know the item that you are purchasing.
	def _str_ (self):
			return self.name

#Below are all the relations of the above entities

class Exhibits(models.Model):
    symptom = models.ForeignKey(Symptom, on_delete=models.CASCADE)
    illness = models.ForeignKey(Illness, on_delete=models.CASCADE)

class TreatedBy(models.Model):
	remedy = models.ForeignKey(Remedy, on_delete=models.CASCADE)
	illness = models.ForeignKey(Illness, on_delete=models.CASCADE)

class SuffersFrom(models.Model):
	user = models.ForeignKey(Clients, on_delete=models.CASCADE)
	symptom = models.ForeignKey(Symptom, on_delete=models.CASCADE)
	duration = models.DurationField(default=0)

class Remedy_Rating(models.Model):
	remedy = models.ForeignKey(Remedy, on_delete = models.CASCADE)
	rating = models.ForeignKey(Rating, on_delete = models.CASCADE)
	client = models.ForeignKey(Clients, on_delete = models.CASCADE)

class Doctor_Rating(models.Model):
	rating = models.ForeignKey(Rating, on_delete = models.CASCADE)
	doctor = models.ForeignKey(Doctor, on_delete = models.CASCADE)
	client = models.ForeignKey(Clients, on_delete = models.CASCADE)

class Specialist(models.Model):
	illness = models.ForeignKey(Illness, on_delete = models.CASCADE)
	doctor = models.ForeignKey(Doctor, on_delete = models.CASCADE)

class Coverage(models.Model):
	doctor = models.ForeignKey(Doctor, on_delete = models.CASCADE)
	insurance = models.ForeignKey(InsuranceCompany, on_delete = models.CASCADE)

class Cart(models.Model):
	remedy = models.ForeignKey(Remedy, on_delete = models.CASCADE)
	user = models.ForeignKey(Clients, on_delete = models.CASCADE)

class Order_Delivery(models.Model):
	delivery = models.ForeignKey(Delivery, on_delete = models.CASCADE)
	order = models.ForeignKey(Order, on_delete = models.CASCADE)

class Auction_Delivery(models.Model):
	delivery = models.ForeignKey(Delivery, on_delete = models.CASCADE)
	auction = models.ForeignKey(Auction, on_delete = models.CASCADE)

class Bid(models.Model):
	auction = models.ForeignKey(Auction, on_delete = models.CASCADE)
	user = models.ForeignKey(User, on_delete = models.CASCADE)
	amount = models.DecimalField(max_digits = 10, decimal_places = 2)

class Diagnosis(models.Model):
	client = models.ForeignKey(Clients, on_delete = models.CASCADE)
	illness = models.ForeignKey(Illness, on_delete = models.CASCADE)

#class Payment(models.Model):
#	user = models.ForeignKey(Clients, on_delete = models.CASCADE)
#	payment_information = models.ForeignKey(Payment_Information, on_delete = models.CASCADE)
