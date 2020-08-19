from django.shortcuts import render, redirect
from django.http import HttpResponse
from .models import Tutorial, TutorialCategory, TutorialSeries
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth import login, logout, authenticate
from django.contrib import messages


def single_slug(request, single_slug):
    # first check to see if the url is in categories.

    categories = [c.category_slug for c in TutorialCategory.objects.all()]
    if single_slug in categories:
        matching_series = TutorialSeries.objects.filter(tutorial_category__category_slug=single_slug)
        series_urls = {}

        for m in matching_series.all():
            part_one = Tutorial.objects.filter(tutorial_series__tutorial_series=m.tutorial_series).earliest("tutorial_published")
            series_urls[m] = part_one.tutorial_slug

        return render(request=request,
                      template_name='main/category.html',
                      context={"tutorial_series": matching_series, "part_ones": series_urls})
    tutorial = [t.tutorial_slug for t in Tutorial.objects.all()]
    if single_slug in tutorial:
        return HttpResponse(f"{single_slug} is a category")

        return HttpResponse(f"{single_slug} is not categoey")

def homepage(request):
    return render(request=request,
        template_name="main/categories.html",
        context={"categories": TutorialCategory.objects.all})
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