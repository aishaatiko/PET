// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker/providers/expense_provider.dart';
import 'package:personal_expense_tracker/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  // Widget createAddExpenseScreen() {
  //   return MaterialApp(
  //     home: MultiProvider(
  //       providers: [
  //         ChangeNotifierProvider<ExpenseProvider>(
  //           create: (_) => ExpenseProvider(),
  //         ),
  //       ],
  //       child: const AddExpenseScreen(),
  //     ),
  //   );
  // }

  testWidgets('Home Screen View Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<ExpenseProvider>(
              create: (_) => ExpenseProvider(),
            ),
          ],
          child: const HomeScreen(),
        ),
      ),
    );

    // Verify empty state
    expect(find.text('No expenses added yet!'), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify screen add expense
    // expect(find.text('No expenses added yet!'), findsOneWidget);
    // expect(find.text('Add Expense'), findsOneWidget);
  });
}
