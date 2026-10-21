import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_completed_provider.g.dart';


@riverpod
class OnboardingCompletedNotifier extends _$OnboardingCompletedNotifier {
  @override
   bool build() {
   return false ;
  }

  void completeOnboarding(){
    state = true;
  }
}