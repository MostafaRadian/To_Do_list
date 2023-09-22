import 'package:flutter/Material.dart';

Widget defaultButton({
  var function = print,
  Color color = Colors.indigoAccent,
  double width = 150,
  String text = "Sign in",
}) =>
    Container(
      width: width,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

// ignore: non_constant_identifier_names
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String? value) validate,
  required String label,
  required Color color,
  required Icon prefixIcon,
  double width = double.infinity,
  bool hidden = false,
  Function()? function,
  IconData? suffixIcon,
  Function()? onTap,
  bool isEnabled = true,
}) =>
    SizedBox(
      width: width,
      child: TextFormField(
          controller: controller,
          keyboardType: type,
          obscureText: hidden,
          onTap: onTap,
          enabled: isEnabled,
          decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
              prefixIcon: prefixIcon,
              prefixIconColor: color,
              suffixIcon: IconButton(
                  onPressed: function, icon: Icon(suffixIcon ?? suffixIcon)),
              suffixIconColor: color),
          validator: validate),
    );
