from django.db import models


# Create your models here.
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

class Doctors(models.Model):
    name = models.CharField(max_length = 40)
	doctor_id = models.AutoField(primary_key=true) #potential change
	rating = models.DecimalField(max_digits=2, decimal_places=2)
	address = models.CharField(max_length = 60)
	def __str__(self):
    		return self.name

#Need to adjust - to fit schema
class Bids(models.Model)
	amount = models.DecimalField(max_digits = 5, decimal_places=2)
	user_id = models.IntegerField(max_length=9)
	auction_id = models.IntegerField(max_length=9)
	#add keys
class Symptoms(models.Models)
	symptom_id = models.IntegerField(max_length=9)
	area_of_body = models.CharField(max_length = 40)
	description = models.CharField(max_length = 200)
	illness_id = models.IntegerField(max_length=9)
	#add keys

class Treatments(models.Models)
	remedy_id = models.DecimalField(max_digits=9, decimal_places=0)
	illness_id = models.IntegerField(max_length=9)
	#add keys.

class Auctions(models.Models)
	auction_id = models.IntegerField(max_length=9)
	reserve_price = models.DecimalField(max_digits=5, decimal_places=2)
	end_date = models.DateTimeField(#add field)
	remedy_id = models.IntegerField(max_length=9)
	#add keys

class Accepted_Insurance(models.Models)
	doctor_id = models.IntegerField(max_length=9)
	insurance_name = CharField(max_length = 40)
	#add key information

class Payment_Information(models.Models)
	address = models.CharField(max_length=60)
	card_number = CharField(max_length=20)
	user_id = IntegerField(max_length= 9)
	#add keys

class Diagnoses(models.Models)
	user_id = models.IntegerField(max_length=9)
	illness_id = models.IntegerField(max_length=9)
	likelihood = models.PositiveIntegerField(max_length=5)
	#add keys.

class Remedy_Ratings(models.Models)
	remedy_id = models.IntegerField(max_length=9)
	rating = models.DecimalField(max_digits=5, decimal_places=2)
	comment = models.CharField(max_length=500)
	user_id = models.IntegerField(max_length=9)
	#add keys.

class Doctor_Ratings(models.Models)
	doctor_id = models.IntegerField(max_length=9)
	rating = models.DecimalField(max_digits=5, decimal_places=2)
	comment = models.CharField(max_length=500)
	#add keys.

class Orders(models.Models)
	order_id = models.IntegerField(max_length=9)
	order_date = models.DateTimeField(#add field)
	user_id = models.IntegerField(max_length=9)
	repurchase_date = models.DateTimeField(#add field)
	#add keys

class Order_Items(models.Models)
	order_id = models.IntegerField(max_length=9)
	remedy_id = models.IntegerField(max_length=9)
	#add keys
class Cart_items(models.Models)
	user_id = models.IntegerField(max_length=9)
	remedy_id = models.IntegerField(max_legth=9)
	#add keys

class Order_Deliveries(models.Models)
	user_id = models.IntegerField(max_length=9)
	order_id = models.IntegerField(max_length=9)
	address = models.CharField(max_length= 60)
	status = models.CharField(max_legth=30)
	#add keys

class Auction_deliveries(models.Models)
	user_id = models.IntegerField(max_length=9)
	auction_id = models.IntegerField(max_length=9)
	address = models.CharField(max_legth=60)
	status = models.CharField(max_length=30)
	#add keys.
