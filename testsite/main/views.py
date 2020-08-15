from django.shortcuts import render
from django.http import HttpResponse

def homepage(request):
    return HttpResponse("<h1>django-project<h1>")
# Create your views here.
