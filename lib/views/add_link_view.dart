import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/views/profile_view.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import 'package:tt9_betweener_challenge/views/widgets/my-button_widget.dart';
import 'package:tt9_betweener_challenge/views/widgets/my_text_field.dart';

import '../controllers/add_new_link.dart';
import '../models/link.dart';
import '../models/user.dart';

class AddLinkView extends StatefulWidget {
  static const id = "/AddLinkView";

  @override
  State<AddLinkView> createState() => _AddLinkViewState();
}

class _AddLinkViewState extends State<AddLinkView> {
  late TextEditingController titleController;

  late TextEditingController linkController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    linkController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    linkController.dispose();
    super.dispose();
  }

  addLink() {
    if (_formKey.currentState!.validate()) {
      final body = {
        'title': titleController.text,
        'link': linkController.text,
      };
      addNewLink(context, body).then((checkData) {
        print(checkData);
        if (mounted && checkData == true) {
          Navigator.pop(context);
        }
      }).catchError((err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err.toString()),
          backgroundColor: Colors.blue,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(12),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 60.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  label: 'Title',
                  controller: titleController,
                  hint: 'snapshot',
                  prefix: Icons.text_fields,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter the title';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomTextFormField(
                  controller: linkController,
                  hint: 'Enter your Link',
                  prefix: Icons.link,
                  label: 'link',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter the email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 24.h,
                ),
                MyButton(
                  text: 'Add',
                  onTap: addLink,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
