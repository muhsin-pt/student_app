// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nawawin_student/logics/courseDetails/course_deails_bloc.dart';
import 'package:nawawin_student/utils/constanst.dart';
import 'package:nawawin_student/utils/widget.dart';
import 'package:nawawin_student/views/course_notes.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:url_launcher/url_launcher.dart';

class CoursePage extends StatelessWidget {
  CoursePage({super.key});

  final isNotes = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return BlocProvider.value(
      value: context.read<CourseDeailsBloc>()
        ..add(const FetchCourseDetails(studId: '42')),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(icBg),
              fit: BoxFit.cover,
            ),
          ),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: false,
                leadingWidth: 10,
                //pinned: true,
                leading: Container(),
                title: appTextView(
                    name: 'Course Details',
                    size: 16,
                    color: AppColors.kBlack,
                    fontWeight: FontWeight.w500),
              ),
              //////////////////banner -------------------->
              BlocBuilder<CourseDeailsBloc, CourseDeailsState>(
                builder: (context, state) {
                  if (state is CourseDeailsLoading) {
                    return const SliverToBoxAdapter(
                        child: Center(
                      child: CircularProgressIndicator(),
                    ));
                  }

                  if (state is CourseDeailsTimeout) {
                    return const SliverToBoxAdapter(
                      child: TokenExpierdWidget(),
                    );
                  }

                  if (state is CourseDeailsSuccess) {
                    return MultiSliver(
                      children: [
                        SliverToBoxAdapter(
                          child: CarouselSlider.builder(
                              options: CarouselOptions(
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                  aspectRatio: 20 / 8,
                                  enableInfiniteScroll: true,
                                  viewportFraction: 0.9),
                              itemCount: 5,
                              itemBuilder: (BuildContext context, int itemIndex,
                                      int pageViewIndex) =>
                                  Padding(
                                      padding: const EdgeInsets.only(),
                                      child: SizedBox(
                                        height: h / 10,
                                        width: w,
                                        child: Container(
                                          width: w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                icBanner,
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ))),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              setHeight(15),
                              Container(
                                width: w - 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColors.kwhite),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      appTextView(
                                          name: state.courseDetailsModel
                                              .masterDetails[0].couName,
                                          fontWeight: FontWeight.bold,
                                          size: 16),
                                      setHeight(3),
                                      appTextView(
                                          name: state.courseDetailsModel
                                              .masterDetails[0].couDescription,
                                          maxLines: 10,
                                          align: TextAlign.left),
                                    ],
                                  ),
                                ),
                              ),
                              setHeight(15),
                            ],
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: ValueListenableBuilder(
                                valueListenable: isNotes,
                                builder: (context, value, _) {
                                  return Row(
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: value
                                              ? AppColors.kwhite
                                              : AppColors.kYellow,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        onPressed: () {
                                          isNotes.value = false;
                                        },
                                        child: appTextView(
                                            name: 'Recorded Videos'),
                                      ),
                                      setWidth(10),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: value
                                              ? AppColors.kYellow
                                              : AppColors.kwhite,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        onPressed: () {
                                          isNotes.value = true;
                                        },
                                        child: appTextView(name: 'Notes'),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ),
                        ValueListenableBuilder(
                            valueListenable: isNotes,
                            builder: (context, value, _) {
                              if (value == true) {
                                ///notes ui ------------------------->
                                return SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                  childCount: state
                                      .courseDetailsModel.noteRecords.length,
                                  (context, index) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, top: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.kwhite,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/ic_demo.png',
                                              height: 60,
                                            ),
                                            setWidth(10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                appTextView(
                                                    name: state
                                                        .courseDetailsModel
                                                        .noteRecords[index]
                                                        .clasRecNoteName,
                                                    maxLines: 2,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                // appTextView(name: '15 minutes')
                                              ],
                                            ),
                                            const Spacer(),

                                            // NOTES=============================================

                                            GestureDetector(
                                              onTap: () {
                                                ntrkey.currentState?.pushNamed(
                                                    '/notes',
                                                    arguments: GetClassArguments(
                                                        clasRecId: state
                                                            .courseDetailsModel
                                                            .noteRecords[index]
                                                            .clasRecId));
                                              },
                                              child: SvgPicture.asset(
                                                icPlayer,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                              } else {
                                ///// Videos ui----------------------->
                                return SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                  childCount: state
                                      .courseDetailsModel.videoRecords.length,
                                  (context, index) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, top: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.kwhite,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/ic_demo.png',
                                              height: 60,
                                            ),
                                            setWidth(10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                appTextView(
                                                    name: state
                                                        .courseDetailsModel
                                                        .videoRecords[index]
                                                        .clasRecVideoName,
                                                    maxLines: 2,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                appTextView(
                                                    name: state
                                                        .courseDetailsModel
                                                        .videoRecords[index]
                                                        .clasRecVideoDuration)
                                              ],
                                            ),
                                            const Spacer(),
                                            // VIDEO RECORD=================================
                                            GestureDetector(
                                              onTap: () async {
                                                await launchUrl(Uri.parse(state
                                                    .courseDetailsModel
                                                    .videoRecords[index]
                                                    .clasRecVideo));
                                              },
                                              child: SvgPicture.asset(
                                                icPlayer,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                              }
                            }),
                      ],
                    );
                  }
                  return const SliverToBoxAdapter();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
