// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawawin_student/logics/profile/profile_bloc.dart';
import 'package:nawawin_student/utils/constanst.dart';
import 'package:nawawin_student/utils/widget.dart';
import 'package:nawawin_student/views/edit_profile.dart';
import 'package:sliver_tools/sliver_tools.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return BlocProvider.value(
      value: context.read<ProfileBloc>()
        ..add(const FetchProfile(studentId: '42')),
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            context
                .read<ProfileBloc>()
                .add(const FetchProfile(studentId: '42'));
          },
          child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(icprofileBg), fit: BoxFit.cover)),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: false,
                    leadingWidth: 10,
                    leading: IconButton(
                      onPressed: () {
                        log("kjdbsbbbbbbbbbbbf-------------------------->");
                        ntrkey.currentState?.pop();
                      },
                      icon: const Icon(Icons.arrow_back,
                          color: AppColors.textColor, size: 30),
                    ),
                    // iconTheme: const IconThemeData(
                    //     color: AppColors.textColor, size: 35),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(90),
                      child: CircleAvatar(
                        radius: 50,
                        child: ClipRRect(
                          child: Image.asset(
                            icprofileface,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoading) {
                        return const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 2,
                            )),
                          ),
                        );
                      }
                      if (state is ProfileTimeout) {
                        return const TokenExpierdWidget();
                      }
                      if (state is Nointernet) {
                        return const SliverFillRemaining(
                            child: NoInternetWidget(routeName: '/profile'));
                      }
                      if (state is ProfileSuccess) {
                        return MultiSliver(
                          children: [
                            SliverToBoxAdapter(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          elevation: 50,
                                          shadowColor: AppColors.kLightgrey
                                              .withOpacity(0.4),
                                          color: AppColors.kwhite,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                        child: appTextView(
                                                            name:
                                                                "Student Name",
                                                            align: TextAlign
                                                                .left)),
                                                    Expanded(
                                                      child: appTextView(
                                                          name: ":",
                                                          align:
                                                              TextAlign.center,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Expanded(
                                                        child: appTextView(
                                                            name: state
                                                                .profileModel
                                                                .masterDetails[
                                                                    0]
                                                                .pscStuName,
                                                            align: TextAlign
                                                                .right))
                                                  ],
                                                ),
                                                setHeight(15),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                        child: appTextView(
                                                            name: "Student ID",
                                                            align: TextAlign
                                                                .left)),
                                                    Expanded(
                                                      child: appTextView(
                                                          name: ":",
                                                          align:
                                                              TextAlign.center,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Expanded(
                                                        child: appTextView(
                                                            name: state
                                                                .profileModel
                                                                .masterDetails[
                                                                    0]
                                                                .stuId,
                                                            align: TextAlign
                                                                .right))
                                                  ],
                                                ),
                                                setHeight(15),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                        child: appTextView(
                                                            name: "Course Name",
                                                            align: TextAlign
                                                                .left)),
                                                    Expanded(
                                                      child: appTextView(
                                                          name: ":",
                                                          align:
                                                              TextAlign.center,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Expanded(
                                                        child: appTextView(
                                                            name: state
                                                                .profileModel
                                                                .masterDetails[
                                                                    0]
                                                                .couName,
                                                            align: TextAlign
                                                                .right))
                                                  ],
                                                ),
                                                setHeight(15),
                                                const Divider(
                                                    color: AppColors.kDivider),
                                                setHeight(15),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        child: appTextView(
                                                            name:
                                                                "Promoter Name",
                                                            align: TextAlign
                                                                .left)),
                                                    Expanded(
                                                      child: appTextView(
                                                          name: ":",
                                                          align:
                                                              TextAlign.center,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Expanded(
                                                        child: appTextView(
                                                            name: state
                                                                .profileModel
                                                                .masterDetails[
                                                                    0]
                                                                .promoter,
                                                            align: TextAlign
                                                                .right))
                                                  ],
                                                ),
                                                setHeight(15),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                        child: appTextView(
                                                            name:
                                                                "Promoter ID  ",
                                                            align: TextAlign
                                                                .left)),
                                                    Expanded(
                                                      child: appTextView(
                                                          name: ":",
                                                          align:
                                                              TextAlign.center,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Expanded(
                                                        child: appTextView(
                                                            name: state
                                                                .profileModel
                                                                .masterDetails[
                                                                    0]
                                                                .code,
                                                            align: TextAlign
                                                                .right))
                                                  ],
                                                ),
                                                setHeight(15),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                        child: appTextView(
                                                            name:
                                                                "Contact Number  ",
                                                            align: TextAlign
                                                                .left)),
                                                    Expanded(
                                                      child: appTextView(
                                                          name: ":",
                                                          align:
                                                              TextAlign.center,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Expanded(
                                                        child: appTextView(
                                                            name: state
                                                                .profileModel
                                                                .masterDetails[
                                                                    0]
                                                                .pscMobNo,
                                                            align: TextAlign
                                                                .right))
                                                  ],
                                                ),
                                                setHeight(15),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        child: appTextView(
                                                            name: "Address  ",
                                                            align: TextAlign
                                                                .left)),
                                                    Expanded(
                                                      child: appTextView(
                                                          name: ":",
                                                          align:
                                                              TextAlign.center,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Expanded(
                                                        child: appTextView(
                                                            maxLines: 5,
                                                            name: state
                                                                .profileModel
                                                                .masterDetails[
                                                                    0]
                                                                .pscAddress,
                                                            align: TextAlign
                                                                .right))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ]),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: w / 4, right: w / 4),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.kYellow,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),

                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontStyle: FontStyle.normal,
                                    ),
                                    elevation:
                                        6, // Add elevation for box shadow
                                    shadowColor: AppColors.kYellow,
                                  ),
                                  onPressed: () async {
                                    final result = await ntrkey.currentState
                                        ?.pushNamed('/editprofile',
                                            arguments: EditProfileArguments(
                                              studentName: state.profileModel
                                                  .masterDetails[0].pscStuName,
                                              courseName: state.profileModel
                                                  .masterDetails[0].couName,
                                              address: state.profileModel
                                                  .masterDetails[0].pscAddress,
                                              contactnumber: state.profileModel
                                                  .masterDetails[0].pscMobNo,
                                            ));
                                    if (result == 'success') {
                                      context.read<ProfileBloc>().add(
                                          const FetchProfile(studentId: '11'));

                                      errorSnack.currentState?.showSnackBar(
                                          alertSnackbar(
                                              message:
                                                  'Coordinator Details Updated Successfully',
                                              backgroundColor:
                                                  Colors.green.shade400,
                                              leading: const Icon(
                                                  CupertinoIcons
                                                      .checkmark_alt_circle,
                                                  color: Colors.white)));
                                    }
                                  },
                                  child: appTextView(
                                      name: 'Edit Profile',
                                      color: AppColors.kwhite),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                      return const SliverToBoxAdapter();
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
