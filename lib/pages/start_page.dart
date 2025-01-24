import 'package:flutter/material.dart';
import 'category_page.dart'; // Import CategoryPage to navigate to it

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 64, 51, 90),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                // Circular container with the "Quiz App" text
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromRGBO(64, 155, 46, 1)
                            .withOpacity(0.5), // Shadow color
                        spreadRadius: 5, // How far the shadow spreads
                        blurRadius: 7, // Blurring radius
                        offset:
                            const Offset(0, 3), // Offset of the shadow (x, y)
                      ),
                    ],
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text: 'Quiz',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' App',
                            style: TextStyle(
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // TextField for entering name
                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: _nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Enter your name',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintText: 'Moses Nnabuike',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 20),
                // Start button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_nameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter your name'),
                          ),
                        );
                      } else {
                        // Navigate to the Category Page with "opening-up" animation
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(
                                milliseconds: 1000), // Animation duration
                            pageBuilder: (context, animation,
                                    secondaryAnimation) =>
                                const CategoryPage(), // Navigate to CategoryPage
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              // Create opening-up animation

                              // Scale Animation (enlarges from a small scale to full)
                              var scaleTween = Tween<double>(
                                      begin: 0.8, end: 1.0)
                                  .chain(CurveTween(curve: Curves.easeInOut));

                              // Fade animation for smooth transition
                              var fadeTween = Tween<double>(
                                      begin: 0.0, end: 1.0)
                                  .chain(CurveTween(curve: Curves.easeInOut));

                              return FadeTransition(
                                opacity: animation.drive(fadeTween),
                                child: ScaleTransition(
                                  scale: animation.drive(scaleTween),
                                  child: child,
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Start',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
