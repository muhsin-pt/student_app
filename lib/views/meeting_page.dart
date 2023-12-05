import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nawawin_student/logics/attendence_create/attendence_create_bloc.dart';
import 'package:nawawin_student/logics/class_links/class_links_bloc.dart';
import 'package:nawawin_student/utils/constanst.dart';
import 'package:nawawin_student/utils/widget.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:url_launcher/url_launcher.dart';

class MeetingPage extends StatelessWidget {
  const MeetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<ClassLinksBloc>()
        ..add(
          const FetchClassLinks(studId: '42'),
        ),
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
                      name: 'Class Zoom Links',
                      size: 16,
                      color: AppColors.kBlack,
                      fontWeight: FontWeight.w500),
                  actions: const [
                    Padding(
                      padding: EdgeInsets.only(right: 18),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/ic_demo_face.png',
                        ),
                        radius: 18,
                      ),
                    )
                  ],
                ),
                BlocBuilder<ClassLinksBloc, ClassLinksState>(
                  builder: (context, state) {
                    if (state is ClassLinksLoading) {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state is ClassLinksCompleted) {
                      if (state.classLinksModel.upcommingClass.isNotEmpty &&
                          state.classLinksModel.todayClass.isNotEmpty) {
                        return MultiSliver(
                          pushPinnedChildren: false,
                          children: [
                            //today class
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      appTextView(
                                        name: DateFormat('MMMM dd').format(
                                            DateTime.parse(state.classLinksModel
                                                .todayClass[index].clsSchdlDate
                                                .toString())),
                                        color: AppColors.kBlack,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Card(
                                          elevation: 5,
                                          color: AppColors.kwhite,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  icClass,
                                                  fit: BoxFit.contain,
                                                ),
                                                setWidth(10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    appTextView(
                                                        name: state
                                                            .classLinksModel
                                                            .todayClass[index]
                                                            .clsSchdlMeetingName,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    setHeight(10),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          icClassCalender,
                                                          height: 15,
                                                        ),
                                                        setWidth(5),
                                                        appTextView(
                                                          name: DateFormat(
                                                                  'MMMM dd')
                                                              .format(DateTime.parse(state
                                                                  .classLinksModel
                                                                  .todayClass[
                                                                      index]
                                                                  .clsSchdlDate
                                                                  .toString())),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          icClock,
                                                          height: 15,
                                                        ),
                                                        setWidth(5),
                                                        appTextView(
                                                          name: state
                                                              .classLinksModel
                                                              .todayClass[index]
                                                              .clsSchdlTimeFrom
                                                              .toString(),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                state
                                                            .classLinksModel
                                                            .todayClass[index]
                                                            .clsSchdlStatus
                                                            .toString()
                                                            .toLowerCase() ==
                                                        "ongoing"
                                                    ? ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor: state
                                                                      .classLinksModel
                                                                      .todayClass[
                                                                          index]
                                                                      .clsSchdlStatus
                                                                      .toLowerCase() ==
                                                                  'ongoing'
                                                              ? AppColors.kGreen
                                                              : AppColors
                                                                  .kYellow,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          //zoom meeting link

                                                          launchUrl(Uri.parse(
                                                              state
                                                                  .classLinksModel
                                                                  .todayClass[
                                                                      index]
                                                                  .zoomlink
                                                                  .toString()));
                                                          context
                                                              .read<
                                                                  AttendenceCreateBloc>()
                                                              .add(Fetchattendence(
                                                                  attendtype:
                                                                      'live',
                                                                  classId: state
                                                                      .classLinksModel
                                                                      .todayClass[
                                                                          index]
                                                                      .clsSchdlId));
                                                        },
                                                        child: appTextView(
                                                            name: state
                                                                        .classLinksModel
                                                                        .todayClass[
                                                                            index]
                                                                        .clsSchdlStatus
                                                                        .toLowerCase() ==
                                                                    'ongoing'
                                                                ? 'Join'
                                                                : state
                                                                            .classLinksModel
                                                                            .todayClass[
                                                                                index]
                                                                            .clsSchdlStatus
                                                                            .toLowerCase() ==
                                                                        'scheduled'
                                                                    ? 'Waiting'
                                                                    : 'Closed',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .kwhite),
                                                      )
                                                    : state
                                                                .classLinksModel
                                                                .upcommingClass[
                                                                    index]
                                                                .clsSchdlStatus
                                                                .toString()
                                                                .toLowerCase() ==
                                                            "scheduled"
                                                        ? appTextView(
                                                            name:
                                                                'Waiting for host',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .kwhite)
                                                        : Container()
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      setHeight(15),
                                    ],
                                  );
                                },
                                childCount:
                                    state.classLinksModel.todayClass.length,
                              ),
                            ),

                            // upcommimg list design

                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      appTextView(
                                        name: DateFormat('MMMM dd').format(
                                            DateTime.parse(state.classLinksModel
                                                .todayClass[index].clsSchdlDate
                                                .toString())),
                                        color: AppColors.kBlack,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Card(
                                          elevation: 5,
                                          color: AppColors.kwhite,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  icClass,
                                                  fit: BoxFit.contain,
                                                ),
                                                setWidth(10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    appTextView(
                                                        name: state
                                                            .classLinksModel
                                                            .upcommingClass[
                                                                index]
                                                            .clsSchdlMeetingName,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    setHeight(10),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          icClassCalender,
                                                          height: 15,
                                                        ),
                                                        setWidth(5),
                                                        appTextView(
                                                          name: DateFormat(
                                                                  'MMMM dd')
                                                              .format(DateTime.parse(state
                                                                  .classLinksModel
                                                                  .todayClass[
                                                                      index]
                                                                  .clsSchdlDate
                                                                  .toString())),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          icClock,
                                                          height: 15,
                                                        ),
                                                        setWidth(5),
                                                        appTextView(
                                                            name: state
                                                                .classLinksModel
                                                                .upcommingClass[
                                                                    index]
                                                                .clsSchdlTimeFrom),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                state
                                                            .classLinksModel
                                                            .upcommingClass[
                                                                index]
                                                            .clsSchdlStatus
                                                            .toString()
                                                            .toLowerCase() ==
                                                        "ongoing"
                                                    ? ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              AppColors.kYellow,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          launchUrl(Uri.parse(state
                                                              .classLinksModel
                                                              .upcommingClass[
                                                                  index]
                                                              .zoomlink
                                                              .toString()));

                                                          context
                                                              .read<
                                                                  AttendenceCreateBloc>()
                                                              .add(Fetchattendence(
                                                                  attendtype:
                                                                      'live',
                                                                  classId: state
                                                                      .classLinksModel
                                                                      .upcommingClass[
                                                                          index]
                                                                      .clsSchdlId));
                                                        },
                                                        child: appTextView(
                                                            name: 'Join',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .kwhite),
                                                      )
                                                    : state
                                                                .classLinksModel
                                                                .upcommingClass[
                                                                    index]
                                                                .clsSchdlStatus
                                                                .toString()
                                                                .toLowerCase() ==
                                                            "scheduled"
                                                        ? appTextView(
                                                            name:
                                                                'Waiting for host',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .kwhite)
                                                        : Container()
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      setHeight(15),
                                    ],
                                  );
                                },
                                childCount:
                                    state.classLinksModel.upcommingClass.length,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const SliverToBoxAdapter(
                          child: NoDataWidget(),
                        );
                      }
                    }
                    return const SliverToBoxAdapter();
                  },
                ),
              ],
            )),
      ),
    );
  }
}
