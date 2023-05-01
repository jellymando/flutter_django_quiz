import 'package:flutter/material.dart';
import 'package:flutter_contact/model/api_adapter.dart';
import 'package:flutter_contact/model/model_quiz.dart';
import 'package:flutter_contact/screen/screen_quiz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Quiz> quizs = [];
  bool isLoading = false;

  _fetchQuizs() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/quiz/3'));
    if(response.statusCode == 200) {
      setState(() {
        quizs = parseQuizs(utf8.decode(response.bodyBytes));
        isLoading = false;
      });
    } else {
      throw Exception('failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('My Quiz App'),
            backgroundColor: Colors.deepPurple,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(child: Image.asset('assets/INTJ3.jpg', width: width*0.8)),
              Padding(padding: EdgeInsets.all(width*0.024)),
              Text('플러터 퀴즈 앱', style: TextStyle(fontSize: width*0.065, fontWeight: FontWeight.bold)),
              Text('퀴즈를 풀기 전 안내사항입니다.\n꼼꼼히 읽고 퀴즈 풀기를 눌러주세요.', textAlign: TextAlign.center),
              Padding(padding: EdgeInsets.all(width*0.048)),
              _buildStep(width, '1. 랜덤으로 나오는 퀴즈 3개를 풀어보세요.'),
              _buildStep(width, '2. 문제를 잘 읽고 정답을 고른 뒤\n다음 문제 버튼을 눌러주세요.'),
              _buildStep(width, '3. 만점을 향해 도전해보세요!'),
              Padding(padding: EdgeInsets.all(width*0.048)),
              Container(
                padding: EdgeInsets.only(bottom: width*0.036),
                child: Center(
                  child: ButtonTheme(
                    minWidth: width*0.8,
                    height: height*0.05,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ElevatedButton(
                        child: Text('지금 퀴즈 풀기', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          _fetchQuizs().whenComplete(() {
                            return Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen(quizs: quizs)));
                          });
                        },
                    )
                  )
                )
              )
            ]
          )
        )
      ),
    );
  }
}

Widget _buildStep(double width, String title) {
  return Container(
    padding: EdgeInsets.fromLTRB(width*0.048, width*0.024, width*0.048, width*0.024),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(Icons.check_box,size: width*0.04),
      Padding(padding:EdgeInsets.only(right: width*0.024)),
      Text(title)
    ]),
  );
}



