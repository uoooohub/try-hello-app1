from django.urls import path
from . import views

urlpatterns = [
   path('', views.index),
   path('sub',views.sub_index),
]