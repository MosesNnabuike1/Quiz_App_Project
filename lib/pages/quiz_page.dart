import 'package:flutter/material.dart';
// Import the Flutter Material package, which provides core UI components.

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});
  // Defines a stateful widget called QuizPage with a constant constructor.

  @override
  State<QuizPage> createState() => _QuizPageState();
  // The state of QuizPage is managed by _QuizPageState, defined below.
}

class _QuizPageState extends State<QuizPage>
    with SingleTickerProviderStateMixin {
  // Defines the state of QuizPage. It mixes in SingleTickerProviderStateMixin
  // to manage animations for one animation controller.

  int currentQuestionIndex = 0;
  // Tracks the index of the current question being displayed.
  Color selectedOptionColor =
      Colors.transparent; // Default color for selected option.
  Color correctOptionColor =
      Colors.transparent; // Default color for correct option.

  bool isAnswered = false;
  // Flag to check if the user has selected an answer.

  String? selectedOption;
  // Stores the currently selected option by the user.

  // Flags to control visibility and animations.
  bool _isQuestionVisible = false;
  bool _isProgressVisible = false;
  bool _questionReturn = false;
  final bool _areOptionsVisible = false;
  bool _isSubmitVisible = false;
  List<bool> _isOptionVisible = [];
  bool isFlicker = false; // This variable will control the flicker effect
  // List to track the visibility state of each option.

  int correctAnswers = 0;
  // Counter for correct answers.

  // List of questions. Each question is a map with 'question', 'options', and 'answer' keys.
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the chemical symbol for water?',
      'options': ['H2O', 'O2', 'CO2', 'HO'],
      'answer': 'H2O'
    },
    {
      'question': 'What planet is known as the Red Planet?',
      'options': ['Mars', 'Earth', 'Jupiter', 'Venus'],
      'answer': 'Mars'
    },
    {
      'question': 'Which gas is most abundant in the Earth\'s atmosphere?',
      'options': ['Oxygen', 'Nitrogen', 'Carbon Dioxide', 'Hydrogen'],
      'answer': 'Nitrogen'
    },
    {
      'question': 'What is the powerhouse of the cell?',
      'options': ['Nucleus', 'Ribosome', 'Mitochondria', 'Cell Membrane'],
      'answer': 'Mitochondria'
    },
    {
      'question': 'What is the boiling point of water?',
      'options': ['90°C', '100°C', '110°C', '120°C'],
      'answer': '100°C'
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the state of the widget.

    _isOptionVisible = List<bool>.filled(
        questions[currentQuestionIndex]['options'].length, false);
    // Initializes the visibility of options for the first question.

    Future.delayed(const Duration(milliseconds: 100), () {
      // Delays the question animation by 100ms.
      setState(() {
        _isQuestionVisible = true;
        // Makes the question visible by starting the slide animation.
      });

      Future.delayed(const Duration(seconds: 1), () {
        // Waits for 5 seconds before triggering the next animation phase.
        setState(() {
          _questionReturn = true;
        });

        Future.delayed(const Duration(seconds: 1), () {
          // Waits for 2 seconds before showing the progress indicator.
          setState(() {
            _isProgressVisible = true;
          });

          Future.delayed(const Duration(milliseconds: 100), () {
            _animateOptionsIn();
            // Starts the staggered options animation.
          });
        });
      });
    });
  }

  // Method to animate the appearance of options one by one.
  void _animateOptionsIn() {
    for (int i = 0; i < _isOptionVisible.length; i++) {
      Future.delayed(Duration(milliseconds: 100 * i), () {
        // Each option appears after a delay.
        setState(() {
          _isOptionVisible[i] = true;
          // Make each option visible one by one.
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
      selectedOption = option; // Store the selected option.
      isAnswered =
          true; // Mark the question as answered to prevent re-selection.
    });

    // Check if the selected option is incorrect.
    if (option != questions[currentQuestionIndex]['answer']) {
      // Call the flicker method for wrong answers when the selected option is incorrect.
      _flickerWrongAnswer();
    } else {
      // Call the method to start the flickering animation for the correct answer.
      _flickerCorrectAnswer();
    }
  }

  void _flickerWrongAnswer() {
    int flickerCount = 0; // Track the number of flickers

    // Define a function that performs the flicker effect.
    void flicker() {
      // Check if we still need to flicker
      if (flickerCount < 6) {
        // Flicker 6 times (3 red and 3 blue)
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
        Future.delayed(const Duration(seconds: 2), () {
          //_goToNextQuestion(); // Move to the next question after delay.
        });
      }
    }

    // Start the flickering effect.
    flicker();
  }

  void _flickerCorrectAnswer() {
    // Start flickering: First change to yellow
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        isFlicker = true; // Start flicker with yellow
      });

      // Switch to green after another 500 milliseconds
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          isFlicker = false; // Change back to green
        });

        // Flicker again to yellow
        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() {
            isFlicker = true; // Back to yellow
          });

          // Final change to green and settle
          Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              isFlicker = false; // Settle on green
              // _goToNextQuestion(); // Proceed to the next question
            });
          });
        });
      });
    });
  }

  // Advances to the next question or ends the quiz.
  void _goToNextQuestion() {
    if (selectedOption == questions[currentQuestionIndex]['answer']) {
      // Checks if the selected answer is correct.
      correctAnswers++;
    }

    if (currentQuestionIndex < questions.length - 1) {
      // If there are more questions, proceed to the next one.
      setState(() {
        currentQuestionIndex++;
        // Move to the next question.
        isAnswered = false;
        // Reset the answer state for the next question.
        selectedOption = null;
        _isSubmitVisible = false;
        _isOptionVisible = List<bool>.filled(
            questions[currentQuestionIndex]['options'].length, false);
        _isProgressVisible = false;

        _startNextQuestionAnimation();
        // Trigger the animation for the next question.
      });
    } else {
      _showResultDialog();
      // Show the result dialog if all questions have been answered.
    }
  }

  // Starts the animation for the next question.
  void _startNextQuestionAnimation() {
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
            _animateOptionsIn();
            // Animates the appearance of options for the next question.
          });
        });
      });
    });
  }

  // Displays the result dialog at the end of the quiz.
  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          // Custom rounded dialog box.
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Quiz Completed!',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Text(
                    'You got $correctAnswers out of ${questions.length} correct.',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Close the result dialog.
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
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
            Navigator.pop(context);
            // Navigates back to the previous screen.
          },
        ),
        backgroundColor: const Color.fromARGB(255, 64, 51, 90),
        title:
            const Text('Science Quiz', style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: const Color.fromARGB(255, 64, 51, 90),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Animated Question Container
                  AnimatedPositioned(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    top:
                        _questionReturn ? 80 : (_isQuestionVisible ? 250 : 250),
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(60.0),
                        constraints: const BoxConstraints(maxWidth: 600),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 219, 214, 214),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 24, 23, 23)
                                  .withOpacity(0.2),
                              spreadRadius: 10,
                              blurRadius: 15,
                              offset: const Offset(0, 5), // Shadow effect
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              questions[currentQuestionIndex]['question'],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
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
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: progress),
                          duration: const Duration(milliseconds: 100),
                          builder: (context, value, _) => Stack(
                            fit: StackFit.expand,
                            children: [
                              Center(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 219, 214, 214),
                                  ),
                                ),
                              ),
                              CircularProgressIndicator(
                                value: value,
                                strokeWidth: 8,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.orange),
                                backgroundColor: Colors.grey[300],
                              ),
                              Center(
                                child: Text(
                                  '${(value * 100).toInt()}%',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Animated Options
                  for (int i = 0;
                      i < questions[currentQuestionIndex]['options'].length;
                      i++)
                    AnimatedPositioned(
                      duration: Duration(
                          milliseconds:
                              100 + (i * 100)), // Staggered animations
                      curve: Curves.easeInOut,
                      top: _isOptionVisible[i] ? 300 + (i * 80) : 800,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: () => checkAnswer(
                              questions[currentQuestionIndex]['options'][i]),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 30),
                            decoration: BoxDecoration(
                              color: selectedOption ==
                                      questions[currentQuestionIndex]['options']
                                          [i]
                                  ? (selectedOption ==
                                          questions[currentQuestionIndex]
                                              ['answer']
                                      ? (isAnswered
                                          ? (isFlicker
                                              ? const Color.fromARGB(255, 68,
                                                  138, 255) // Flicker to yellow
                                              : Colors
                                                  .green) // Final green after flicker
                                          : Colors
                                              .green) // Correct answer settled on green
                                      : (isAnswered &&
                                              selectedOption !=
                                                  questions[
                                                          currentQuestionIndex]
                                                      ['answer']
                                          ? selectedOptionColor // Flicker effect color for wrong answer
                                          : const Color.fromARGB(255, 68, 138,
                                              255))) // Selected but not correct
                                  : Colors
                                      .blueAccent, // Non-selected options remain blue
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              questions[currentQuestionIndex]['options'][i],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Next/Submit Button
                  if (_isSubmitVisible)
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeInOut,
                      bottom: 60, // Slide in from the bottom
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          width: double.infinity, // Full width for the button
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ElevatedButton(
                            onPressed:
                                _goToNextQuestion, // Go to the next question or submit
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 37, 34, 34),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              currentQuestionIndex == questions.length - 1
                                  ? 'Submit' // Last question: Submit
                                  : 'Next Question', // Other questions: Next Question
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
