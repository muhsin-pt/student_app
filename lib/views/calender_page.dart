import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nawawin_student/logics/attance_record/attance_record_bloc.dart';
import 'package:nawawin_student/utils/constanst.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/widget.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  DateTime today = DateTime.now();
  void _selecteDate(DateTime day, DateTime focuseDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return BlocProvider.value(
      value: context.read<AttanceRecordBloc>()
        ..add(FetchAttanceRecord(
          studId: '10',
          date: DateFormat('yyyy/MM/dd').format(today),
        )),
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
                    name: 'Attendance Record',
                    size: 16,
                    color: AppColors.kBlack,
                    fontWeight: FontWeight.w500),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.kwhite,
                        borderRadius: BorderRadius.circular(10)),
                    child: TableCalendar(
                      locale: 'en_US',
                      focusedDay: today,
                      headerVisible: true,
                      daysOfWeekVisible: true,
                      calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(
                            color: AppColors.kYellow, shape: BoxShape.circle),
                        selectedTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.kwhite),
                      ),
                      selectedDayPredicate: (day) => isSameDay(day, today),
                      availableCalendarFormats: const {
                        CalendarFormat.week: 'Week',
                      },
                      firstDay: DateTime(DateTime.now().year - 2),
                      lastDay: DateTime(DateTime.now().year + 1),
                      calendarFormat: CalendarFormat.week,
                      availableGestures: AvailableGestures.all,
                      onDaySelected: _selecteDate,
                      pageAnimationEnabled: true,
                      pageJumpingEnabled: true,
                    ),
                  ),
                ),
              ),
              BlocBuilder<AttanceRecordBloc, AttanceRecordState>(
                builder: (context, state) {
                  if (state is AttanceRecordLoading) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state is AttanceRecordTimeout) {
                    return const SliverToBoxAdapter(
                      child: TokenExpierdWidget(),
                    );
                  }
                  if (state is AttanceRecordCompleted) {
                    if (state.attanceRecordModel.todayClass.isNotEmpty) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount:
                              state.attanceRecordModel.todayClass.length,
                          (context, index) => Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                appTextView(
                                    name: state.attanceRecordModel
                                        .todayClass[index].clsSchdlTimeFrom,
                                    size: 12),
                                Row(
                                  children: [
                                    setWidth(65),
                                    Container(
                                      width: w - 105,
                                      decoration: BoxDecoration(
                                        color: state
                                                    .attanceRecordModel
                                                    .todayClass[index]
                                                    .attendStatus
                                                    .toLowerCase() ==
                                                'Present'
                                            ? AppColors.kViolet
                                            : AppColors.kOrange,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                appTextView(
                                                    name:
                                                        '${state.attanceRecordModel.todayClass[index].clsSchdlMeetingName} ',
                                                    color: AppColors.kwhite),
                                                appTextView(
                                                    name:
                                                        '${state.attanceRecordModel.todayClass[index].memTrnLogMname} ',
                                                    size: 12,
                                                    color: AppColors.kwhite),
                                                appTextView(
                                                    name:
                                                        '${state.attanceRecordModel.todayClass[index].clsSchdlTimeFrom} - ${state.attanceRecordModel.todayClass[index].clsSchdlTimeTo}',
                                                    color: AppColors.kwhite,
                                                    size: 12),
                                              ],
                                            ),
                                            setWidth(w * 0.15),
                                            Row(
                                              children: [
                                                state
                                                            .attanceRecordModel
                                                            .todayClass[index]
                                                            .attendStatus
                                                            .toLowerCase() ==
                                                        'present'
                                                    ? const CircleAvatar(
                                                        radius: 4,
                                                        backgroundColor:
                                                            AppColors.kGreen,
                                                      )
                                                    : CircleAvatar(
                                                        radius: 4,
                                                        backgroundColor:
                                                            AppColors.kred,
                                                      ),
                                                setWidth(5),
                                                appTextView(
                                                    name: state
                                                        .attanceRecordModel
                                                        .todayClass[index]
                                                        .clsSchdlStatus,
                                                    size: 12,
                                                    color: AppColors.kwhite)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
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
          ),
        ),
      ),
    );
  }
}
