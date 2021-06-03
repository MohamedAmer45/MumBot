from rest_framework import serializers
from grad import models

class ParentSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'user_name',
            'user_password',
            'user_email',
            'user_phone',
            'user_role'
        )
        model = models.Parent

class SpecialistSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'user_name',
            'user_password',
            'user_email',
            'user_phone',
            'user_role',
            'active_status',
            'specialist_brief'
        )
        model = models.Specialist

class InquirySerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'parent_id',
            'specialist_id',
            'inquiry_price',
            'inquire_duration_in_minutes',
            'inquiry_start_time',
            'inquiry_end_time'
        )
        model = models.SingleInquiry

class VideoSessionSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'parent_id',
            'specialist_id',
            'video_price',
            'video_duration_in_minutes',
            'video_date',
            'video_start_time',
            'video_end_time'
        )
        model = models.VideoSession

class QuestionSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'question_body',
            'question_tags',
            'question_date',
            'question_admin' 
        )
        model = models.Question

class AnswerSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'answer_body',
            'answer_date',
            'answer_specialist',
            'answer_question'
        )
        model = models.Answer

class SlotSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'schedule_specialist',
            'free_day',
            'slot_date',
            'slot_start_time_integer',
            'slot_start_time',
            'slot_end_time',
            'booked'
        )
        model = models.Slots


class AppointmentSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'parent_id',
            'specialist_id',
            'video_date',
            'video_start_time',
            'video_end_time'
        )
        model = models.VideoSession