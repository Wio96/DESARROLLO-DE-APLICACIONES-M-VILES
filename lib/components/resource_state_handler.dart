import 'package:flutter/material.dart';
import '../theme/app_tokens.dart';

class ResourceStateHandler extends StatelessWidget {
  final bool isLoading;
  final bool hasError;
  final String errorMessage;
  final bool isEmpty;
  final VoidCallback onRetry;
  final Widget child;

  const ResourceStateHandler({
    Key? key,
    required this.isLoading,
    required this.hasError,
    required this.errorMessage,
    required this.isEmpty,
    required this.onRetry,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppTokens.colorActionPrimary),
      );
    }
    if (hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: AppTokens.colorFeedbackError,
            ),
            const SizedBox(height: AppTokens.spacingSm),
            Text(errorMessage, textAlign: TextAlign.center),
            const SizedBox(height: AppTokens.spacingMd),
            ElevatedButton(onPressed: onRetry, child: const Text('Reintentar')),
          ],
        ),
      );
    }
    if (isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.inbox_outlined,
              size: 48,
              color: AppTokens.colorTextSecondary,
            ),
            SizedBox(height: AppTokens.spacingSm),
            Text(
              'No hay plantas registradas',
              style: TextStyle(color: AppTokens.colorTextSecondary),
            ),
          ],
        ),
      );
    }
    return child;
  }
}
