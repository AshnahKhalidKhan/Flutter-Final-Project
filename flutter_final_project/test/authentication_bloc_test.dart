import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_final_project/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_final_project/blocs/authentication/authentication_events.dart';
import 'package:flutter_final_project/blocs/authentication/authentication_states.dart';
import 'package:flutter_final_project/core/repositories/authentication_repository.dart';
import 'package:flutter_final_project/models/user_model.dart';
import 'package:mockito/mockito.dart';

// class MockAuthenticationRepository extends Mock implements AuthenticationRepository {}

// void main() 
// {
//   group('AuthenticationBloc', () 
//   {
//     late AuthenticationBloc authenticationBloc;
//     late MockAuthenticationRepository mockAuthenticationRepository;

//     setUp(() 
//     {
//       mockAuthenticationRepository = MockAuthenticationRepository();
//       authenticationBloc = AuthenticationBloc(authenticationRepository: mockAuthenticationRepository);
//     });

//     tearDown(() 
//     {
//       authenticationBloc.close();
//     });

//     blocTest<AuthenticationBloc, AuthenticationState>
//     (
//       'emits [AuthenticationLoadingState, AuthenticationSuccessState] when AuthenticationSignUpWithEmailEvent is added',
//       build: () => 
//       authenticationBloc,
//       act: (bloc) 
//       {
//         // when(mockAuthenticationRepository.signUpWithEmail(
//         //   name: 'TestMemberForBlocTest',
//         //   email: 'TestMemberEmail@gmail.com',
//         //   password: '123456A!',
//         //   role: 'Member',
//         //   campus: 'TestCampusId',
//         // )).thenAnswer((answer) async =>
//         // AppUser
//         // (
//         //   id: '123',
//         //   name: 'TestMemberForBlocTest',
//         //   email: 'TestMemberEmail@gmail.com',
//         //   role: 'Member',
//         //   campus: 'TestCampusId',
//         //   approved: false
//         // ));

//         bloc.add
//         (
//           AuthenticationSignUpWithEmailEvent
//           (
//             'TestMemberForBlocTest',
//             'TestMemberEmail@gmail.com',
//             '123456A!',
//             'Member',
//             'TestCampusId'
//           )
//         );
//       },
//       expect: () => 
//       [
//         AuthenticationLoadingState(),
//         AuthenticationSuccessState
//         (
//           AppUser
//           (
//             id: '123',
//             name: 'TestMemberForBlocTest',
//             email: 'TestMemberEmail@gmail.com',
//             role: 'Member',
//             campus: 'TestCampusId',
//             approved: false
//           )),
//       ],
//     );
//   });
// }