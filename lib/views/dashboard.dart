import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nawawin_student/logics/dashboard/dashboard_bloc.dart';
import 'package:nawawin_student/utils/constanst.dart';
import 'package:nawawin_student/utils/widget.dart';
import 'package:sliver_tools/sliver_tools.dart';

class Dashbaord extends StatelessWidget {
  const Dashbaord({super.key});

  Future<String?> _getStudId() async {
    return await storage.read(key: 'stuId');
  }

  Future<String?> _getName() async {
    return await storage.read(key: 'name');
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: _getStudId(),
      builder: (context, studentId) {
        return BlocProvider.value(
          value: context.read<DashboardBloc>()
            ..add(FetchDashboard(studentId: '${studentId.data}')),
          child: Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                context
                    .read<DashboardBloc>()
                    .add(FetchDashboard(studentId: '${studentId.data}'));
              },
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(icBg), fit: BoxFit.cover)),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: Container(),
                      title: Image.asset(
                        iclogo,
                        width: 122,
                      ),
                      leadingWidth: 20,
                      centerTitle: false,
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
                    BlocBuilder<DashboardBloc, DashboardState>(
                      builder: (context, state) {
                        if (state is DashboardLoading) {
                          return const SliverToBoxAdapter(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (state is DashboardTimeout) {
                          return const SliverToBoxAdapter(
                            child: TokenExpierdWidget(),
                          );
                        }
                        if (state is NoAvailableInternet) {
                          return const SliverFillRemaining(
                              child: NoInternetWidget(routeName: '/home'));
                        }
                        if (state is DashboardSuccess) {
                          double attance = double.parse(state
                                  .dashboardModel.presentPercentage
                                  .toString()) *
                              100;
                          return MultiSliver(
                            pushPinnedChildren: false,
                            children: [
                              SliverToBoxAdapter(
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, top: 30),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FutureBuilder(
                                                future: _getName(),
                                                builder: (context, snapshot) {
                                                  return appTextView(
                                                      name:
                                                          "Good Morning ${snapshot.data}",
                                                      size: 16,
                                                      fontWeight:
                                                          FontWeight.w500);
                                                }),
                                            setHeight(21),
                                            Center(
                                              child: CustomPaint(
                                                painter: MultiColorCirclePainter(
                                                    attance: double.parse(state
                                                        .dashboardModel
                                                        .presentPercentage
                                                        .toString()),
                                                    absents: double.parse(state
                                                        .dashboardModel
                                                        .absentPercentage
                                                        .toString()),
                                                    leave: double.parse(state
                                                        .dashboardModel
                                                        .leavePercentage
                                                        .toString())),
                                                size: const Size(60, 60),
                                              ),
                                            ),
                                            setHeight(18),
                                            Center(
                                                child: appTextView(
                                                    name:
                                                        "Overall Attendance $attance %",
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.kViolet,
                                                    size: 12)),
                                            setHeight(15),
                                            setWidth(41),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const CircleAvatar(
                                                    backgroundColor:
                                                        AppColors.kViolet,
                                                    radius: 5),
                                                setWidth(15),
                                                appTextView(
                                                    name: "Attended",
                                                    fontWeight: FontWeight.w500,
                                                    size: 10,
                                                    color: AppColors.kViolet),
                                                setWidth(15),
                                                const CircleAvatar(
                                                    backgroundColor:
                                                        AppColors.kOrange,
                                                    radius: 5),
                                                setWidth(15),
                                                appTextView(
                                                    name: "Absents",
                                                    fontWeight: FontWeight.w500,
                                                    size: 10,
                                                    color: AppColors.kOrange),
                                                setWidth(15),
                                                const CircleAvatar(
                                                    backgroundColor:
                                                        AppColors.kgrey,
                                                    radius: 5),
                                                setWidth(15),
                                                appTextView(
                                                    name: "Leaves",
                                                    fontWeight: FontWeight.w500,
                                                    size: 10,
                                                    color: AppColors.kgrey)
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),

                              /// fist row ----------<
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 30, bottom: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      state.dashboardModel.upcommingClass
                                              .isNotEmpty
                                          ? Expanded(
                                              child: Container(
                                                height: h * 0.31,
                                                decoration: BoxDecoration(
                                                    color: AppColors.kwhite,
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade100),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8,
                                                              right: 8,
                                                              top: 8),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Center(
                                                            child: appTextView(
                                                                name:
                                                                    "Timetable",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                size: 14,
                                                                color: AppColors
                                                                    .textColor),
                                                          ),
                                                          SvgPicture.asset(
                                                              icTimetable)
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8,
                                                              right: 5,
                                                              left: 8),
                                                      child: appTextView(
                                                          name:
                                                              "Upcoming Classes",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors.kash,
                                                          size: 10),
                                                    ),
                                                    const Divider(
                                                        color:
                                                            AppColors.kDivider),
                                                    setHeight(5),
                                                    Center(
                                                      child: Column(
                                                        children: [
                                                          appTextView(
                                                              name:
                                                                  '${DateFormat.yMMMMd().format(DateTime.parse(state.dashboardModel.upcommingClass[0].clsSchdlDate.toString()))},',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          setHeight(5),
                                                          appTextView(
                                                              name:
                                                                  ' ${state.dashboardModel.upcommingClass[0].time}',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              size: 12),
                                                          setHeight(10),
                                                          appTextView(
                                                              name: state
                                                                  .dashboardModel
                                                                  .upcommingClass[
                                                                      0]
                                                                  .clsSchdlMeetingName,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              size: 12,
                                                              color: AppColors
                                                                  .kGrey)
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 8,
                                                            height: 72,
                                                            color: AppColors
                                                                .kYellow,
                                                          ),
                                                          state
                                                                      .dashboardModel
                                                                      .upcommingClass
                                                                      .length >
                                                                  1
                                                              ? Expanded(
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        color: AppColors
                                                                            .kYellow
                                                                            .withOpacity(0.5)
                                                                        // state.dashboardModel.upcommingClass[1].clsSchdlStatus.toString().toLowerCase() == 'ongoing'

                                                                        ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            appTextView(
                                                                                name: '${DateFormat.yMMMMd().format(DateTime.parse(state.dashboardModel.upcommingClass[1].clsSchdlDate.toString()))},',
                                                                                fontWeight: FontWeight.bold),
                                                                            setHeight(5),
                                                                            appTextView(
                                                                                name: ' ${state.dashboardModel.upcommingClass[1].time}',
                                                                                fontWeight: FontWeight.w500,
                                                                                size: 12),
                                                                            setHeight(10),
                                                                            appTextView(
                                                                                name: state.dashboardModel.upcommingClass[1].clsSchdlMeetingName,
                                                                                fontWeight: FontWeight.w500,
                                                                                size: 12),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : Container()
                                                        ],
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        ntrkey.currentState
                                                            ?.pushNamed(
                                                                '/classSchedule');
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          appTextView(
                                                              name: "Expand",
                                                              color: AppColors
                                                                  .kGrey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              size: 12),
                                                          setHeight(5),
                                                          const Icon(
                                                            Icons.chevron_right,
                                                            color:
                                                                AppColors.kGrey,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Expanded(
                                              child: Container(
                                                  color: AppColors.kwhite,
                                                  height: h * 0.31,
                                                  child: appTextView(
                                                      name:
                                                          "No Meeting are scheduled",
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                      setWidth(10),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              height: h * 0.149,
                                              decoration: BoxDecoration(
                                                color: AppColors.kwhite,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    appTextView(
                                                        name: "Enrolled Course",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        size: 14,
                                                        color: AppColors
                                                            .textColor),
                                                    setHeight(9),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 23),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                AppColors
                                                                    .kBlack,
                                                            radius: 15,
                                                            child: Icon(
                                                                Icons
                                                                    .chevron_right,
                                                                color: AppColors
                                                                    .kwhite),
                                                          ),
                                                        ),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 28),
                                                          child: Image(
                                                              image: AssetImage(
                                                                  'assets/images/ic_course.png'),
                                                              height: 50),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            setHeight(10),
                                            InkWell(
                                              onTap: () {
                                                ntrkey.currentState?.pushNamed(
                                                    '/bottomNavigation');
                                              },
                                              child: Container(
                                                height: h * 0.149,
                                                decoration: BoxDecoration(
                                                  color: AppColors.kwhite,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        appTextView(
                                                            name: "Classes",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            size: 14,
                                                            color: AppColors
                                                                .textColor),
                                                        setHeight(9),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 30),
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .kBlack,
                                                                radius: 15,
                                                                child: Icon(
                                                                  Icons
                                                                      .chevron_right,
                                                                  color: AppColors
                                                                      .kwhite,
                                                                ),
                                                              ),
                                                            ),
                                                            const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 28),
                                                              child: Image(
                                                                  image: AssetImage(
                                                                      'assets/images/ic_classes.png'),
                                                                  height: 50),
                                                            )
                                                          ],
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              ///second row----------<
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            ntrkey.currentState
                                                ?.pushNamed('/profile');
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.kwhite,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    appTextView(
                                                        name: "Profile",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        size: 14,
                                                        color: AppColors
                                                            .textColor),
                                                    setHeight(10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 30),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                AppColors
                                                                    .kBlack,
                                                            radius: 15,
                                                            child: Icon(
                                                              Icons
                                                                  .chevron_right,
                                                              color: AppColors
                                                                  .kwhite,
                                                            ),
                                                          ),
                                                        ),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 28),
                                                          child: Image(
                                                              image: AssetImage(
                                                                  'assets/images/ic_profile.png'),
                                                              height: 50),
                                                        )
                                                      ],
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                      setWidth(10),
                                      Expanded(
                                        child: InkWell(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.kwhite,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    appTextView(
                                                        name: "Settings",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        size: 14,
                                                        color: AppColors
                                                            .textColor),
                                                    setHeight(10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 30),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                AppColors
                                                                    .kBlack,
                                                            radius: 15,
                                                            child: Icon(
                                                              Icons
                                                                  .chevron_right,
                                                              color: AppColors
                                                                  .kwhite,
                                                            ),
                                                          ),
                                                        ),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 28),
                                                          child: Image(
                                                              image: AssetImage(
                                                                  'assets/images/ic_settings.png'),
                                                              height: 50),
                                                        )
                                                      ],
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
          ),
        );
      },
    );
  }
}

class MultiColorCirclePainter extends CustomPainter {
  final double attance;
  final double leave;
  final double absents;

  MultiColorCirclePainter(
      {required this.attance, required this.leave, required this.absents});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint redPaint = Paint()
      ..color = AppColors.kViolet
      ..strokeWidth = 9
      ..style = PaintingStyle.stroke;
    final Paint bluePaint = Paint()
      ..color = AppColors.kDashboardCircle
      ..strokeWidth = 9
      ..style = PaintingStyle.stroke;

    final Paint whitePaint = Paint()
      ..color = AppColors.kGrey
      ..strokeWidth = 9
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Draw the red segment
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * absents,
      false,
      redPaint,
    );

    // Draw the blue segment
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      2 * pi * absents - pi / 2,
      2 * pi * attance,
      false,
      bluePaint,
    );

    // Draw the white segment
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      2 * (2 * pi * attance) - pi / 2,
      2 * pi * leave,
      false,
      whitePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
