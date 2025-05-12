import 'dart:core';

import 'package:Levant_Sale/src/modules/more/repositories/favorite-repo.dart';
import 'package:Levant_Sale/src/modules/more/repositories/tech-support-repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../auth/repos/token-helper.dart';
import '../../../../home/models/favorite-ad.dart';
import '../../../../sections/models/ad.dart';
import '../../../models/faqQuestion.dart';
import '../../../models/tag.dart';
import '../../../models/ticket-msg.dart';
import '../../../models/ticket-msgDTO.dart';
import '../../../models/ticket.dart';

class TechSupportProvider with ChangeNotifier {
  final TechSupportRepository repo = TechSupportRepository();
  List<FAQuestion> _faqs = [];
  List<Ticket> _tickets = [];
  List<TicketMessage> _ticketMsgs = [];
  bool _isTicketCreated = false;

  bool _isLoading = false;
  String? _errorMessage;
  List<FAQuestion> get faqs => _faqs;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  TextEditingController titleController = TextEditingController();
  TextEditingController msgController = TextEditingController();
  List<Ticket> get tickets => _tickets;
  List<TicketMessage> get ticketMsgs => _ticketMsgs;
  bool get isTicketCreated => _isTicketCreated;
  Future<void> getFAQs() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _faqs = await repo.getFAQ();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String>? getAnswerFAQ({required String id}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await repo.getAnswerFAQ(id: id);
      return response ?? '';
    } on Exception catch (e) {
      _errorMessage = e.toString();
      return '';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTicket(
      {required String token, required TicketMessageDTO ticket}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await repo.addTicket(token: token, ticket: ticket);
      if (response.statusCode == 200) {
        _isTicketCreated = true;
        print('ticket created: ${response.data}');
      }
    } on Exception catch (e) {
      _errorMessage = e.toString();
      print(errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getTickets({
    required String token,
    required int userId,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await repo.getTickets(token: token, userId: userId);
      _tickets = response ?? [];
    } on Exception catch (e) {
      _errorMessage = e.toString();
      print(errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getTicketMsgs({
    required String token,
    required String ticketId,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await repo.getTicketMessages(token: token, ticketId: ticketId);
      _ticketMsgs = response ?? [];
    } on Exception catch (e) {
      _errorMessage = e.toString();
      print(errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
