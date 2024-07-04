import 'package:auto_route/auto_route.dart';
import 'package:dyshez_test/modules/auth/cubits/auth/auth_cubit.dart';
import 'package:dyshez_test/widgets/async_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

final signUpFormKey = GlobalKey<FormBuilderState>();

@RoutePage()
class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: FormBuilder(
            key: signUpFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 58),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Image(
                      image: AssetImage('assets/logo.png'),
                      height: 65,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Crear Cuenta",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FormBuilderTextField(
                    name: 'username',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Campo requerido'
                        : null,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      icon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'full_name',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Campo requerido'
                        : null,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'Nombre Completo',
                      icon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'email',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Campo requerido'
                        : null,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      icon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'phone_number',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Campo requerido'
                        : null,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'Teléfono',
                      icon: Icon(Icons.phone_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'password',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Campo requerido'
                        : null,
                    onChanged: (value) {
                      signUpFormKey.currentState!.save();
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      icon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'verify_password',
                    obscureText: true,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Campo requerido'
                        : signUpFormKey.currentState!.value['password'] != value
                            ? 'Las contraseñas no coinciden'
                            : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'Verificar contraseña',
                      icon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AsyncButtonWidget(
                    buttonText: "Crear cuenta",
                    onPressed: () async {
                      if (signUpFormKey.currentState!.saveAndValidate()) {
                        final values = signUpFormKey.currentState!.value;
                        await context
                            .read<AuthCubit>()
                            .createUserWithEmailAndPassword(
                              userName: values['username'],
                              name: values['full_name'],
                              email: values['email'],
                              phone: values['phone_number'],
                              password: values['password'],
                              context: context,
                            );
                      }
                    },
                    color: Colors.black,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "¿Ya tienes una cuenta",
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => context.router.maybePop(),
                        child: Text(
                          "Iniciar Sesión",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color.fromRGBO(227, 2, 111, 1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
