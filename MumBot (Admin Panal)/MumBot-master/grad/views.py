from django.shortcuts import render
from django.urls import include, reverse
from django.http import HttpResponse, HttpResponseRedirect
from itertools import chain
from .models import VideoSession, Parent, Specialist, Admin
from django.contrib.auth import authenticate, login, logout
from datetime import datetime


def index(request):
    if not request.user.is_authenticated:
        return HttpResponseRedirect(reverse("login"))
    else:
        return render(request, "grad/index.html")


def appointments(request):
    return render(request, "grad/appointments.html", {
        "appointments": VideoSession.objects.all(),
    })


def question(request):
    return render(request, "grad/question.html")


def viewuser(request):
    return render(request, "grad/viewuser.html", {
        "all_users": chain(Parent.objects.all(), Specialist.objects.all()),
    })


def edituser(request, id, user_role):
    if user_role == 2:
        return render(request, "grad/edituser.html", {
            "user": Specialist.objects.get(pk=id)
        })
    elif user_role == 3:
        return render(request, "grad/edituser.html", {
            "user": Parent.objects.get(pk=id)
        })
    else:
        pass


def updateuser(request, id, user_role):
    if request.method == "POST":
        if user_role == 2:
            user = Specialist.objects.get(pk=id)
            user.user_name = request.POST["user_name"]
            user.user_email = request.POST["user_email"]
            user.user_phone = request.POST["user_phone"]
            user.specialist_brief = request.POST["user_brief"]
            user.save()
        elif user_role == 3:
            user = Parent.objects.get(pk=id)
            user.user_name = request.POST["user_name"]
            user.user_email = request.POST["user_email"]
            user.user_phone = request.POST["user_phone"]
            user.save()
        return HttpResponseRedirect(reverse("viewuser"))


def deleteuser(request, id, user_role):
    if user_role == 2:
        return render(request, "grad/deleteuser.html", {
            "user": Specialist.objects.get(pk=id)
        })
    elif user_role == 3:
        return render(request, "grad/deleteuser.html", {
            "user": Parent.objects.get(pk=id)
        })
    else:
        pass


def confirmdeleteuser(request, id, user_role):
    if request.method == "POST":
        if user_role == 2:
            user = Specialist.objects.get(pk=id)
            user.delete()
        elif user_role == 3:
            user = Parent.objects.get(pk=id)
            user.delete()
        return HttpResponseRedirect(reverse("viewuser"))


def adduser(request):
    return render(request, "grad/adduser.html")


def addusers(request):
    if request.method == "POST":
        if request.POST["user_type"] == "2":
            user = Specialist(user_role=2, user_name=request.POST["user_name"], user_email=request.POST["user_email"], user_phone=request.POST[
                              "user_phone"], user_password=request.POST["user_pass1"], specialist_brief=request.POST["user_brief"])
            user.save()
        elif request.POST["user_type"] == "3":
            user = Parent(user_role=3, user_name=request.POST["user_name"], user_email=request.POST["user_email"],
                          user_phone=request.POST["user_phone"], user_password=request.POST["user_pass1"])
            user.save()
        return HttpResponseRedirect(reverse("viewuser"))


def login_view(request):
    if request.method == "POST":
        username = request.POST["username"]
        password = request.POST["password"]
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return HttpResponseRedirect(reverse("index"))
        else:
            return render(request, "grad/login.html", {
                "message": "Invalid credentials"
            })
    return render(request, "grad/login.html")


def logout_view(request):
    logout(request)
    return render(request, "grad/login.html", {
        "message": "Logged out."
    })


def editappointment(request, id):
    return render(request, "grad/editappointment.html", {
        "appointment": VideoSession.objects.get(pk=id),
        "newdate": VideoSession.objects.get(pk=id).video_date.strftime("%Y-%m-%d"),
        "newtime": VideoSession.objects.get(pk=id).video_start_time.strftime("%H:%M"),
    })


def editappointmentconfirmation(request, id):
    if request.method == "POST":
        appointment = VideoSession.objects.get(pk=id)
        appointment.video_date = request.POST["date"]
        appointment.video_start_time = request.POST["time"]
        appointment.save()
    return HttpResponseRedirect(reverse("appointments"))
