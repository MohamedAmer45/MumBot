from django.shortcuts import render
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.views.decorators.csrf import csrf_exempt
from grad import models
from .serializers import *


# Create your views here.
#This gets the parent Id and returns all of its data
@api_view(['GET', ])
def api_parent_view(request, id):
    try:
        parent = models.Parent.objects.get(id=id)
    except models.Parent.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)
        
    serializer = ParentSerializer(parent)
    return Response(serializer.data)

# creates a new parent, needs name, email, password, phone, role (2 for specialist & 3 for parent)
@api_view(['POST', ])
@csrf_exempt
def api_parent_create(request):
    
    parent = models.Parent()
    serializer = ParentSerializer(parent, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# parent update, get parent ID and gets all of the parent's data including the fixed data and the data that needs to be changed
@api_view(['PUT', ])
@csrf_exempt
def api_parent_update(request, id):
    
    parent = models.Parent.objects.get(id=id)
    serializer = ParentSerializer(parent, data=request.data,partial=True)
    data = {}
    if serializer.is_valid():
        serializer.save()
        data["success"] = "Update Successful"
        return Response(data=data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# specialist update, get specialist ID and gets all of the specialist's data including the fixed data and the data that needs to be changed
@api_view(['PUT', ])
@csrf_exempt
def api_specialist_update(request, id):
    
    specialist = models.Specialist.objects.get(id=id)
    serializer = SpecialistSerializer(specialist, data=request.data, partial=True)
    data = {}
    if serializer.is_valid():
        serializer.save()
        data["success"] = "Update Successful"
        return Response(data=data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# Deletes a parent from database, needs parent ID, not needed
@api_view(['DELETE', ])
def api_parent_delete(request, id):
    
    parent = models.Parent.objects.get(id=id)
    operation = parent.delete()
    data = {}
    if operation:
        data["success"] = "Delete Successful"
    else:
        data["failure"] = "Delete Failed"
    return Response(data=data)


# shows specilist data, needs Specialist ID
@api_view(['GET', ])
def api_specialist_view(request, id):
    
    specialist = models.Specialist.objects.get(id=id)
    serializer = SpecialistSerializer(specialist)
    return Response(serializer.data)


# Uselessssss
@api_view(['GET', ])
def api_inquiry_view(request, id):
    
    inquiry = models.SingleInquiry.objects.get(id=id)
    serializer = InquirySerializer(inquiry)
    return Response(serializer.data)


@api_view(['GET', ])
def api_question_view(request, id):
    
    question = models.Question.objects.get(id=id)
    serializer = QuestionSerializer(question)
    return Response(serializer.data)

@api_view(['GET', ])
def api_answer_view(request, id):
    
    answer = models.Answer.objects.get(id=id)
    serializer = AnswerSerializer(answer)
    return Response(serializer.data)


# shows all of the empty slots, needs slot ID.
@api_view(['GET', ])
def api_slot_view(request, id):
    
    slots = models.Slots.objects.filter(schedule_specialist=id)
    serializer = SlotSerializer(slots, many=True)
    return Response(serializer.data)



# Adds new slots, from the parenting specialist app, needs prenting specialist Id, date of the slot, the day of the Slot written as string, start time, end time = start time + 1 hour
@api_view(['POST', ])
@csrf_exempt
def api_slot_create(request):
    
    slot = models.Slots()
    serializer = SlotSerializer(slot, data=request.data)
    
    if serializer.is_valid():
        serializer.save()
        
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# Deletes a slot when the specialist removes an emprty slot from his schedule, needs slot ID
@api_view(['DELETE', ])
def api_slot_delete(request,id):
    
    slot = models.Slots.objects.get(id=id)
    operation = slot.delete()
    data = {}
    if operation:
        data["success"] = "Delete Successful"
    else:
        data["failure"] = "Delete Failed"
    return Response(data=data)


#  updates slot data, mainly to change the status of the slot to booked (boolean) when a parent books it.
@api_view(['PUT', ])
@csrf_exempt
def api_slot_update(request, id):
    
    slot = models.Slots.objects.get(id=id)
    serializer = SlotSerializer(slot, data=request.data, partial=True)
    data = {}
    if serializer.is_valid():
        serializer.save()
        data["success"] = "Update Successful"
        return Response(data=data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# get the id of the specialist to view his active status
@api_view(['GET', ])
def api_status_view(request, id):
    
    status = models.SpecialistActiveStatus.objects.get(specialist_id=id)
    serializer = StatusSerializer(status)
    return Response(serializer.data)


# Views all of the appointments of the parent, needs his ID
@api_view(['GET', ])
def api_parent_appointment_view(request, id):
    
    status = models.VideoSession.objects.get(parent_id=id)
    serializer = AppointmentSerializer(status)
    return Response(serializer.data)

# Views all of the appointments of the specialist, needs his ID

@api_view(['GET', ])
def api_specialist_appointment_view(request, id):
    
    status = models.VideoSession.objects.get(specialist_id=id)
    serializer = AppointmentSerializer(status)
    return Response(serializer.data)



# deletes a certain appointment , needs its ID, and you should turn the slot.booked to 0 using the slot_update
@api_view(['DELETE', ])
def api_appointment_delete(request,id):
    #support this witht the session's id
    appointment = models.VideoSession.objects.get(id=id)
    operation = appointment.delete()
    data = {}
    if operation:
        data["success"] = "Delete Successful"
    else:
        data["failure"] = "Delete Failed"
    return Response(data=data)



# creates a new apointment, needs parent Id, specialist Id (from slot Table), Date, Day in string (ex Saturday), Start time (ex 18:00) end time start + 1 hour

@api_view(['POST', ])
@csrf_exempt
def api_appointment_create(request):
    
    appointment = models.VideoSession()
    serializer =AppointmentSerializer(appointment, data=request.data)
    
    if serializer.is_valid():
        serializer.save()
        
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)    