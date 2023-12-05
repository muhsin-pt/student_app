import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nawawin_student/logics/schedule_class/schedule_class_bloc.dart';
import 'package:nawawin_student/utils/constanst.dart';
import 'package:nawawin_student/utils/widget.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    var w = MediaQuery.of(context).size.width;
    return BlocProvider.value(
      value: context.read<ScheduleClassBloc>()
        ..add(FetchScheduled(filterDate: formattedDate, studentId: "42")),
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<ScheduleClassBloc>().add(
                FetchScheduled(filterDate: formattedDate, studentId: "42"));
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
                  centerTitle: false,
                  leadingWidth: 40,
                  iconTheme:
                      const IconThemeData(color: AppColors.kBlack, size: 25),
                  title: appTextView(
                      name: 'Dashboard',
                      size: 16,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500),
                  bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(50),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 25),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: appTextView(
                                name: "Scheduled Class",
                                size: 16,
                                fontWeight: FontWeight.bold,
                                align: TextAlign.left)),
                      )),
                ),
                BlocBuilder<ScheduleClassBloc, ScheduleClassState>(
                  builder: (context, state) {
                    if (state is ScheduleClassLoading) {
                      return const SliverToBoxAdapter(
                          child: Center(
                        child: CircularProgressIndicator(),
                      ));
                    }
                    if (state is Nointernet) {
                      return const SliverFillRemaining(
                          child: NoInternetWidget(routeName: '/classSchedule'));
                    }

                    if (state is ScheduleClassTimeout) {
                      return const SliverToBoxAdapter(
                        child: TokenExpierdWidget(),
                      );
                    }
                    if (state is ScheduleClassSuccess) {
                      if (state.scheduledClassModel.scheduledClass.isNotEmpty) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            if (index == 0) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: w - 40,
                                    decoration: BoxDecoration(
                                      color: AppColors.kwhite,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(23),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: SvgPicture.asset(
                                                        icTimetable),
                                                  ),
                                                  appTextView(
                                                      name: "Timetable",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      size: 14,
                                                      color:
                                                          AppColors.textColor),
                                                ],
                                              ),
                                              appTextView(
                                                  name: "Wednesday",
                                                  fontWeight: FontWeight.w500,
                                                  size: 14,
                                                  color: AppColors.kash),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.kBlack
                                                      .withOpacity(0.2),
                                                  blurRadius: 6,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                              border: Border.all(
                                                  color: Colors.grey[200]!)),
                                        ),
                                        setHeight(15)
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Container(
                                    width: w - 40,
                                    decoration: BoxDecoration(
                                        color: AppColors.kwhite,
                                        borderRadius: 4 == index
                                            ? const BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              )
                                            : BorderRadius.circular(0)),
                                    height: 45,
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 11, right: 11, bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              appTextView(
                                                  name: state
                                                      .scheduledClassModel
                                                      .scheduledClass[index - 1]
                                                      .time,
                                                  size: 13,
                                                  color: AppColors.textColor),
                                              appTextView(
                                                  name: state
                                                      .scheduledClassModel
                                                      .scheduledClass[index - 1]
                                                      .couBtClassName,
                                                  size: 13,
                                                  color: AppColors.kGrey),
                                            ],
                                          ),
                                        ),
                                        4 == index
                                            ? Container()
                                            : const Divider(
                                                color: AppColors.kGrey,
                                                thickness: 0.5,
                                              ),
                                      ],
                                    )),
                              );
                            }
                          },
                              // childCount: 4 + 1,
                              childCount: state.scheduledClassModel
                                      .scheduledClass.length +
                                  1),
                        );
                      } else {
                        return const SliverToBoxAdapter(
                          child: NoDataWidget(),
                        );
                      }
                    }
                    return SliverFillRemaining(
                      child: Center(
                        child: appTextView(name: "Error"),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
