from django import forms
from django.forms.fields import DateField


class DateInput(forms.DateInput):
    input_type = 'date'


class ExampleForm (forms.Form):
    my_date_field = forms.DateField(widget=DateInput)
