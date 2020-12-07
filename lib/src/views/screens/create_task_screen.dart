// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:my_study_pal/src/controller/auth_controller.dart';
// import 'package:my_study_pal/src/core/constants.dart';
// import 'package:my_study_pal/src/core/validation_mixin.dart';
// import 'package:my_study_pal/src/views/widgets/app_button.dart';
// import 'package:my_study_pal/src/views/widgets/app_textfield.dart';

// class CreateTaskScreen extends StatefulWidget {
//   @override
//   _CreateTaskScreenState createState() => _CreateTaskScreenState();
// }

// class _CreateTaskScreenState extends State<CreateTaskScreen> {
//   final AuthController authController = AuthController.to;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: GestureDetector(
//             onTap: () => Navigator.pop(context),
//             child: Icon(Icons.arrow_back_ios, color: kBlackColor)),
//         title: Text(
//           'Create New Task',
//           style: TextStyle(color: kBlackColor),
//         ),
//         elevation: 0.0,
//         backgroundColor: Colors.transparent,
//       ),
//       body: GetBuilder<AuthController>(
//         init: AuthController(),
//         builder: (controller) => Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Form(
//               key: authController.formKey,
//               child: Column(
//                 children: [
//                   kMediumVerticalSpacing,
//                   AppTextField(
//                     text: 'Task Name',
//                     keyboardType: TextInputType.text,
//                     textInputAction: TextInputAction.next,
//                     controller: authController.taskNameController,
//                     validator: ValidatorMixin().validateNotEmpty,
//                     onSaved: (value) =>
//                         authController.taskNameController.text = value,
//                   ),
//                   kMediumVerticalSpacing,
//                   AppTextField(
//                     height: 7,
//                     text: 'Task Description',
//                     keyboardType: TextInputType.text,
//                     textInputAction: TextInputAction.next,
//                     controller: authController.taskDescriptionController,
//                     validator: ValidatorMixin().validateNotEmpty,
//                     onSaved: (value) =>
//                         authController.taskDescriptionController.text = value,
//                   ),
//                   kMediumVerticalSpacing,
//                   AppTextField(
//                     text: 'Date',
//                     keyboardType: TextInputType.datetime,
//                     textInputAction: TextInputAction.next,
//                     controller: authController.taskDateController,
//                     validator: ValidatorMixin().validateNotEmpty,
//                     onSaved: (value) =>
//                         authController.taskDateController.text = value,
//                   ),
//                   kMediumVerticalSpacing,
//                   AppTextField(
//                     text: 'Start Time',
//                     keyboardType: TextInputType.datetime,
//                     textInputAction: TextInputAction.next,
//                     controller: authController.taskStartController,
//                     validator: ValidatorMixin().validateNotEmpty,
//                     onSaved: (value) =>
//                         authController.taskStartController.text = value,
//                   ),
//                   kMediumVerticalSpacing,
//                   AppTextField(
//                     text: 'End Time',
//                     keyboardType: TextInputType.datetime,
//                     textInputAction: TextInputAction.next,
//                     controller: authController.taskEndController,
//                     validator: ValidatorMixin().validateNotEmpty,
//                     onSaved: (value) =>
//                         authController.taskEndController.text = value,
//                   ),
//                   kLargeVerticalSpacing,
//                   Row(
//                     children: [
//                       Expanded(
//                         child: AppButton(
//                             label: 'Create Task',
//                             textColor: Colors.white,
//                             color: kPrimaryColor,
//                             onPressed: () {
// //                              _createTask();
//                             }),
//                       )
//                     ],
//                   ),
//                   kLargeVerticalSpacing,
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

// //  void _createTask() {
// //    FocusScope.of(context).unfocus();
// //
// //    if (formKey.currentState.validate()) {
// //      Navigator.of(context).pushReplacement(MaterialPageRoute(
// //        builder: (context) => ScheduleScreen(),
// //      ));
// //    }
// //  }
// }
