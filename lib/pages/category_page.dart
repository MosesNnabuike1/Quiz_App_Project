import 'quiz_page.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _scienceSlideAnimation;
  late Animation<Offset> _artSlideAnimation;
  late Animation<Offset> _socialScienceSlideAnimation;
  late Animation<Offset> _commercialSlideAnimation;

  late AnimationController _scienceButtonController;
  late Animation<double> _sizeAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController for slide animations
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Define the slide animations for each category
    _scienceSlideAnimation = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _artSlideAnimation = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _socialScienceSlideAnimation = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _commercialSlideAnimation = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Start the animation for category buttons sliding in
    _controller.forward();

    // Initialize AnimationController for Science button
    _scienceButtonController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    // Define size and fade animations for the Science button
    _sizeAnimation = Tween<double>(begin: 1, end: 1.5).animate(CurvedAnimation(
      parent: _scienceButtonController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: _scienceButtonController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _scienceButtonController.dispose();
    super.dispose();
  }

  // Method to handle the transition when Science button is pressed
  void _onScienceButtonPressed(BuildContext context) {
    _scienceButtonController.forward().then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const QuizPage()),
      ).then((_) {
        // Reverse the animation when the user comes back to CategoryPage
        _scienceButtonController.reverse();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 64, 51, 90),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigates back to the previous screen
          },
        ),
        title: const Text(
          'Quiz Categories',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 64, 51, 90),
      body: Column(
        children: [
          // Banner image representing categories with left and right padding
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/category_banner.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Category',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          // Sliding buttons for different categories
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                // Animated Science Button
                SlideTransition(
                  position: _scienceSlideAnimation,
                  child: AnimatedBuilder(
                    animation: _scienceButtonController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _sizeAnimation.value,
                        child: Opacity(
                          opacity: _fadeAnimation.value,
                          child: _buildCategoryButton(
                            context,
                            'Science',
                            Icons.science,
                            Colors.blue,
                            () => _onScienceButtonPressed(context),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _artSlideAnimation,
                  child: _buildCategoryButton(
                    context,
                    'Art',
                    Icons.brush,
                    Colors.purple,
                    () {
                      // Add functionality for the Art category
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _socialScienceSlideAnimation,
                  child: _buildCategoryButton(
                    context,
                    'Social Science',
                    Icons.people,
                    Colors.green,
                    () {
                      // Add functionality for the Social Science category
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _commercialSlideAnimation,
                  child: _buildCategoryButton(
                    context,
                    'Commercial',
                    Icons.business,
                    Colors.brown,
                    () {
                      // Add functionality for the Commercial category
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Method to build category buttons
  Widget _buildCategoryButton(
    BuildContext context,
    String category,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: Icon(icon, color: Colors.white, size: 30),
      label: Text(
        category,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
