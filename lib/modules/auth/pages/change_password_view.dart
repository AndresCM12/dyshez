import 'package:auto_route/auto_route.dart';
import 'package:dyshez_test/modules/auth/cubits/auth/auth_cubit.dart';
import 'package:dyshez_test/widgets/async_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

final changePasswordFormKey = GlobalKey<FormBuilderState>();

@RoutePage()
class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: FormBuilder(
          key: changePasswordFormKey,
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
                  "Cambiar contraseña",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                FormBuilderTextField(
                  name: 'password',
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Campo requerido' : null,
                  onChanged: (value) {
                    changePasswordFormKey.currentState!.save();
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
                  validator: (value) => value == null || value.isEmpty
                      ? 'Campo requerido'
                      : changePasswordFormKey.currentState!.value['password'] !=
                              value
                          ? 'Las contraseñas no coinciden'
                          : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Verificar contraseña',
                    icon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                AsyncButtonWidget(
                  buttonText: "Cambiar contraseña",
                  onPressed: () async {
                    if (changePasswordFormKey.currentState!.saveAndValidate()) {
                      final values = changePasswordFormKey.currentState!.value;
                      await context.read<AuthCubit>().changePassword(
                            password: values['password'].toString(),
                            context: context,
                          );
                    }
                  },
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
