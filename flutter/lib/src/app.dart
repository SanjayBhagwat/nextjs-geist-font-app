import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myclassmates/src/core/services/auth_service.dart';
import 'package:myclassmates/src/features/auth/presentation/pages/login_page.dart';
import 'package:myclassmates/src/features/auth/presentation/pages/register_page.dart';
import 'package:myclassmates/src/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:myclassmates/src/features/classmates/presentation/pages/classmates_page.dart';
import 'package:myclassmates/src/features/chat/presentation/pages/chat_list_page.dart';
import 'package:myclassmates/src/features/chat/presentation/pages/chat_detail_page.dart';
import 'package:myclassmates/src/features/calls/presentation/pages/voice_call_page.dart';
import 'package:myclassmates/src/features/calls/presentation/pages/video_call_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
      ],
      child: MaterialApp.router(
        title: 'MyClassmates',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: Colors.blue,
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}

final _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: '/classmates',
      builder: (context, state) => const ClassmatesPage(),
    ),
    GoRoute(
      path: '/chat',
      builder: (context, state) => const ChatListPage(),
    ),
    GoRoute(
      path: '/chat/:id',
      builder: (context, state) => ChatDetailPage(
        chatId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/call/voice/:chatId',
      builder: (context, state) => VoiceCallPage(
        chatId: state.pathParameters['chatId']!,
      ),
    ),
    GoRoute(
      path: '/call/video/:chatId',
      builder: (context, state) => VideoCallPage(
        chatId: state.pathParameters['chatId']!,
      ),
    ),
  ],
);
