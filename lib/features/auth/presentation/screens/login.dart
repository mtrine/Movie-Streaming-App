import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_streaming_app/core/widget/background_app.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widget/round_text_field.dart';
import '../../bloc/auth_bloc.dart';
import '../../reponsitory/auth_reponsitory.dart';
import '../../utils/utils.dart';
import '../widget/round_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const routeName = '/login';
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passController;

  @override
  void initState() {
    _emailController=TextEditingController();
    _passController=TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size= MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AuthBloc(AuthReponsitory()),
      child: Scaffold(
        body: buildBackgroundApp(
            size: size,
            child: Padding(
              padding: Constants.defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Log in',
                    style:TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  BlocBuilder<AuthBloc,AuthState>(
                    builder:(context,state)=> Form(
                      key:_formKey,
                      child: Column(
                        children: [
                          RoundTextField(
                            onChanged:(value)=> context.read<AuthBloc>().add(EmailChanged(value!),),
                            controller: _emailController,
                            hintText:"Email",
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            validator:validateEmail,
                          ),
                          const SizedBox(height: 10,),
                          RoundTextField(
                            onChanged:(value)=> context.read<AuthBloc>().add(PasswordChanged(value!),),
                            controller: _passController,
                            hintText:"Password",
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: true,
                            validator: validatePassword,
                          ),

                          const SizedBox(height: 20,),
                          RoundButton(
                            text: 'Log in',
                            onPressed: () {
                              context.read<AuthBloc>().add(SignIn());
                            },
                            size: size,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                  'Don\'t have an account?',
                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 18
                              ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/create-account');
                                },
                                child: const Text(
                                  'Create account',
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 18
                                ),),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
