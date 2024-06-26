import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/constants.dart';
import '../../../auth/bloc/auth_bloc.dart';
import '../widget/button_personal.dart';

class Personal extends StatelessWidget {
  const Personal({super.key});
  static const routeName = '/personal';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff0A071E),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Personal',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.darkPurpleColor,
      ),
      body: Padding(
        padding: Constants.defaultPadding,
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status== AuthStatus.success) {
              Navigator.of(context).pushReplacementNamed('/login');
            } else if (state.status== AuthStatus.error) {
              // Hiển thị thông báo lỗi nếu có lỗi xảy ra
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMsg ?? 'An error occurred')),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                ButtonPersonal(
                  size: size,
                  text: 'Watched list',
                  onPressed: () {
                    Navigator.pushNamed(context, '/watchList');
                  },
                ),
                const SizedBox(height: 20),
                ButtonPersonal(
                  size: size,
                  text: 'Sign Out',
                  onPressed: () {
                    context.read<AuthBloc>().add(SignOut());
                  },
                ),

              ],
            );
          },
        ),
      ),
    );
  }
}

