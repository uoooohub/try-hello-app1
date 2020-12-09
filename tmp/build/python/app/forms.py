from django import forms

EMPTY_CHOICES = (
   ('', '-----'),
)
GENDER_CHOICES = (
   ('man', '男'),
   ('woman', '女')
)

class HelloForm(forms.Form):
   your_name = forms.CharField(label="名前", max_length=20)
   email = forms.EmailField(label="メール", max_length=100)
   age = forms.IntegerField(label="年齢", min_value=0, max_value=120)
   gender = forms.ChoiceField(label="性別", widget=forms.Select, choices=EMPTY_CHOICES + GENDER_CHOICES, required=True)