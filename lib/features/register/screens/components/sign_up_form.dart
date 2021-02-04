import 'package:flutter/material.dart';
import 'package:microblogging/core/util/validators.dart';
import 'package:microblogging/features/register/models/user.dart';
import 'package:microblogging/features/register/provider/user_manager.dart';
import 'package:microblogging/features/register/screens/components/button_widget.dart';
import 'package:microblogging/features/register/screens/components/device_config.dart';
import 'package:microblogging/features/register/screens/components/input_field.dart';

import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key key,
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm>
    with AutomaticKeepAliveClientMixin {
  String username, email, password;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final User user = User();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    DeviceData deviceData = DeviceData.init(context);

    return Consumer<UserManager>(builder: (context, userManager, __) {
      return Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.only(
                  left: deviceData.screenWidth * 0.11,
                  right: deviceData.screenWidth * 0.11,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InputField(
                      inputType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.words,
                      hintText: "Full name",
                      onValidator: (name) {
                        if (name.isEmpty)
                          return 'Field Required';
                        else if (name.trim().split(' ').length <= 1)
                          return 'Full name required';
                        return null;
                      },
                      onSaved: (name) => user.name = name,
                    ),
                    SizedBox(height: deviceData.screenHeight * 0.02),
                    InputField(
                      inputType: TextInputType.emailAddress,
                      hintText: "Enter e-mail",
                      onValidator: (email) {
                        if (email.isEmpty)
                          return 'Field Required';
                        else if (!emailValid(email)) return 'e-mail Required';
                        return null;
                      },
                      onSaved: (email) => user.email = email,
                    ),
                    SizedBox(height: deviceData.screenHeight * 0.02),
                    InputField(
                      obscureText: true,
                      hintText: "Password",
                      onValidator: (pass) {
                        if (pass.isEmpty)
                          return 'Field Required';
                        else if (pass.length < 6) return 'password less than 6';
                        return null;
                      },
                      onSaved: (pass) => user.password = pass,
                    ),
                    SizedBox(height: deviceData.screenHeight * 0.02),
                    InputField(
                      obscureText: true,
                      hintText: "Password confirm",
                      isLastField: true,
                      onValidator: (pass) {
                        if (pass.isEmpty)
                          return 'Field Required';
                        else if (pass.length < 6) return 'password less than 6';
                        return null;
                      },
                      onSaved: (pass) => user.confirmPassword = pass,
                    ),
                    SizedBox(height: deviceData.screenHeight * 0.03),
                    RoundedButton(
                      text: "Sign-up",
                      onPressed: userManager.loading
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();

                                if (user.password != user.confirmPassword) {
                                  scaffoldKey.currentState
                                      .showSnackBar(const SnackBar(
                                    content: Text('Senhas não coincidem!'),
                                    backgroundColor: Colors.red,
                                  ));
                                  return;
                                }

                                userManager.signUp(
                                    user: user,
                                    onSuccess: () {
                                      Navigator.of(context).pop();
                                    },
                                    onFail: (e) {
                                      scaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                        content: Text('Falha ao cadastrar: $e'),
                                        backgroundColor: Colors.red,
                                      ));
                                    });
                              }
                            },
                    ),
                    SizedBox(
                      height: 40,
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
  bool get wantKeepAlive => true;
}
