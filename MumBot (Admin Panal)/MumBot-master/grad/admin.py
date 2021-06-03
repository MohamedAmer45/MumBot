from django.contrib import admin

from .models import *

# Register your models here.
admin.site.register(Parent)
admin.site.register(Specialist)
admin.site.register(Admin)
admin.site.register(SingleInquiry)
admin.site.register(VideoSession)
admin.site.register(Question)
admin.site.register(Answer)
admin.site.register(Slots)

