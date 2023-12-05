// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawawin_student/logics/notes/notes_bloc.dart';
import 'package:nawawin_student/utils/constanst.dart';
import 'package:nawawin_student/utils/widget.dart';

class GetClassArguments {
  final String clasRecId;

  GetClassArguments({
    required this.clasRecId,
  });
}

class CourseNotes extends StatelessWidget {
  const CourseNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as GetClassArguments;
    return BlocProvider.value(
      value: context.read<NotesBloc>()
        ..add(FetchNotes(recordId: '${arguments.clasRecId}')),
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverAppBar(
              backgroundColor: AppColors.kwhite,
              leading: IconButton(
                  onPressed: () {
                    ntrkey.currentState?.pop();
                  },
                  icon:
                      const Icon(Icons.arrow_back, color: AppColors.textColor)),
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(8),
                child: Divider(),
              ),
              leadingWidth: 30,
              elevation: 0,
              pinned: true,
              title: appTextView(
                  name: "Notes",
                  color: AppColors.textColor,
                  size: 17,
                  fontWeight: FontWeight.bold)),
          BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              if (state is NotesLoading) {
                return const SliverToBoxAdapter(
                    child: Center(
                  child: CircularProgressIndicator(),
                ));
              }
              if (state is NotesTimeout) {
                return const SliverToBoxAdapter(
                  child: TokenExpierdWidget(),
                );
              }
              if (state is NotesSuccess) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      appTextView(
                          name: state.title,
                          fontWeight: FontWeight.bold,
                          size: 15),
                      setHeight(20),
                      appTextView(
                          name: "                     ${state.Content}",
                          maxLines: 100,
                          align: TextAlign.left),
                    ]),
                  ),
                );
              }

              return const SliverToBoxAdapter();
            },
          )
        ],
      )),
    );
  }
}
