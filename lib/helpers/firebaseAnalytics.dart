// https://zenn.dev/flutteruniv_dev/articles/a46cf2b3c058c6

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final analyticsRepository = Provider((ref) => FirebaseAnalytics.instance);

final analyticsObserverRepository = Provider((ref) =>
    FirebaseAnalyticsObserver(analytics: ref.watch(analyticsRepository)));
