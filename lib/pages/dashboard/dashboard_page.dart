import 'package:flutter/material.dart';
import 'package:gpstracking/state/app_session.dart';
import 'package:gpstracking/theme.dart';
import 'package:gpstracking/ui/app_widgets.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final session = context.watch<AppSession>();
    final subjectName = session.subjectName;

    return SafeArea(
      child: ListView(
        padding: AppSpacing.paddingLg,
        children: [
          Text('Dashboard', style: context.textStyles.headlineLarge?.copyWith(color: scheme.onSurface)),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Viewing: $subjectName',
            style: context.textStyles.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.lg),
          GradientCard(
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: scheme.tertiary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Icon(Icons.wifi_tethering_rounded, color: scheme.tertiary),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Live', style: context.textStyles.titleMedium?.copyWith(color: scheme.onSurface)),
                      const SizedBox(height: 2),
                      Text(
                        'Last update: just now • Location stream placeholder',
                        style: context.textStyles.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: scheme.onSurfaceVariant),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (!session.hasLinkedChild)
            GradientCard(
              onTap: () {},
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: scheme.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Icon(Icons.add_box_rounded, color: scheme.primary),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Add device', style: context.textStyles.titleMedium?.copyWith(color: scheme.onSurface)),
                        const SizedBox(height: 2),
                        Text(
                          'Link a tracker to start seeing live data.',
                          style: context.textStyles.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: scheme.onSurfaceVariant),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
