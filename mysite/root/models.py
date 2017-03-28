from django.db import models

# Create your models here.
class UserCredentials(models.Model):
	# TODO This should be updated to match our schema. 
	username = models.CharField(max_length = 30)
	password = models.CharField(max_length = 30)

