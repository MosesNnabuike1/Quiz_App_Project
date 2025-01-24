import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http;
import 'package:my_quiz_app/utils/dailog_utils.dart';
import 'package:my_quiz_app/widgets/question_container.dart';
import 'package:my_quiz_app/widgets/progress_circle.dart';
import 'package:my_quiz_app/widgets/option_button.dart';
import 'package:my_quiz_app/widgets/next_submit_button.dart';

class QuizPage extends StatefulWidget {
  final String category;
  final String categoryId;

  const QuizPage({super.key, required this.category, required this.categoryId});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage>
    with SingleTickerProviderStateMixin {
  int currentQuestionIndex = 0;
  Color selectedOptionColor = Colors.transparent;
  Color correctOptionColor = Colors.transparent;
  List<Map<String, dynamic>> questions = [];
  bool isAnswered = false;

  String? selectedOption;

  bool _isQuestionVisible = false;
  bool _isProgressVisible = false;
  bool _questionReturn = false;
  bool _isSubmitVisible = false;
  List<bool> _isOptionVisible = [];
  bool isFlicker = false;

  bool _areQuestionsFetched = false;

  int correctAnswers = 0;

  @override
  void initState() {
    super.initState();

    fetchQuestions(widget.categoryId).then((fetchedQuestions) {
      setState(() {
        questions = fetchedQuestions;
        _areQuestionsFetched = true; // Update when questions are fetched
        _isOptionVisible = List<bool>.filled(
            questions[currentQuestionIndex]['options'].length, false);
      });

      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          _isQuestionVisible = true;
        });

        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            _questionReturn = true;
          });

          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              _isProgressVisible = true;
            });

            Future.delayed(const Duration(milliseconds: 100), () {
              animateOptionsIn();
            });
          });
        });
      });
    }).catchError((error) {
      print('Error fetching questions: $error');
    });
  }

  Future<List<Map<String, dynamic>>> fetchQuestions(String categoryId) async {
    final url =
        'https://opentdb.com/api.php?amount=10&category=$categoryId&difficulty=easy&type=multiple';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final results = data['results'] as List;
      return results.map((question) {
        return {
          'question': question['question'],
          'options': [
            ...question['incorrect_answers'],
            question['correct_answer']
          ]..shuffle(), // Shuffle options for randomness
          'answer': question['correct_answer']
        };
      }).toList();
    } else {
      throw Exception('Failed to fetch questions');
    }
  }

  void animateOptionsIn() {
    for (int i = 0; i < _isOptionVisible.length; i++) {
      Future.delayed(Duration(milliseconds: 100 * i), () {
        setState(() {
          _isOptionVisible[i] = true;
        });

        if (i == _isOptionVisible.length - 1) {
          // Once all options are visible, show the submit button.
          Future.delayed(const Duration(milliseconds: 200), () {
            setState(() {
              _isSubmitVisible = true;
              // Submit button becomes visible.
            });
          });
        }
      });
    }
  }

  // Method to check if the selected answer is correct.
  void checkAnswer(String option) {
    setState(() {
      selectedOption = option;
      isAnswered = true;
    });
    if (option != questions[currentQuestionIndex]['answer']) {
      flickerWrongAnswer();
    } else {
      flickerCorrectAnswer();
    }
  }

  void flickerWrongAnswer() {
    int flickerCount = 0; // Track the number of flickers
    void flicker() {
      if (flickerCount < 6) {
        setState(() {
          // Alternate between red and blue for the wrong option.
          selectedOptionColor =
              (flickerCount % 2 == 0) ? Colors.red : Colors.blue;
        });
        flickerCount++;

        // Wait for 500ms before flickering again.
        Future.delayed(const Duration(milliseconds: 500), flicker);
      } else {
        // After flickering, show the correct option in green.
        setState(() {
          selectedOptionColor =
              Colors.green; // Highlight correct answer in green.
          selectedOption =
              questions[currentQuestionIndex]['answer']; // Show correct answer.
        });

        // Wait 2 seconds before moving to the next question.
        Future.delayed(const Duration(seconds: 2), goToNextQuestion);
      }
    }

    flicker();
  }

  void flickerCorrectAnswer() {
    setState(() {
      selectedOptionColor = Colors.green; // Highlight correct answer in green.
    });

    // Wait 2 seconds before moving to the next question.
    Future.delayed(const Duration(seconds: 2), goToNextQuestion);
  }

  void goToNextQuestion() {
    if (selectedOption == questions[currentQuestionIndex]['answer']) {
      correctAnswers++;
    }
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        isAnswered = false;
        selectedOption = null;
        _isSubmitVisible = false;
        _isOptionVisible = List<bool>.filled(
            questions[currentQuestionIndex]['options'].length, false);
        _isProgressVisible = false;
        startNextQuestionAnimation();
      });
    } else {
      showResultPage(context, correctAnswers, questions.length);
    }
  }

  void startNextQuestionAnimation() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _isQuestionVisible = true;
      });

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _questionReturn = true;
        });

        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            _isProgressVisible = true;
          });

          Future.delayed(const Duration(milliseconds: 100), () {
            animateOptionsIn();
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress =
        (currentQuestionIndex + (isAnswered ? 1 : 0)) / questions.length;
    // Calculates the progress percentage.

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigates back to the previous screen.
          },
        ),
        backgroundColor: const Color.fromARGB(255, 64, 51, 90),
        title: Text('${widget.category} Quiz',
            style: const TextStyle(color: Colors.white)),
      ),
      backgroundColor: const Color.fromARGB(255, 64, 51, 90),
      body: !_areQuestionsFetched
          ? const Center(child: CircularProgressIndicator())
          : questions.isEmpty
              ? const Center(child: Text('There is no question'))
              : SingleChildScrollView(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 600,
                        maxHeight: 800,
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  // Animated Question Container
                                  AnimatedPositioned(
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut,
                                    top: _questionReturn
                                        ? 80
                                        : (_isQuestionVisible ? 250 : 250),
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: QuestionContainer(
                                        question:
                                            questions[currentQuestionIndex]
                                                ['question'],
                                      ),
                                    ),
                                  ),

                                  // Animated Progress Circle
                                  AnimatedPositioned(
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut,
                                    top: _isProgressVisible ? 40 : -200,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: ProgressCircle(progress: progress),
                                    ),
                                  ),

                                  // Animated Options
                                  for (int i = 0;
                                      i <
                                          questions[currentQuestionIndex]
                                                  ['options']
                                              .length;
                                      i++)
                                    AnimatedPositioned(
                                      duration: Duration(
                                          milliseconds: 100 + (i * 100)),
                                      curve: Curves.easeInOut,
                                      top: _isOptionVisible[i]
                                          ? 300 + (i * 80)
                                          : 800,
                                      left: 0,
                                      right: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: OptionButton(
                                          option:
                                              questions[currentQuestionIndex]
                                                  ['options'][i],
                                          isSelected: selectedOption ==
                                              questions[currentQuestionIndex]
                                                  ['options'][i],
                                          isCorrect: selectedOption ==
                                              questions[currentQuestionIndex]
                                                  ['answer'],
                                          onTap: () => checkAnswer(
                                              questions[currentQuestionIndex]
                                                  ['options'][i]),
                                        ),
                                      ),
                                    ),

                                  // Next/Submit Button
                                  if (_isSubmitVisible)
                                    AnimatedPositioned(
                                      duration:
                                          const Duration(milliseconds: 100),
                                      curve: Curves.easeInOut,
                                      bottom: 60,
                                      left: 0,
                                      right: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: NextSubmitButton(
                                          isLastQuestion:
                                              currentQuestionIndex ==
                                                  questions.length - 1,
                                          onPressed: goToNextQuestion,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}
