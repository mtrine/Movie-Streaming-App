import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_streaming_app/core/constants/app_color.dart';
import 'package:movie_streaming_app/core/widget/background_app.dart';
import 'package:movie_streaming_app/core/widget/round_text_field.dart';
import 'package:movie_streaming_app/features/auth/bloc/auth_bloc.dart';
import 'package:movie_streaming_app/features/auth/utils/utils.dart';

import '../../../../core/constants/constants.dart';
import '../../reponsitory/auth_reponsitory.dart';
import '../widget/round_button.dart';
final _formKey = GlobalKey<FormState>();
class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});
  static const routeName = '/create-account';
  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmController;
  late final TextEditingController _usernameController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
    _usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _usernameController.dispose();
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
              child: SingleChildScrollView(
                child: Padding(
                    padding: Constants.defaultPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: const Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.whiteColor,
                              size:30
                          ),
                        ),
                        SizedBox(height: size.height/20),
                        const Text(
                          'Create \nAccount',
                          style:TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 35,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 20,),
                        BlocBuilder<AuthBloc,AuthState>(
                          builder:(context,state)=> Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  RoundTextField(
                                    onChanged:(value)=> context.read<AuthBloc>().add(EmailChanged(value!),),
                                    controller: _emailController,
                                    hintText: 'example@mail.com',
                                    title: 'Email',
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    validator: validateEmail,
                                  ),
                                  const SizedBox(height: 20),
                                  RoundTextField(
                                    onChanged:(value)=> context.read<AuthBloc>().add(UsernameChanged(value!),),
                                    controller: _usernameController,
                                    hintText: '',
                                    title: 'Username',
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    validator: validateUsername,
                                  ),
                                  const SizedBox(height: 20),
                                  RoundTextField(
                                    onChanged:(value)=> context.read<AuthBloc>().add(PasswordChanged(value!),),
                                    controller: _passwordController,
                                    hintText: '',
                                    isPassword: true,
                                    title: 'Password',
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.next,
                                    validator: validatePassword,
                                  ),
                                  const SizedBox(height: 20),
                                  RoundTextField(
                                    onChanged:(value)=> context.read<AuthBloc>().add(ConfirmPasswordChanged(value!),),
                                    controller: _confirmController,
                                    hintText: '',
                                    title: 'Confirm Password',
                                    isPassword: true,
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) =>
                                        validateConfirmPassword(_passwordController.text, value),
                                  ),
                                  const SizedBox(height: 30),
                                  RoundButton(
                                    size: size,
                                    text: 'Create Account',
                                    onPressed: ()=>context.read<AuthBloc>().add(SignUp()),
                                  )
                                ],
                              ),
                            ),
                        ),
                      ],
                    )
                ),
              ),
          )
      ),
    );
  }
}


