import 'package:flutter/Material.dart';
import 'package:to_do_list/models/to_do_cubit.dart';

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

// Widget buildTaskItem({required Map model, required context}) {
//   return Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: Row(
//       children: [
//         CircleAvatar(
//           radius: 40,
//           child: Text("${model['time']}"),
//         ),
//         const SizedBox(
//           width: 20,
//         ),
//         Expanded(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [Text("${model['title']}"), Text("${model['date']}")],
//           ),
//         ),
//         const SizedBox(
//           width: 20,
//         ),
//         IconButton(
//             onPressed: () {
//               ToDoCubit.get(context).updateStatus(model['id'], model['status']);
//             },
//             icon: Icon(
//               model['status'] == 'true'
//                   ? Icons.check_circle
//                   : Icons.check_circle_outline,
//               color: Colors.blueAccent,
//             )),
//         IconButton(
//             onPressed: () {
//               ToDoCubit.get(context)
//                   .updateArchive(model['id'], model['archived']);
//             },
//             icon: Icon(
//               model['archived'] == 'true'
//                   ? Icons.archive
//                   : Icons.archive_outlined,
//               color: Colors.black45,
//             ))
//       ],
//     ),
//   );
// }

Widget buildTaskItem({
  required Map model,
  required context,
  required bool showCheckCircle,
  required bool showArchiveButton,
}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text("${model['time']}"),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text("${model['title']}"), Text("${model['date']}")],
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        if (showCheckCircle)
          IconButton(
            onPressed: () {
              ToDoCubit.get(context).updateStatus(model['id'], model['status']);
            },
            icon: Icon(
              model['status'] == 'true'
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
              color: Colors.blueAccent,
            ),
          ),
        if (showArchiveButton)
          IconButton(
            onPressed: () {
              ToDoCubit.get(context)
                  .updateArchive(model['id'], model['archived']);
            },
            icon: Icon(
              model['archived'] == 'true'
                  ? Icons.archive
                  : Icons.archive_outlined,
              color: Colors.black45,
            ),
          ),
      ],
    ),
  );
}
