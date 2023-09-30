import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'machines_state.dart';

class MachinesCubit extends Cubit<MachinesState> {
  MachinesCubit() : super(MachinesInitial());
}
