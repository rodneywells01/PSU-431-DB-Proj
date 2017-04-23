from django.contrib import admin

# Register your models here.
from .models import *
admin.site.register(Clients)
admin.site.register(Symptom)
admin.site.register(Remedy)
admin.site.register(Illness)
admin.site.register(Doctor)
admin.site.register(Rating)
admin.site.register(InsuranceCompany)
admin.site.register(Order)
admin.site.register(Delivery)
admin.site.register(Payment_Information)
admin.site.register(Auction)
admin.site.register(Exhibits)
admin.site.register(TreatedBy)
admin.site.register(SuffersFrom)
admin.site.register(Remedy_Rating)
admin.site.register(Doctor_Rating)
admin.site.register(Specialist)
admin.site.register(Coverage)
admin.site.register(Cart)
admin.site.register(Order_Delivery)
admin.site.register(Auction_Delivery)
admin.site.register(Bid)

