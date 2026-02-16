import 'package:supabase_flutter/supabase_flutter.dart';
import "../models/model_subscription.dart";

class Database {
  final supabase = Supabase.instance.client;

  Future<void> signUp({required String email, required String password}) async {
    await supabase.auth.signUp(email: email, password: password);
  }

  Future<void> login({required String email, required String password}) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<List<Subscription>> getData() async {
    final data = await supabase.from('course').select();
    List<Subscription> couseLsit = [];

    for (var element in data) {
      Subscription c1 = Subscription.fromJson(element);
      couseLsit.add(c1);
    }
    return couseLsit;
  }

  Future<void> addSubscription({required String company,required String price})async{
    await supabase.from('course').insert({'company': company,'price': price});
  }
}
