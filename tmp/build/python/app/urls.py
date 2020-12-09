from django.urls import path
from . import views

urlpatterns = [
   path('', views.index),
   Path('sub',views.sub_index),
]