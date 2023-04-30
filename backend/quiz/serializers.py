from rest_framework import serializers
from .models import Quiz


# title, body, answer 데이터를 담고 있는 json 형식으로 변환해주는 코드
class QuizSerializer(serializers.ModelSerializer):
    class Meta:
        model = Quiz
        fields = ('title', 'body', 'answer')
