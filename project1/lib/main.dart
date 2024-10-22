import 'package:flutter/material.dart';

void main() {
  runApp(StudentApp());
}

class StudentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthPage(), // Початкова сторінка - аутентифікація
    );
  }
}

// Сторінка аутентифікації
class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  String? _errorMessage;

  void _authenticate() {
    final email = _emailController.text;
    if (email.endsWith('@kpnu.edu.ua')) {
      final year = int.tryParse(email.substring(4, 6)); // Витягуємо рік з email
      final currentYear = DateTime.now().year % 100; // Поточний рік у форматі двох цифр
      if (year != null && (currentYear - year) >= 0 && (currentYear - year) <= 4) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      } else {
        setState(() {
          _errorMessage = 'Неправильний рік навчання!';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Використовуйте лише пошту з доменом @kpnu.edu.ua!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Аутентифікація студента'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Введіть вашу студентську пошту',
                errorText: _errorMessage,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _authenticate,
              child: Text('Увійти'),
            ),
          ],
        ),
      ),
    );
  }
}

// Основна сторінка з навігацією
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    CoursesPage(),
    ElectivesPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Студентський додаток'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Головна',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Дисципліни',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
            label: 'Вибіркові',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профіль',
          ),
        ],
      ),
    );
  }
}

// Головна сторінка
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Тут буде розклад занять'),
    );
  }
}

// Сторінка з дисциплінами
class CoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Тут буде список дисциплін по курсам'),
    );
  }
}

// Сторінка вибіркових дисциплін
class ElectivesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Тут буде вибір вибіркових дисциплін'),
    );
  }
}

// Сторінка профілю
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Тут буде профіль користувача'),
    );
  }
}
