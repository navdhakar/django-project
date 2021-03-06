from django.shortcuts import render, redirect
from django.http import HttpResponse
from .models import Tutorial, TutorialCategory, TutorialSeries
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth import login, logout, authenticate
from django.contrib import messages



def homepage(request):
    return render(request=request,
        template_name="main/home.html",
        context={"tutorials": Tutorial.objects.all()})
    
# Create your views here.
def register(request):
    if request.method == "POST":
        form = UserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            username = form.cleaned_data.get('username')
            messages.success(request, f"new account created: {username}")
            login(request, user)
            messages.info(request, f"you are now logged in as {username}")
            return redirect("main:homepage")
        else:
            for msg in form.error_messages:
                messages.error(request, f"{msg}: {form.error_messages[msg]}")


    form = UserCreationForm
    return render(request,
    "main/register.html",
    context={"form":form})

def logout_req(request):
    logout(request)
    messages.info(request, "logged out successfully")
    return redirect("main:homepage")