import 'package:flutter/material.dart';

import 'package:feelings/components/loading.dart';
import 'package:feelings/models/index.dart';
import 'package:feelings/global/requests.dart';
import 'package:feelings/global/localization.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _phoneNumController =
      TextEditingController();
  TextEditingController _pwController = TextEditingController();

  bool hidePw = true;
  bool haveErr = false;
  bool isLoading = false;

  submit() async {
    setState(() {
      haveErr = false;
      isLoading = true;
    });
    Login loginInfo = await Requests.loginWithPhoneNPw(
        _phoneNumController.text, _pwController.text);

    setState(() {
      haveErr = loginInfo == null;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    var style = InputDecoration(
      filled: true,
      fillColor: colorScheme.surface,
      focusColor: colorScheme.primary,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: 2,
        ),
      ),
    );
    return Scaffold(
      body: Loading(
        isLoading: isLoading,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 300),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 70, 0, 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "http://static.xiong35.cn/image/icons/open-doodles/3.png",
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  "Feelings",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(
                          color: colorScheme.onBackground),
                ),
                SizedBox(height: 30),
                TextField(
                  cursorColor: colorScheme.secondary,
                  decoration: style.copyWith(
                    hintText: FeelingsLocalization.of(context)
                        .loginPhoneNumber,
                  ),
                  controller: _phoneNumController,
                ),
                SizedBox(height: 20),
                TextFormField(
                  cursorColor: colorScheme.secondary,
                  decoration: style.copyWith(
                    hintText: FeelingsLocalization.of(context)
                        .loginPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        hidePw
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () =>
                          setState(() => hidePw = !hidePw),
                      splashColor: Colors.transparent,
                    ),
                  ),
                  controller: _pwController,
                  obscureText: !hidePw,
                  validator: (v) => haveErr
                      ? FeelingsLocalization.of(context)
                          .loginErrorHint
                      : null,
                ),
                SizedBox(height: 30),
                Text(
                  "*" +
                      FeelingsLocalization.of(context)
                          .loginHint,
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(height: 20),
                RaisedButton(
                  onPressed: submit,
                  child: Text(
                    FeelingsLocalization.of(context).loginLogin,
                    style: TextStyle(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  color: colorScheme.secondary,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
