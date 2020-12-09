from django.urls import path
from . import views

urlpatterns = [
   path('', views.index),
   path('sub',views.sub_index),
   path('sub2',views.sub2_index),
   path('sub3',views.get_query),
   path('sub4',views.hello_form),
]