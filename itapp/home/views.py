from django.shortcuts import get_object_or_404, render, render_to_response, redirect
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib import messages
from django.db import transaction
from django.http import HttpResponse
from home.forms import ProfileForm
from home.models import UserProfile

# Create your views here.
def index(request):
    user = request.user
    return render(request, 'home/index.html', {"user": user})
    
def bad_request(request):
    return render(request, 'sites/error.html', {
        'Error': '400 -  Bad Request',    
    })    
    
def page_not_found(request):
    return render(request, 'sites/error.html', {
        'Error': '404 - page not found',    
    })    
    
def permission_denied(request):
    return render(request, 'sites/error.html', {
        'Error': '403 - You do not have permission to view this page',    
    }) 
 

def server_error(request):
    return render(request, 'sites/error.html', {
        'Error': '500 - Server Error',    
    })     
    

@login_required
@transaction.atomic
def update_profile(request):
    if request.method == 'POST':
        profile_form = ProfileForm(request.POST, instance=request.user.userprofile)
        if profile_form.is_valid():
            profile_form.save()
            messages.success(request, ('Your profile was successfully updated!'))
            return redirect('home:profile')
        else:
            messages.error(request, ('Please correct the error below.'))
    else:
        profile_form = ProfileForm(instance=request.user.userprofile)
    return render(request, 'home/profile.html', {
        'profile_form': profile_form
    })   