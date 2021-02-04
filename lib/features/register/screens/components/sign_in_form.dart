import 'package:flutter/material.dart';
import 'package:microblogging/core/util/validators.dart';
import 'package:microblogging/features/register/models/user.dart';
import 'package:microblogging/features/register/provider/user_manager.dart';
import 'package:microblogging/features/register/screens/components/button_widget.dart';
import 'package:microblogging/features/register/screens/components/device_config.dart';
import 'package:microblogging/features/register/screens/components/input_field.dart';

import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key key,
    @required this.scaffoldContext,
  }) : super(key: key);
  final BuildContext scaffoldContext;

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm>
    with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final deviceData = DeviceData.init(context);
    return Consumer<UserManager>(builder: (_, userManager, __) {
      return Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(
                  left: deviceData.screenWidth * 0.11,
                  right: deviceData.screenWidth * 0.11,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InputField(
                      onValidator: (email) {
                        if (!emailValid(email)) return 'E-mail inválido';
                        return null;
                      },
                      hintText: "Enter e-mail",
                      inputType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    SizedBox(height: deviceData.screenHeight * 0.03),
                    InputField(
                      hintText: "Enter password",
                      onValidator: (pass) {
                        if (pass.isEmpty || pass.length < 6)
                          return 'Senha inválida';
                        return null;
                      },
                      obscureText: true,
                      isLastField: true,
                      controller: passController,
                    ),
                    SizedBox(height: deviceData.screenHeight * 0.04),
                    RoundedButton(
                        text: "Logging",
                        onPressed: userManager.loading
                            ? null
                            : () {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState.validate()) {
                                  userManager.signIn(
                                      user: User(
                                          email: emailController.text,
                                          password: passController.text),
                                      onFail: (e) {
                                        scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text('Falha ao entrar: $e'),
                                          backgroundColor: Colors.red,
                                        ));
                                      },
                                      onSuccess: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed("/base");
                                      });
                                }
                              }),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
