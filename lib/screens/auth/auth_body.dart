import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:koperasitenantapp/bloc/auth/auth_bloc.dart';
import 'package:koperasitenantapp/init/util/nfc.dart';
import 'package:koperasitenantapp/models/auth/auth_request.dart';
import 'package:koperasitenantapp/service/storage.dart';
import 'package:koperasitenantapp/themes/assets.dart';
import 'package:koperasitenantapp/themes/colors.dart';
import 'package:koperasitenantapp/themes/widgets/buttons.dart';
import 'package:koperasitenantapp/themes/widgets/loading.dart';

class AuthBody extends StatefulWidget {
  const AuthBody({super.key});

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool? _hidePassword = true;
  final AuthRequest _credentials = AuthRequest(cardId: "", pin: "");

  @override
  void initState() {
    super.initState();
    NFCReader.startNfc(
      onDetected: (uid) {
        // Put ID to username
        _username.text = uid;
      },
    );
  }

  void _togglePassword() {
    setState(() {
      _hidePassword = !_hidePassword!;
    });
  }

  void _login() {
    _credentials.cardId = _username.value.text;
    _credentials.pin = _password.value.text;

    if (_credentials.allowLogin()) {
      /**
       * Login Procedure is here
       */
      context.read<AuthBloc>().add(AuthLogin(_credentials));
    } else {
      // Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text("Username dan Password harus diisi!")),
      );
    }
  }

  @override
  void dispose() {
    NFCReader.closeNfc();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.authBg),
          fit: BoxFit.cover,
          alignment: Alignment.center
        ),
      ),
      padding: EdgeInsets.fromLTRB(30.0, 90.0, 30.0, 15.0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /* 
            1. Logo
            2. Form: Merchant ID, Password
          */
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: CustomColor.whiteColor,
            ),
            child: Image.asset(Assets.logo, width: 150.0),
          ),
          SizedBox(height: 30.0),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: CustomColor.whiteColor,
            ),
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _username,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 2.0,
                      horizontal: 5.0,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  style: Theme.of(context).textTheme.labelLarge,
                  onFieldSubmitted: (v) {
                    // Check username
                    print("Changed Username");
                  },
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  controller: _password,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 2.0,
                      horizontal: 5.0,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: Theme.of(context).textTheme.labelLarge,
                    suffixIcon: IconButton(
                      iconSize: 16.0,
                      onPressed: () => _togglePassword(),
                      icon: Icon(
                        _hidePassword!
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: _hidePassword!,
                  style: Theme.of(context).textTheme.labelLarge,
                  onFieldSubmitted: (v) {
                    // Check password
                    print("Changed Password");
                  },
                ),
                SizedBox(height: 30.0),
                BlocListener<AuthBloc, AuthState>(
                  listener: (_, state) {
                    if (state is AuthLoadSuccess) {
                      /* Post Login Action */
                      /**
                 * 1. Write data to storage
                 * 2. Move to home
                 */
                      context.read<SecureStorage>().storeToken(
                        state.data.authToken!,
                      );
                      context.read<SecureStorage>().storeCredentials(
                        state.data,
                      );
                      context.goNamed("home");
                    }

                    if (state is AuthLoadFailed) {
                      /**
                 * Do error procedure
                 */
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }

                    if (state is AuthLoading) {
                      /* Do Nothing */
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text("Login sedang dalam proses..")),
                      // );
                    }
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (_, state) {
                            if (state is AuthLoading) {
                              return Loading();
                            }

                            return PrimaryButton(
                              onPress: () => _login(),
                              label: "Login",
                            );
                          },
                        ),
                      ),
                    ],
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
