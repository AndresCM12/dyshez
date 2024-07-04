import 'package:auto_route/auto_route.dart';
import 'package:dyshez_test/config/app_router.gr.dart';
import 'package:dyshez_test/modules/auth/cubits/auth/auth_cubit.dart';
import 'package:dyshez_test/widgets/async_button_widget.dart';
import 'package:dyshez_test/widgets/password_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

final logInUpFormKey = GlobalKey<FormBuilderState>();

@RoutePage()
class LogInView extends StatelessWidget {
  const LogInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: FormBuilder(
          key: logInUpFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
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
                  "Iniciar Sesión",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                FormBuilderTextField(
                  name: 'email',
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Campo requerido' : null,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: 'Correo Electrónico',
                    icon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const PasswordFieldWidget(
                  keyName: "password",
                  name: "password",
                  label: "Contraseña",
                  hintText: "",
                ),
                const SizedBox(height: 16),
                AsyncButtonWidget(
                  buttonText: "Iniciar Sesión",
                  onPressed: () async {
                    if (logInUpFormKey.currentState!.saveAndValidate()) {
                      final values = logInUpFormKey.currentState!.value;
                      await context.read<AuthCubit>().logInWithEmailAndPassword(
                            email: values['email'].toString(),
                            password: values['password'].toString(),
                            context: context,
                          );
                    }
                  },
                  color: null,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "¿No tienes Cuenta?",
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () =>
                          AutoRouter.of(context).push(const SignUpView()),
                      child: Text(
                        "Crea una nueva cuenta",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color.fromRGBO(227, 2, 111, 1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
                Divider(
                  height: 16,
                  color: Colors.grey[200],
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "¿Olvidaste tu contraseña?",
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => AutoRouter.of(context)
                          .push(const RecoverPasswordView()),
                      child: Text(
                        "Recupera tu cuenta",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color.fromRGBO(227, 2, 111, 1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
