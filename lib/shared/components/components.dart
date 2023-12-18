import 'package:flutter/Material.dart';
import 'package:to_do_list/models/to_do_cubit.dart';

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

Widget buildTaskItem({
  required Map model,
  required context,
  required bool showCheckCircle,
  required bool showArchiveButton,
}) =>
    Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        ToDoCubit.get(context).deleteTask(model['id']);
      },
      child: Padding(
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
                  ToDoCubit.get(context)
                      .updateStatus(model['id'], model['status']);
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
      ),
    );

Widget taskBuilder(
        {required tasks, required checkCircle, required archiveButton}) =>
    ListView.builder(
      shrinkWrap: true,
      itemCount: tasks.length,
      itemBuilder: (context, index) => buildTaskItem(
        model: tasks[index],
        context: context,
        showCheckCircle: checkCircle,
        showArchiveButton: archiveButton,
      ),
    );
