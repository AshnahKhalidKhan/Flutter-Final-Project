import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_final_project/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_final_project/blocs/authentication/authentication_events.dart';
import 'package:flutter_final_project/blocs/authentication/authentication_states.dart';
import 'package:flutter_final_project/core/repositories/authentication_repository.dart';
import 'package:flutter_final_project/models/UserModel.dart';
import 'package:mockito/mockito.dart';

class MockAuthenticationRepository extends Mock implements AuthenticationRepository {}

void main() 
{
  group('AuthenticationBloc', () 
  {
    late AuthenticationBloc authenticationBloc;
    late MockAuthenticationRepository mockAuthenticationRepository;

    setUp(() 
    {
      mockAuthenticationRepository = MockAuthenticationRepository();
      authenticationBloc = AuthenticationBloc(authenticationRepository: mockAuthenticationRepository);
    });

    tearDown(() 
    {
      authenticationBloc.close();
    });

    blocTest<AuthenticationBloc, AuthenticationState>
    (
      'emits [AuthenticationLoadingState, AuthenticationSuccessState] when AuthenticationSignUpWithEmailEvent is added',
      build: () => authenticationBloc,
      act: (bloc) 
      {
        when(mockAuthenticationRepository.signUpWithEmail(
          name: 'TestMember',
          email: 'TestMemberEmail@gmail.com',
          password: '123456A!',
          role: 'Member',
          campus: 'TestCampus',
        )).thenAnswer((_) async
        {
          return AppUser
          (
            id: '123',
            name: 'TestMember',
            email: 'TestMemberEmail@gmail.com',
            role: 'Member',
            campus: 'TestCampus',
            approved: false
          );
        });

        bloc.add
        (
          AuthenticationSignUpWithEmailEvent
          (
            'TestMember',
            'TestMemberEmail@gmail.com',
            '123456A!',
            'Member',
            'TestCampus'
          ));
      },
      expect: () => [
        AuthenticationLoadingState(),
        AuthenticationSuccessState
        (
          AppUser
          (
            id: '123',
            name: 'TestMember',
            email: 'TestMemberEmail@gmail.com',
            role: 'Member',
            campus: 'TestCampus',
            approved: false
          )),
      ],
    );

  //   blocTest<AuthenticationBloc, AuthenticationState>(
  //     'emits [AuthenticationLoadingState, AuthenticationErrorState] when AuthenticationSignUpWithEmailEvent fails',
  //     build: () => authenticationBloc,
  //     act: (bloc) {
  //       when(mockAuthenticationRepository.signUpWithEmail(
  //         name: anyNamed('name'),
  //         email: anyNamed('email'),
  //         password: anyNamed('password'),
  //         role: anyNamed('role'),
  //         campus: anyNamed('campus'),
  //       )).thenThrow(Exception('Error'));

  //       bloc.add(AuthenticationSignUpWithEmailEvent('Test', 'test@test.com', 'password', 'role', 'campus'));
  //     },
  //     expect: () => [
  //       AuthenticationLoadingState(),
  //       AuthenticationErrorState('Error'),
  //     ],
  //   );

  //   blocTest<AuthenticationBloc, AuthenticationState>(
  //     'emits [AuthenticationLoadingState, AuthenticationSuccessState] when AuthenticationSignInWithEmailEvent is added',
  //     build: () => authenticationBloc,
  //     act: (bloc) {
  //       when(mockAuthenticationRepository.signInWithEmail(
  //         email: anyNamed('email'),
  //         password: anyNamed('password'),
  //       )).thenAnswer((_) async => AppUser(id: '123', name: 'Test', email: 'test@test.com'));

  //       bloc.add(AuthenticationSignInWithEmailEvent('test@test.com', 'password'));
  //     },
  //     expect: () => [
  //       AuthenticationLoadingState(),
  //       AuthenticationSuccessState(AppUser(id: '123', name: 'Test', email: 'test@test.com')),
  //     ],
  //   );

  //   blocTest<AuthenticationBloc, AuthenticationState>(
  //     'emits [AuthenticationLoadingState, AuthenticationErrorState] when AuthenticationSignInWithEmailEvent fails',
  //     build: () => authenticationBloc,
  //     act: (bloc) {
  //       when(mockAuthenticationRepository.signInWithEmail(
  //         email: anyNamed('email'),
  //         password: anyNamed('password'),
  //       )).thenThrow(Exception('Error'));

  //       bloc.add(AuthenticationSignInWithEmailEvent('test@test.com', 'password'));
  //     },
  //     expect: () => [
  //       AuthenticationLoadingState(),
  //       AuthenticationErrorState('Error'),
  //     ],
  //   );

  //   // Add tests for other events similarly...

  //   blocTest<AuthenticationBloc, AuthenticationState>(
  //     'emits [AuthenticationLoadingState, AuthenticationSignedOutState] when AuthenticationSignOutEvent is added',
  //     build: () => authenticationBloc,
  //     act: (bloc) {
  //       when(mockAuthenticationRepository.signOut()).thenAnswer((_) async {});

  //       bloc.add(AuthenticationSignOutEvent());
  //     },
  //     expect: () => [
  //       AuthenticationLoadingState(),
  //       AuthenticationSignedOutState(),
  //     ],
  //   );

  //   blocTest<AuthenticationBloc, AuthenticationState>(
  //     'emits [AuthenticationLoadingState, AuthenticationErrorState] when AuthenticationSignOutEvent fails',
  //     build: () => authenticationBloc,
  //     act: (bloc) {
  //       when(mockAuthenticationRepository.signOut()).thenThrow(Exception('Error'));

  //       bloc.add(AuthenticationSignOutEvent());
  //     },
  //     expect: () => [
  //       AuthenticationLoadingState(),
  //       AuthenticationErrorState('Error'),
  //     ],
  //   );

  //   // Add tests for other events similarly...
  });
}
