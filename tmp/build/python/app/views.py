from django.shortcuts import render
from datetime import datetime

# Create your views here.
def index(request):
    d = {
        "year": datetime.now().year,
        "month": datetime.now().month,
        "day": datetime.now().day,
        "hour": datetime.now().hour,
        "message": "良いお天気ですね"
    }
    return render(request, "index.html", d)

def sub_index(request):
    d = {
        "name": "田村",
        "message": "こんにちわ",
    }
    return render(request, "sub.html", d)

def sub2_index(request):
   d = {
       'range': range(10),
   }
   return render(request, 'sub2.html', d)

def get_query(request):
   d = {
       'name': request.GET.get('name')
   }
   return render(request, 'sub3.html', d)