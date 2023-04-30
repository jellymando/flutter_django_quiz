from django.urls import path, include
from .views import helloAPI, randomQuiz

# quiz 앱에 대한 URL 관리
urlpatterns = [
    path("hello/", helloAPI),
    path("<int:id>", randomQuiz),
]
