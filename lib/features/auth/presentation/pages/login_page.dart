// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:logiology_app/app/routes/app_routes.dart';
// import '../controllers/auth_controller.dart';
// // import '../../../app/routes/app_routes.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final AuthController controller = Get.put(AuthController());

//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               decoration: const InputDecoration(labelText: 'Username'),
//               onChanged: (value) => controller.username.value = value,
//             ),
//             TextField(
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//               onChanged: (value) => controller.password.value = value,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 if (controller.validateLogin()) {
//                   Get.offNamed(AppRoutes.home);
//                 } else {
//                   Get.snackbar('Error', 'Invalid credentials');
//                 }
//               },
//               child: const Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology_app/app/routes/app_routes.dart';
import 'package:logiology_app/core/themes/app_theme.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());
    final AppTheme theme = AppTheme();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A2A44), Color.fromARGB(255, 10, 19, 28)],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/logo/logiologylogo.png',
                          height: 200,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Login to your account',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (value) =>
                                controller.username.value = value,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Obx(() => TextField(
                                  style: TextStyle(color: Colors.white),
                                  obscureText:
                                      controller.isPasswordHidden.value,
                                  onChanged: (value) =>
                                      controller.password.value = value,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle:
                                        theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        controller.isPasswordHidden.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        controller.isPasswordHidden.value =
                                            !controller.isPasswordHidden.value;
                                      },
                                    ),
                                  ),
                                ))),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot Password?',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1B263B),
                              minimumSize: const Size(100, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              if (controller.validateLogin()) {
                                Get.offNamed(AppRoutes.home);
                              } else {
                                Get.snackbar('Error', 'Invalid credentials');
                              }
                            },
                            child: Text(
                              'LOGIN',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
