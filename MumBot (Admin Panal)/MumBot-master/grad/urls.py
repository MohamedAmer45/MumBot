from django.urls import path
from django.urls.resolvers import URLPattern
from . import views

urlpatterns = [
    path("", views.index, name="index"),
    path("adduser.html", views.adduser, name="adduser"),
    path("addusers", views.addusers, name="addusers"),
    path("appointments.html", views.appointments, name="appointments"),
    path("question.html", views.question, name="question"),
    path("viewuser.html", views.viewuser, name="viewuser"),
    path("edituser/<int:id>/<int:user_role>/", views.edituser, name="edituser"),
    path("updateuser/<int:id>/<int:user_role>/", views.updateuser, name="updateuser"),
    path("deleteuser/<int:id>/<int:user_role>/", views.deleteuser, name="deleteuser"),
    path("confirmdeleteuser/<int:id>/<int:user_role>/", views.confirmdeleteuser, name="confirmdeleteuser"),
    path("login", views.login_view, name="login"),
    path("logout", views.logout_view, name="logout"),
    path("editappointment/<int:id>/", views.editappointment, name="editappointment"),
    path("editappointmentconfirmation/<int:id>/", views.editappointmentconfirmation, name="editappointmentconfirmation"),


]
