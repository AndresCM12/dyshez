import 'package:auto_route/auto_route.dart';
import 'package:dyshez_test/config/app_router.gr.dart';
import 'package:dyshez_test/data/repositories/auth_repository.dart';
import 'package:dyshez_test/modules/auth/cubits/auth/auth_cubit.dart';
import 'package:dyshez_test/widgets/async_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

final recoverPasswordFormKey = GlobalKey<FormBuilderState>();

@RoutePage()
class RecoverPasswordView extends StatefulWidget {
  const RecoverPasswordView({Key? key}) : super(key: key);

  @override
  State<RecoverPasswordView> createState() => _RecoverPasswordViewState();
}

class _RecoverPasswordViewState extends State<RecoverPasswordView> {
  final locator = GetIt.instance;

  @override
  void initState() {
    context.read<AuthCubit>().initRestorePasswordListener(context);
    super.initState();
  }

  @override
  void dispose() {
    //We cant call the cancelRestorePasswordListener method from the AuthCubit because the context is already disposed
    locator<AuthRepository>().cancelAuthStateChangeListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: FormBuilder(
          key: recoverPasswordFormKey,
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
                  "Recuperar Cuenta",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                FormBuilderTextField(
                  name: 'email_recover',
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Campo requerido' : null,
                  decoration: const InputDecoration(
                    labelText: 'Correo Electrónico',
                    icon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                AsyncButtonWidget(
                  buttonText: "Restablecer",
                  onPressed: () async {
                    if (recoverPasswordFormKey.currentState!
                        .saveAndValidate()) {
                      final values = recoverPasswordFormKey.currentState!.value;
                      await context.read<AuthCubit>().restoreAccount(
                            email: values['email_recover'].toString(),
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
                      "¿No tienes Cuenta?",
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () =>
                          AutoRouter.of(context).push(const SignUpView()),
                      child: Text(
                        "Crea una Cuenta",
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
    );
  }
}
