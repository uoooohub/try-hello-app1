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