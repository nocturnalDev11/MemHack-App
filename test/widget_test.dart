import 'package:flutter_test/flutter_test.dart';
import 'package:memhack_flashcard_app/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const HomeScreen());

    expect(find.text('Create Set'), findsOneWidget);
    expect(find.text('Review'), findsOneWidget);
    expect(find.text('Practice'), findsOneWidget);

    await tester.tap(find.text('Create Set'));
    await tester.pumpAndSettle(); // Wait for navigation animation

    // **Optional:** I can add additional tests here for other buttons
    // and verify if they navigate to the expected screens (ReviewScreen, PracticeScreen)
  });
}
