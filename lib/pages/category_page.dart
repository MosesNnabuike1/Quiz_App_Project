import 'package:flutter/material.dart';
import 'package:my_quiz_app/widgets/category_app_bar.dart' as app_bar;
// import 'package:my_quiz_app/widgets/category_banner.dart';
import 'package:my_quiz_app/widgets/category_title.dart';
import 'package:my_quiz_app/widgets/category_button.dart';
import 'quiz_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  late AnimationController _buttonController;
  // late Animation<double> _sizeAnimation;
  // late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController for slide animations
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Define the slide animations for each category
    _slideAnimation = Tween<Offset>(
            begin: const Offset(-1, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Start the animation for category buttons sliding in
    _controller.forward();

    // Initialize AnimationController for buttons
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    // // Define size and fade animations for the buttons
    // _sizeAnimation = Tween<double>(begin: 1, end: 1.5).animate(CurvedAnimation(
    //   parent: _buttonController,
    //   curve: Curves.easeInOut,
    // ));

    // _fadeAnimation =
    //     Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
    //   parent: _buttonController,
    //   curve: Curves.easeInOut,
    // ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  // Method to handle the transition when a category button is pressed
  void _onCategoryButtonPressed(
      BuildContext context, String category, String categoryId) {
    _buttonController.forward().then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                QuizPage(category: category, categoryId: categoryId)),
      ).then((_) {
        // Reverse the animation when the user comes back to CategoryPage
        _buttonController.reverse();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const app_bar.CategoryAppBar(),
      backgroundColor: const Color.fromARGB(255, 64, 51, 90),
      body: Column(
        children: [
          // const CategoryBanner(),
          const SizedBox(height: 10),
          const CategoryTitle(),
          const SizedBox(height: 20),
          // Sliding buttons for different categories
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'General Knowledge',
                    icon: Icons.public,
                    color: Colors.blue,
                    onTap: () => _onCategoryButtonPressed(
                        context, 'General Knowledge', '9'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Entertainment: Books',
                    icon: Icons.book,
                    color: Colors.purple,
                    onTap: () => _onCategoryButtonPressed(
                        context, 'Entertainment: Books', '10'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Entertainment: Film',
                    icon: Icons.movie,
                    color: Colors.red,
                    onTap: () => _onCategoryButtonPressed(
                        context, 'Entertainment: Film', '11'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Entertainment: Music',
                    icon: Icons.music_note,
                    color: Colors.orange,
                    onTap: () => _onCategoryButtonPressed(
                        context, 'Entertainment: Music', '12'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Entertainment: Musicals & Theatres',
                    icon: Icons.theater_comedy,
                    color: Colors.green,
                    onTap: () => _onCategoryButtonPressed(
                        context, 'Entertainment: Musicals & Theatres', '13'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Entertainment: Television',
                    icon: Icons.tv,
                    color: Colors.teal,
                    onTap: () => _onCategoryButtonPressed(
                        context, 'Entertainment: Television', '14'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Entertainment: Video Games',
                    icon: Icons.videogame_asset,
                    color: Colors.indigo,
                    onTap: () => _onCategoryButtonPressed(
                        context, 'Entertainment: Video Games', '15'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Entertainment: Board Games',
                    icon: Icons.games,
                    color: Colors.brown,
                    onTap: () => _onCategoryButtonPressed(
                        context, 'Entertainment: Board Games', '16'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Science & Nature',
                    icon: Icons.nature,
                    color: Colors.lightGreen,
                    onTap: () => _onCategoryButtonPressed(
                        context, 'Science & Nature', '17'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Science: Computers',
                    icon: Icons.computer,
                    color: Colors.blueGrey,
                    onTap: () => _onCategoryButtonPressed(
                        context, 'Science: Computers', '18'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Science: Mathematics',
                    icon: Icons.calculate,
                    color: Colors.deepPurple,
                    onTap: () => _onCategoryButtonPressed(
                        context, 'Science: Mathematics', '19'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Mythology',
                    icon: Icons.auto_stories,
                    color: Colors.amber,
                    onTap: () =>
                        _onCategoryButtonPressed(context, 'Mythology', '20'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Sports',
                    icon: Icons.sports,
                    color: Colors.cyan,
                    onTap: () =>
                        _onCategoryButtonPressed(context, 'Sports', '21'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Geography',
                    icon: Icons.map,
                    color: Colors.lightBlue,
                    onTap: () =>
                        _onCategoryButtonPressed(context, 'Geography', '22'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'History',
                    icon: Icons.history_edu,
                    color: Colors.deepOrange,
                    onTap: () =>
                        _onCategoryButtonPressed(context, 'History', '23'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Politics',
                    icon: Icons.gavel,
                    color: Colors.pink,
                    onTap: () =>
                        _onCategoryButtonPressed(context, 'Politics', '24'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Art',
                    icon: Icons.brush,
                    color: Colors.purple,
                    onTap: () => _onCategoryButtonPressed(context, 'Art', '25'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Celebrities',
                    icon: Icons.star,
                    color: Colors.yellow,
                    onTap: () =>
                        _onCategoryButtonPressed(context, 'Celebrities', '26'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Animals',
                    icon: Icons.pets,
                    color: Colors.orangeAccent,
                    onTap: () =>
                        _onCategoryButtonPressed(context, 'Animals', '27'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Vehicles',
                    icon: Icons.directions_car,
                    color: Colors.blueAccent,
                    onTap: () =>
                        _onCategoryButtonPressed(context, 'Vehicles', '28'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Science: Gadgets',
                    icon: Icons.devices,
                    color: Colors.tealAccent,
                    onTap: () => _onCategoryButtonPressed(
                        context, 'Science: Gadgets', '29'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Entertainment: Japanese Anime & Manga',
                    icon: Icons.bookmark,
                    color: Colors.redAccent,
                    onTap: () => _onCategoryButtonPressed(
                        context, 'Entertainment: Japanese Anime & Manga', '31'),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: CategoryButton(
                    category: 'Entertainment: Cartoon & Animations',
                    icon: Icons.animation,
                    color: Colors.lightGreenAccent,
                    onTap: () => _onCategoryButtonPressed(
                        context, 'Entertainment: Cartoon & Animations', '32'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
