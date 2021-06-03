from django.urls import path
from . import views

urlpatterns = [
    path("api/parent/<int:id>/", views.api_parent_view, name="parentdetail"),
    path("api/parent/create/", views.api_parent_create, name="parentcreate"),
    path("api/parent/update/<int:id>/", views.api_parent_update, name="parentupdate"),
    path("api/parent/delete/<int:id>/", views.api_parent_delete, name="parentdelete"),
    path("api/specialist/<int:id>/", views.api_specialist_view, name="specialistdetail"),
    path("api/specialist/update/<int:id>/", views.api_specialist_update, name="specialistupdate"),
    path("api/inquiry/<int:id>/", views.api_inquiry_view, name="inquirydetail"),
    path("api/question/<int:id>/", views.api_question_view, name="questiondetail"),
    path("api/answer/<int:id>/", views.api_answer_view, name="answerdetail"),
    path("api/slot/<int:id>/", views.api_slot_view, name="slotdetail"),
    path("api/slot/create/", views.api_slot_create, name="slotcreate"),
    path("api/slot/delete/<int:id>/", views.api_slot_delete, name="slotdelete"),
    path("api/slot/update/<int:id>/", views.api_slot_update, name="slotupdate"),
    path("api/status/<int:id>/", views.api_status_view, name="statusdetail"),
    path("api/parentappointments/<int:id>/", views.api_parent_appointment_view, name = "parent_appointments"),
    path("api/specialistappointments/<int:id>/", views.api_specialist_appointment_view, name = "specialist_appointments"),
    path("api/appointment/delete/<int:id>/", views.api_appointment_delete, name = "delete_appointments"),
    path("api/appointment/create/", views.api_appointment_create, name = "create_appointment"),


]