// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, unused_local_variable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawawin_student/logics/course_dropdown/course_dropdwn_bloc.dart';
import 'package:nawawin_student/logics/edit_profile/edit_profile_bloc.dart';
import 'package:nawawin_student/logics/profile/profile_bloc.dart';
import 'package:nawawin_student/utils/constanst.dart';

import '../utils/widget.dart';

class EditProfileArguments {
  final String studentName;
  final String courseName;
  final String address;
  final String contactnumber;
  EditProfileArguments(
      {required this.studentName,
      required this.courseName,
      required this.address,
      required this.contactnumber});
}

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController course1Controller = TextEditingController();
  TextEditingController courseController = TextEditingController();
  ValueNotifier<String?> selectedValue = ValueNotifier(null);
  TextEditingController addressController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as EditProfileArguments;
    return Scaffold(
      backgroundColor: Colors.white,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => EditProfileBloc(),
          ),
          BlocProvider(
            create: (context) => CourseDropdwnBloc(),
          ),
        ],
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
                leading: IconButton(
                    onPressed: () {
                      ntrkey.currentState?.pop();
                    },
                    icon: const Icon(Icons.arrow_back,
                        color: AppColors.textColor)),
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(8),
                  child: Divider(),
                ),
                leadingWidth: 30,
                elevation: 0,
                backgroundColor: AppColors.kwhite,
                pinned: true,
                title: appTextView(
                    name: "Edit Profile",
                    color: AppColors.textColor,
                    size: 17,
                    fontWeight: FontWeight.bold)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formGlobalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      setHeight(8),
                      textfield(
                        label: 'Student Name',
                        validator: (value) {
                          if (value?.trim() == null || value!.trim().isEmpty) {
                            return "Please enter your Student Name";
                          }
                          return null;
                        },
                        type: TextInputType.name,
                        controller: nameController
                          ..text = arguments.studentName,
                      ),
                      setHeight(14),
                      textfield(
                        label: 'Address',
                        validator: (value) {
                          if (value?.trim() == null || value!.trim().isEmpty) {
                            return "Please enter your Address";
                          }
                          return null;
                        },
                        type: TextInputType.streetAddress,
                        controller: addressController..text = arguments.address,
                      ),
                      setHeight(14),
                      textfield(
                        label: 'Contact Number',
                        validator: (value) {
                          if (value?.trim() == null || value!.trim().isEmpty) {
                            return "Please enter your Contact Number";
                          }
                          return null;
                        },
                        type: TextInputType.phone,
                        controller: numberController
                          ..text = arguments.contactnumber,
                      ),
                      setHeight(14),
                      BlocBuilder<CourseDropdwnBloc, CourseDropdwnState>(
                        bloc: CourseDropdwnBloc()..add(FetchCourseDropdown()),
                        builder: (context, state) {
                          if (state is CourseDropdwnSuccess) {
                            selectedValue.value = state
                                .courseDropdownModel.masterDetails[0].couId;
                            return DropdownButtonHideUnderline(
                              child: DropdownButtonFormField2(
                                alignment: AlignmentDirectional.topStart,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                    label: RichText(
                                        text: const TextSpan(
                                            text: 'Course ',
                                            style:
                                                TextStyle(color: Colors.black),
                                            children: [
                                          TextSpan(
                                              text: ' *',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ))
                                        ])),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.30))),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.30)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.30)),
                                    )),
                                hint: Text(arguments.courseName,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13)),
                                dropdownMaxHeight: 200,
                                dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                icon: const Icon(CupertinoIcons.chevron_down),
                                items: state.courseDropdownModel.masterDetails
                                    .map((e) => DropdownMenuItem(
                                          value: e.couId,
                                          child: Text(
                                            e.couName.toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (val) async {
                                  selectedValue.value = '$val';
                                },
                                buttonHeight: 25,
                                buttonWidth: 200,
                                itemHeight: 30,
                                searchController: searchController,
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BlocConsumer<EditProfileBloc, EditProfileState>(
              listener: (context, state) {
                if (state is EditProfileError) {
                  //---------------------add snackbar ------------------------>

                  errorSnack.currentState?.showSnackBar(alertSnackbar(
                      message: "All ready added",
                      backgroundColor: AppColors.kred,
                      leading: Icon(
                        Icons.info,
                        color: AppColors.kwhite,
                      )));
                }
                if (state is EditProfileSuccess) {
                  // edit profile is success then pop ---------------------->

                  ntrkey.currentState?.pop('success');

                  context
                      .read<ProfileBloc>()
                      .add(const FetchProfile(studentId: '11'));
                }
              },
              builder: (context, state) {
                // add circlular progress indicator-------------------->

                if (state is EditProfileLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  );
                }
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: CupertinoButton(
                        color: Colors.green.shade400,
                        child: const Text("Submit"),
                        onPressed: () async {
                          if (formGlobalKey.currentState!.validate()) {
                            Map<String, String> params = {
                              'student_id': '11',
                              'psc_address': addressController.text,
                              'student_name': nameController.text,
                              'mob_no': numberController.text,
                              'cou_id': '${selectedValue.value}',
                            };

                            context.read<EditProfileBloc>().add(
                                  FetchEditprofile(
                                    params: params,
                                  ),
                                );
                          }
                        }),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
