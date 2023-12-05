part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();
}
class FetchDashboard extends DashboardEvent{
  final String studentId;
  const FetchDashboard({required this.studentId});
  
    @override
  List<Object> get props => [];

}