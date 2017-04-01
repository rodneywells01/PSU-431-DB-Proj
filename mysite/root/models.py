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