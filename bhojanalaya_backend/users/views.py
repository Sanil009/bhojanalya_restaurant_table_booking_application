from django.http.response import HttpResponse
from django.shortcuts import render

# Create your views here.
def handleRegister(request):
    if request.method == 'POST':
        
    else:
        return HttpResponse('404 Not Found')