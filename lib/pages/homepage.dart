import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'otpverificationpage.dart';
import 'phonenumber.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showButtons = false;
  String selectedLanguage = "English";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        showButtons = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepOrange.shade800, Colors.teal.shade300],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0), // Add padding for space
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black, // Black background
                      ),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn, // Make image white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/languages.png",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                _buildLogoImage(),
                Text(
                  getHeaderText(selectedLanguage),
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Times New Roman',
                  ),
                ),
                AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: showButtons ? 1.0 : 0.0,
                  child: Transform.translate(
                    offset: Offset(0, showButtons ? -50.0 : 0.0),
                    child: Column(
                      children: [
                        MyStyledButton(
                          buttonText: "Sign Up",
                          pageWidget: FirstRoute(),
                          backgroundColor: Colors.teal,
                          textColor: Colors.white,
                          hasShadow: false,
                        ),
                        SizedBox(height: 20),
                        MyStyledButton(
                          buttonText: 'Sign In',
                          pageWidget: FirstRoute(),
                          backgroundColor: Colors.white,
                          textColor: Colors.teal,
                          borderColor: Colors.teal,
                          hasShadow: false,
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

  Widget _buildLogoImage() {
    return Container(
      width: 120,
      height: 120,
      child: Image.asset(
        "assets/images/empoverty.png",
        width: 100,
        height: 100,
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LanguageOption(
                language: "English",
                isSelected: selectedLanguage == "English",
                onSelected: () {
                  _onLanguageSelected("English");
                  Navigator.pop(context);
                },
              ),
              LanguageOption(
                language: "Kannada (ಕನ್ನಡ)",
                isSelected: selectedLanguage == "Kannada (ಕನ್ನಡ)",
                onSelected: () {
                  _onLanguageSelected("Kannada (ಕನ್ನಡ)");
                  Navigator.pop(context);
                },
              ),
              LanguageOption(
                language: "Hindi (हिंदी)",
                isSelected: selectedLanguage == "Hindi (हिंदी)",
                onSelected: () {
                  _onLanguageSelected("Hindi (हिंदी)");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _onLanguageSelected(String language) {
    setState(() {
      selectedLanguage = language;
    });
    // Implement language conversion logic here
  }
}

class MyStyledButton extends StatelessWidget {
  final String buttonText;
  final Widget pageWidget;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final bool hasShadow;

  const MyStyledButton({
    required this.buttonText,
    required this.pageWidget,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor = Colors.transparent,
    this.hasShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        boxShadow: hasShadow
            ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ]
            : [],
      ),
      child: ElevatedButton(
        onPressed: () {
          if (buttonText == "Sign Up" || buttonText == 'Sign In') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => pageWidget,
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          onPrimary: textColor,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}

class LanguageSelector extends StatelessWidget {
  final String selectedLanguage;
  final Function(String) onLanguageSelected;

  const LanguageSelector({
    required this.selectedLanguage,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showLanguageDialog(context);
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 30,
        child: Icon(Icons.language, color: Colors.teal),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LanguageOption(
                language: "English",
                isSelected: selectedLanguage == "English",
                onSelected: () {
                  onLanguageSelected("English");
                  Navigator.pop(context);
                },
              ),
              LanguageOption(
                language: "Kannada (ಕನ್ನಡ)",
                isSelected: selectedLanguage == "Kannada (ಕನ್ನಡ)",
                onSelected: () {
                  onLanguageSelected("Kannada (ಕನ್ನಡ)");
                  Navigator.pop(context);
                },
              ),
              LanguageOption(
                language: "Hindi (हिंदी)",
                isSelected: selectedLanguage == "Hindi (हिंदी)",
                onSelected: () {
                  onLanguageSelected("Hindi (हिंदी)");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class LanguageOption extends StatelessWidget {
  final String language;
  final bool isSelected;
  final Function() onSelected;

  const LanguageOption({
    required this.language,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(language),
            if (isSelected) Icon(Icons.check, color: Colors.teal),
          ],
        ),
      ),
    );
  }
}

String getHeaderText(String selectedLanguage) {
  return 'EmPoverty';
}
