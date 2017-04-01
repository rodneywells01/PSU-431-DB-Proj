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