from django.shortcuts import render
from datetime import datetime
from . import forms

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

def hello_form(request):
   params = {"your_name": "", "email": "", "age": "", "gender": "", "salary": "", "form": None}
   if request.method == "POST":
       form = forms.HelloForm(request.POST)
       params["your_name"] = request.POST["your_name"]
       params["email"] = request.POST["email"]
       params["age"] = request.POST["age"]
       params["gender"] = request.POST["gender"]
       params["salary"] = request.POST["salary"]
       params["salary"] = int(params["salary"])
       params["form"] = form
   else:
       params["form"] = forms.HelloForm()
   return render(request, "forms.html", params)