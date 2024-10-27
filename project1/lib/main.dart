import 'package:flutter/material.dart';

void main() {
  runApp(StudentApp());
}

// Клас з визначенням кольорів
class AppColors {
  static const primary = Colors.orange;
  static const primaryDark = Colors.orangeAccent;
  static const appBarBackground = Colors.orange;
  static const scaffoldBackground = Colors.grey;
  static const iconColor = Colors.white;
  static const textPrimary = Colors.orange;
  static const textSecondary = Colors.grey;
  static const cardBackground = Colors.grey;
}

class StudentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student App',
      theme: ThemeData(
        primarySwatch: AppColors.primary,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.scaffoldBackground[100],
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.appBarBackground[700],
          titleTextStyle: TextStyle(
            color: AppColors.iconColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: AppColors.iconColor),
        ),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          buttonColor: AppColors.primaryDark,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: AppColors.primaryDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.grey[800], fontSize: 16),
          bodyText2: TextStyle(color: AppColors.textSecondary[700]),
          headline6: TextStyle(
            color: AppColors.textPrimary[800],
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: AuthPage(),
    );
  }
}

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
      // Знаходимо символи після 'b' або 'm' в шифрі групи
      String yearStr = '';
      if (email.contains('b')) {
        yearStr = email.split('b')[1].substring(0, 2);
      } else if (email.contains('m')) {
        yearStr = email.split('m')[1].substring(0, 2);
      }
      
      final year = int.tryParse(yearStr);
      final currentYear = DateTime.now().year % 100; // Останні дві цифри поточного року

      if (year != null && (currentYear - year) >= 0) {
        final groupCode = email.substring(0, email.indexOf('.')); // Отримуємо шифр групи
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage(groupCode: groupCode)),
        );
      } else {
        setState(() {
          _errorMessage = 'Неправильний рік навчання!'; // Помилка, якщо курс не коректний
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
      backgroundColor: AppColors.cardBackground[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.school,
                size: 100,
                color: AppColors.primaryDark,
              ),
              SizedBox(height: 40),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Введіть вашу студентську пошту',
                  labelStyle: TextStyle(color: AppColors.textSecondary[700]),
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

class MainPage extends StatefulWidget {
  final String groupCode; // Додаємо параметр для шифра групи

  MainPage({required this.groupCode}); // Конструктор

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    CoursesPage(),
    ElectivesPage(),
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
        title: Text('Додаток Студент'),
      ),
      body: _selectedIndex == 3
          ? ProfilePage(groupCode: widget.groupCode) // Передача groupCode до ProfilePage
          : _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.appBarBackground[600],
        selectedItemColor: AppColors.iconColor,
        unselectedItemColor: AppColors.iconColor.withOpacity(0.7),
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
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        unselectedFontSize: 12,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Тут буде розклад занять',
        style: TextStyle(fontSize: 24, color: AppColors.textPrimary[800]),
      ),
    );
  }
}

class CoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Тут буде список дисциплін по курсам',
        style: TextStyle(fontSize: 24, color: AppColors.textPrimary[800]),
      ),
    );
  }
}

class ElectivesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Тут буде вибір вибіркових дисциплін',
        style: TextStyle(fontSize: 24, color: AppColors.textPrimary[800]),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final String groupCode;

  ProfilePage({required this.groupCode});

  @override
  Widget build(BuildContext context) {
    String specialty = 'Комп\'ютерні науки';
    String studyType;

    if (groupCode.contains('b')) {
      studyType = 'бакалавр';
    } else if (groupCode.contains('m')) {
      studyType = 'магістр';
    } else {
      studyType = 'невідомий'; // Випадок для обробки, якщо тип навчання не відомий
    }

    int yearOfAdmission = int.tryParse(groupCode.substring(4, 6)) ?? 0; // Виправлено, щоб брати два символи
    int currentYear = DateTime.now().year % 100;

    int course = currentYear - yearOfAdmission + 1;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.primaryDark,
            child: Icon(
              Icons.person,
              size: 50,
              color: AppColors.iconColor,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Ім\'я Прізвище',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary[800],
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Спеціальність: $specialty',
            style: TextStyle(fontSize: 18, color: AppColors.textSecondary[700]),
          ),
          Text(
            'Тип навчання: $studyType',
            style: TextStyle(fontSize: 18, color: AppColors.textSecondary[700]),
          ),
          Text(
            'Курс: $course',
            style: TextStyle(fontSize: 18, color: AppColors.textSecondary[700]),
          ),
        ],
      ),
    );
  }
}
