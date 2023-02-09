import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final void Function(String)? onChanged;
  final String label;
  final String? hintText;
  final TextInputType? inputType;
  final bool isPassword;
  final String? Function(String?)? validator;
  const InputText({
    Key? key,
    this.onChanged,
    required this.label,
    this.hintText,
    this.inputType,
    this.isPassword = false,
    this.validator,
  }) : super(key: key);

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  late bool _obscureText;
  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: FormField<String>(
        validator: widget.validator,
        initialValue: '',
        autovalidateMode: AutovalidateMode.onUserInteraction,
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                obscureText: _obscureText,
                keyboardType: widget.inputType,
                onChanged: (text) {
                  if (widget.validator != null) {
                    // ignore: invalid_use_of_protected_member
                    state.setValue(text);
                    state.validate();
                  }
                  if (widget.onChanged != null) {
                    widget.onChanged!(text);
                  }
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: widget.label,
                  hintText: widget.hintText,
                  suffixIcon: widget.isPassword
                      ? CupertinoButton(
                          child: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            _obscureText = !_obscureText;
                            setState(() {});
                          },
                        )
                      : Container(
                          width: 0,
                        ),
                ),
              ),
              if (state.hasError)
                Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
