from django.db import models


# Create your models here.
#Entities listed below -- Relations located at the bottom of the file.
class UserCredentials(models.Model):
	# TODO This should be updated to match our schema. 
	username = models.CharField(max_length = 30)
	password = models.CharField(max_length = 30)

class Symptom(models.Model):
	name = models.CharField(max_length=100)
	sid = models.AutoField(primary_key=True)
	def __str__(self):
		return self.name

class User(models.Model):
	name = models.CharField(max_length=100)
	uid = models.AutoField(primary_key=True)
	gender = models.BooleanField(default=False)
	email = models.EmailField(max_length=254)
	height = models.DecimalField(max_digits=5, decimal_places=2)
	weight = models.DecimalField(max_digits=5, decimal_places=2)
	symptoms = models.ManyToManyField(Symptom, through='SuffersFrom')
	def __str__(self):
		return self.name

class Remedy(models.Model):
	name = models.CharField(max_length=100)
	remid = models.AutoField(primary_key=True)
	purchasable = models.BooleanField(default = False)
	supplier = models.CharField(max_length=100)
	directcost = models.DecimalField(max_digits=9, decimal_places=2, default=0.00)
	def __str__(self):
		return self.name

class Illness(models.Model):
	name = models.CharField(max_length=200)
	illid = models.AutoField(primary_key=True)
	description = models.CharField(max_length=500, default="Description")
	prefgender = models.BooleanField(default=False)
	symptoms = models.ManyToManyField(Symptom, through='Exhibits')
	remedies = models.ManyToManyField(Remedy, through='TreatedBy')
	#Still need Severity, Prevalence, and Type
	def __str__(self):
		return self.name

class Doctor(models.Model):
	name = models.CharField(max_length = 40)
    #potential change
	doctor_id = models.AutoField(primary_key = True)
	rating = models.DecimalField(max_digits = 2, decimal_places=2)
	address = models.CharField(max_length = 60)
	def __str__(self):
    		return self.name

class Rating(modes.Model):
    rating_id = models.AutoField(primary_key = true)
	review = models.CharField(max_length = 500)
	score = models.DecimalField(max_digits = 10, decimal_places = 2)
	uid = models.IntegerField()
	def _str_ (self):
    		return self.name

class InsuranceCompany(models.Model):
    name = models.CharField(max_length = 100)
	insurance_id = models.AutoField(primary_key = true) #auto incremting number for each insurance company.
	def _str_ (self):
    		return self.name

class Order(models.Model):
    order_id = models.AutoField(primary_key = true)
	date = models.DateTimeField(auto_now_add = True)
	user_id = models.IntegerField() #user that purchased the order
	repurchase_date = models.DateTimeField(auto_now_add = True)
	def _str_ (self):
		 	return self.name

class Delivery(models.Model):
    address = models.CharField(max_length = 100)
	delivery_id = models.AutoField(primary_key = true)
	priority = models.IntegerField() # 1 - 10, 1 will be the highest priority.
	def _str_ (self):
    		return self.name

class Payment_Information(models.Model):
    address = models.CharField(max_length=60)
	card_number = models.IntegerField(primary_key = true) #each credit card number will be unique
	def _str_ (self):
    		return self.name

class Auction(models.Model):
    auction_id = models.AutoField(primary_key = true)
	reserve_price = models.DecimalField(max_digits = 5, decimal_places = 2)
	end_date = models.DateField(auto_now_add=True)
	remedy_id = models.IntegerField() #need to know the item that you are purchasing.
	def _str_ (self):
			return self.name

#Below are all the relations of the above entities

class Exhibits(models.Model):
    illness = models.ForeignKey(Illness, on_delete=models.CASCADE)
	symptom = models.ForeignKey(Symptom, on_delete=models.CASCADE)

class TreatedBy(models.Model):
	illness = models.ForeignKey(Illness, on_delete=models.CASCADE)
	remedy = models.ForeignKey(Remedy, on_delete=models.CASCADE)

class SuffersFrom(models.Model):
	user = models.ForeignKey(User, on_delete=models.CASCADE)
	symptom = models.ForeignKey(Symptom, on_delete=models.CASCADE)
	duration = models.DurationField(default=0)

class Remedy_Rating(models.Model):
    rating = models.ForeignKey(Rating, on_delete = models.CASCADE)
	remedy = models.ForeignKey(Remedy, on_delete = models.CASCADE)

class Doctor_Rating(models.Model):
    rating = models.ForeignKey(Rating, on_delete = models.CASCADE)
	doctor = models.ForeignKey(Doctor, on_delete = models.CASCADE)

class Specialist(models.Model):
    doctor = models.ForeignKey(Doctor, on_delete = models.CASCADE)
	illness = models.ForeignKey(Illness, on_delete = models.CASCADE)

class Coverage(models.Model):
    insurance = models.ForeignKey(InsuranceCompany, on_delete = models.CASCADE)
	doctor = models.ForeignKey(Doctor, on_delete = models.CASCADE)

class Cart(models.Model):
    user = models.ForeignKey(User, on_delete = models.CASCADE)
	remedy = models.ForeignKey(Remedy, on_delete = models.CASCADE)

class Order_Delivery(models.Model):
    order = models.ForeignKey(Order, on_delete = models.CASCADE)
	delivery = models.ForeignKey(Delivery, on_delete = models.CASCADE)

class Auction_Delivery(models.Model):
    auction = models.ForeignKey(Auction, on_delete = models.CASCADE)
	delivery = models.ForeignKey(Delivery, on_delete = models.CASCADE)

class Bid(models.Model):
    user = models.ForeignKey(User, on_delete = models.CASCADE)
	auction = models.ForeignKey(Auction, on_delete = models.CASCADE)
	amount = models.DecimalField(max_digits = 10, decimal_places = 2)

class Payment(models.Model):
    payment_information = models.ForeignKey(Payment_Information, on_delete = models.CASCADE)
	user = models.ForeignKey(User, on_delete = models.CASCADE)
	