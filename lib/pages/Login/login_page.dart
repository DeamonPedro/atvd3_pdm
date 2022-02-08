import 'package:atvd3_pdm/services/auth_service.dart';
import 'package:feather_icons_svg/feather_icons_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final AuthService authService = AuthService.instance;

  final TextEditingController emailController =
      TextEditingController(text: 'one@test.com');
  final TextEditingController passController =
      TextEditingController(text: '123456');

  bool _isLoading = false;

  void onPressLogin() {
    print(emailController.text + passController.text);
    setState(() {
      _isLoading = true;
    });
    authService
        .tryLogin(emailController.text, passController.text)
        .then((value) {
          Navigator.pushNamed(context, '/home');
        })
        .catchError((_) => null)
        .whenComplete(
          () => setState(() {
            _isLoading = false;
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff161616), Color(0xff595959)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FeatherIcon(
                      FeatherIcons.bookOpen,
                      color: Color(0xff735E5E),
                      size: 150,
                    ),
                    Text(
                      'Black Notes',
                      style: TextStyle(
                        color: Color(0xff735E5E),
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Column(
                    children: [
                      emailTextField(controller: emailController),
                      passTextField(controller: passController),
                      loginButton(context)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginButton(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        minimumSize:
            MaterialStateProperty.all<Size>(const Size(double.infinity, 55)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
        backgroundColor: MaterialStateProperty.all(const Color(0xff262626)),
      ),
      onPressed: onPressLogin,
      child: _isLoading
          ? const CircularProgressIndicator()
          : const Text(
              'Log in',
              style: TextStyle(
                color: Color(0xff616161),
                fontSize: 30,
              ),
            ),
    );
  }

  Widget emailTextField({required TextEditingController controller}) {
    const inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
      borderSide: BorderSide(
        width: 3,
        style: BorderStyle.solid,
        color: Color(0xff735E5E),
      ),
    );

    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 20),
      child: Row(
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 55, minHeight: 55),
            padding: const EdgeInsetsDirectional.all(8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              color: Color(
                0xff735E5E,
              ),
              border: Border.fromBorderSide(
                BorderSide(
                  width: 3,
                  style: BorderStyle.solid,
                  color: Color(0xff735E5E),
                ),
              ),
            ),
            child: const FeatherIcon(
              FeatherIcons.atSign,
              color: Color(
                0xff262626,
              ),
              strokeWidth: 1.5,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              style: const TextStyle(
                backgroundColor: Colors.transparent,
                fontSize: 20,
                height: 0.75,
              ),
              decoration: const InputDecoration(
                  enabledBorder: inputBorder,
                  border: inputBorder,
                  focusedBorder: inputBorder,
                  disabledBorder: inputBorder,
                  errorBorder: inputBorder,
                  focusedErrorBorder: inputBorder),
            ),
          ),
        ],
      ),
    );
  }

  Widget passTextField({required TextEditingController controller}) {
    const inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
      borderSide: BorderSide(
        width: 3,
        style: BorderStyle.solid,
        color: Color(0xff735E5E),
      ),
    );

    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 20),
      child: Row(
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 55, minHeight: 55),
            padding: const EdgeInsetsDirectional.all(8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              color: Color(
                0xff735E5E,
              ),
              border: Border.fromBorderSide(
                BorderSide(
                  width: 3,
                  style: BorderStyle.solid,
                  color: Color(0xff735E5E),
                ),
              ),
            ),
            child: const FeatherIcon(
              FeatherIcons.key,
              color: Color(
                0xff262626,
              ),
              strokeWidth: 1.5,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              style: const TextStyle(
                backgroundColor: Colors.transparent,
                fontSize: 20,
                height: 0.75,
              ),
              decoration: const InputDecoration(
                  enabledBorder: inputBorder,
                  border: inputBorder,
                  focusedBorder: inputBorder,
                  disabledBorder: inputBorder,
                  errorBorder: inputBorder,
                  focusedErrorBorder: inputBorder),
            ),
          ),
        ],
      ),
    );
  }
}
