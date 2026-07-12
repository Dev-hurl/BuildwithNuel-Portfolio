import 'package:buildwithnuel/core/constants/app_colors.dart';
import 'package:buildwithnuel/features/projects/project_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/widgets/nav_bar.dart';
import '../features/home/home_screen.dart';
import '../features/about/about_screen.dart';
import '../features/projects/project_detail_screen.dart';
import '../features/contact/contact_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < NavBar.compactBreakpoint;

              return Stack(
                children: [
                  // content fills the full screen, nav bar floats over it
                  Positioned.fill(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: isCompact ? 0 : 76,
                        bottom: isCompact ? 76 : 0,
                      ), // clears the floating pill at rest
                      child: child,
                    ),
                  ),
                  Positioned(
                    top: isCompact ? null : 0,
                    bottom: isCompact ? 0 : null,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      top: false,
                      child: NavBar(
                        currentPath: state.uri.path,
                        isCompact: isCompact,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Title(
            title: 'Buildwithnuel - Flutter Developer & UX/UI Designer',
            color: AppColors.background,
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => Title(
            title: 'About - Buildwithnuel',
            color: AppColors.background,
            child: AboutScreen(),
          ),
        ),
        GoRoute(
          path: '/projects',
          builder: (context, state) => Title(
            title: 'Projects - Buildwithnuel',
            color: AppColors.background,
            child: ProjectsScreen(),
          ),
          routes: [
            GoRoute(
              path: ':slug',
              builder: (context, state) {
                final slug = state.pathParameters['slug']!;
                return Title(
                  title: '$slug - Buildwithnuel',
                  color: AppColors.background,
                  child: ProjectDetailScreen(slug: slug),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/contact',
          builder: (context, state) => Title(
            title: 'Contact - Buildwithnuel',
            color: AppColors.background,
            child: ContactScreen(),
          ),
        ),
      ],
    ),
  ],
);
