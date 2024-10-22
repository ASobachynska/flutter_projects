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
        primarySwatch: Colors.orange,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange[700],
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          buttonColor: Colors.orangeAccent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.orangeAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.grey[800], fontSize: 16),
          bodyText2: TextStyle(color: Colors.grey[700]),
          headline6: TextStyle(color: Colors.orange[800], fontSize: 22, fontWeight: FontWeight.bold),
        ),
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
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.school,
                size: 100,
                color: Colors.orangeAccent,
              ),
              SizedBox(height: 40),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Введіть вашу студентську пошту',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  errorText: _errorMessage,
                  filled: true,
                  fillColor: Colors.white,
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
        backgroundColor: Colors.orange[600],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
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
        type: BottomNavigationBarType.fixed, // Залишаємо статичний тип
        selectedFontSize: 14, // Розмір шрифту для вибраних елементів
        unselectedFontSize: 12, // Розмір шрифту для невибраних елементів
      ),
    );
  }
}

// Головна сторінка
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Тут буде розклад занять',
        style: TextStyle(fontSize: 24, color: Colors.orange[800]),
      ),
    );
  }
}

// Сторінка з дисциплінами
class CoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Тут буде список дисциплін по курсам',
        style: TextStyle(fontSize: 24, color: Colors.orange[800]),
      ),
    );
  }
}

// Сторінка вибіркових дисциплін
class ElectivesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Тут буде вибір вибіркових дисциплін',
        style: TextStyle(fontSize: 24, color: Colors.orange[800]),
      ),
    );
  }
}

// Сторінка профілю
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.orangeAccent,
            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Ім\'я Прізвище',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.orange[800],
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Спеціальність: Комп\'ютерні науки',
            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          ),
          Text(
            'Курс: 3',
            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          ),
          Text(
            'Шифр групи: KN1B21',
            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
