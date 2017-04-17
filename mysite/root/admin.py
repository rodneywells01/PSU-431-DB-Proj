from django.contrib import admin

# Register your models here.
from .models import *
admin.site.register(User)
admin.site.register(Illness)
admin.site.register(Symptom)
admin.site.register(Remedy)
admin.site.register(Exhibits)
admin.site.register(TreatedBy)
admin.site.register(SuffersFrom)
admin.site.register(Doctors)
admin.site.register(Bids)
admin.site.register(Symptoms)
admin.site.register(Treatments)
admin.site.register(Auctions)
admin.site.register(Accepted_Insurance)
admin.site.register(Payment_Information)
admin.site.register(Diagnoses)
admin.site.register(Remedy_Ratings)
admin.site.register(Doctor_Ratings)
admin.site.register(Orders)
admin.site.register(Order_Items)
admin.site.register(Cart_items)
admin.site.register(Order_Deliveries)
admin.site.register(Auction_deliveries)