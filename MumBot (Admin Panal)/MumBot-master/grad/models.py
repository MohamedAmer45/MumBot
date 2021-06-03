from django.db import models

# Create your models here.


class User(models.Model):
    user_password = models.CharField(max_length=32)
    user_name = models.CharField(max_length=25)
    user_phone = models.CharField(max_length=15)
    user_email = models.EmailField(max_length=254)
    user_role = models.IntegerField()


class Parent(User):
    def __str__(self):
        return f"{self.id}"


class Admin(User):
    def __str__(self):
        return f"{self.id}"



class Specialist(User):
    active_status = models.BooleanField(default=0)
    specialist_brief = models.CharField(max_length=500)

    def __str__(self):
        return f"{self.id}"


class SingleInquiry(models.Model):

    parent_id = models.ForeignKey(Parent, on_delete=models.CASCADE, related_name="Chats")
    specialist_id = models.ForeignKey(Specialist, on_delete=models.CASCADE, related_name="Chats")
    inquiry_price = models.FloatField()
    inquire_duration_in_minutes = models.IntegerField()
    inquiry_start_time = models.TimeField(auto_now=False, auto_now_add=False)
    inquiry_end_time = models.TimeField(auto_now=False, auto_now_add=False)

    def __str__(self):
        return f"{self.id}"

class VideoSession(models.Model):

    parent_id = models.ForeignKey(Parent, on_delete=models.CASCADE, related_name="VideoSessions")
    specialist_id = models.ForeignKey(Specialist, on_delete=models.CASCADE, related_name="VideoSessions")
    video_price = models.FloatField(default=50)
    video_duration_in_minutes = models.IntegerField(default= 60)
    video_date = models.DateField(auto_now=False, auto_now_add=False)
    video_start_time = models.TimeField(auto_now=False, auto_now_add=False)
    video_end_time = models.TimeField(auto_now=False, auto_now_add=False)
    
    def __str__(self):
        return f"{self.id}"

class Question(models.Model):

    question_body = models.CharField(max_length=1000)
    question_tags = models.CharField(max_length=200, default="")
    question_date = models.DateTimeField(auto_now=False, auto_now_add=False)
    question_admin = models.ForeignKey(Admin, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.id}"


class Answer(models.Model):

    answer_body = models.CharField(max_length=1000)
    answer_date = models.DateTimeField(auto_now=False, auto_now_add=False)
    answer_specialist = models.ForeignKey(
        Specialist, on_delete=models.CASCADE, related_name="AnsweredQuestions")
    answer_question = models.ForeignKey(Question, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.id}"

class Slots(models.Model):

    schedule_specialist = models.ForeignKey(Specialist, on_delete=models.CASCADE)
    free_day = models.CharField(max_length=20, default="")
    slot_date = models.DateField(auto_now=False, auto_now_add=False, default="2000-01-01")
    slot_start_time = models.TimeField(auto_now=True, auto_now_add=False)
    slot_end_time = models.TimeField(auto_now=True, auto_now_add=False)
    slot_start_time_integer = models.IntegerField(default=0)
    booked = models.BooleanField(default=0)

    def __str__(self):
        return f"{self.id}"

