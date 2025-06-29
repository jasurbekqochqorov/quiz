import 'package:equatable/equatable.dart';

class PaymentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostPaymentEvent extends PaymentEvent {
  PostPaymentEvent({required this.summa});
  final int summa;

  @override
  List<Object?> get props => [summa];
}

class PayPaymentEvent extends PaymentEvent {
  PayPaymentEvent({required this.id});
  final int id;

  @override
  List<Object?> get props => [id];
}
