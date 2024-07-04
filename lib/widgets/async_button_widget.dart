import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//This widget is used to show feedback button when user is waiting for a response in async operations
class AsyncButtonWidget extends StatefulWidget {
  final String buttonText;
  final Future<void> Function() onPressed;
  final Color? color;

  const AsyncButtonWidget({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.color,
  });

  @override
  State<AsyncButtonWidget> createState() => _AsyncButtonWidgetState();
}

class _AsyncButtonWidgetState extends State<AsyncButtonWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FilledButton(
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16)),
        backgroundColor: widget.color == null
            ? MaterialStateProperty.all(theme.colorScheme.primary)
            : MaterialStateProperty.all(widget.color),
        enableFeedback: true,
      ),
      onPressed: isLoading ? null : changeButtonState,
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: theme.colorScheme.onPrimary,
                strokeWidth: 2.0,
              ),
            )
          : Text(
              widget.buttonText,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }

  changeButtonState() async {
    setState(() => isLoading = true);
    await widget.onPressed();
    setState(() => isLoading = false);
  }
}
