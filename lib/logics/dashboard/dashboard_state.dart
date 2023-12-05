part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

}
 class DashboardInitial extends DashboardState {
    @override
  List<Object> get props => [];
 }
 class DashboardLoading extends DashboardState {
      @override
  List<Object> get props => [];
 }
 
 class DashboardSuccess extends DashboardState {
  
  final DashboardModel dashboardModel;
  const DashboardSuccess({required this.dashboardModel});

      @override
  List<Object> get props => [];
 }
 class DashboardTimeout extends DashboardState {
      @override
  List<Object> get props => [];
 }
 class DashboardError extends DashboardState {
      @override
  List<Object> get props => [];
 }
 class NoAvailableInternet extends DashboardState {
      @override
  List<Object> get props => [];
 }

