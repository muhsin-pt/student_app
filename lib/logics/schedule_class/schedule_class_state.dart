part of 'schedule_class_bloc.dart';

abstract class ScheduleClassState extends Equatable {
  const ScheduleClassState();
  
 
}

 class ScheduleClassInitial extends ScheduleClassState {
   @override
  List<Object> get props => [];
 }
 class ScheduleClassLoading extends ScheduleClassState {
   @override
  List<Object> get props => [];
 }
 class ScheduleClassSuccess extends ScheduleClassState {
  final ScheduledClassModel scheduledClassModel;
  const ScheduleClassSuccess({required this.scheduledClassModel});
   @override
  List<Object> get props => [];
 }
 class ScheduleClassTimeout extends ScheduleClassState {
   @override
  List<Object> get props => [];
 }
 class ScheduleClassError extends ScheduleClassState {
   @override
  List<Object> get props => [];
 }
 class Nointernet extends ScheduleClassState {
   @override
  List<Object> get props => [];
 }
 