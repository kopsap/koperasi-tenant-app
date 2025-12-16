import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:koperasitenantapp/bloc/auth/auth_bloc.dart';
import 'package:koperasitenantapp/bloc/auth_payment/auth_payment_bloc.dart';
import 'package:koperasitenantapp/bloc/order/order_bloc.dart';
import 'package:koperasitenantapp/bloc/order_detail/order_detail_bloc.dart';
import 'package:koperasitenantapp/bloc/order_process/order_process_bloc.dart';
import 'package:koperasitenantapp/kopsap_app.dart';
import 'package:koperasitenantapp/init/loader.dart';
import 'package:koperasitenantapp/init/observer.dart';
import 'package:koperasitenantapp/service/storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb
            ? HydratedStorage.webStorageDirectory
            : await getApplicationDocumentsDirectory(),
  );

  initializeDepedencies();

  Bloc.observer = AppBlocObserver();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => getIt<SecureStorage>()),

        BlocProvider(create: (_) => getIt<AuthBloc>()),
        BlocProvider(create: (_) => getIt<AuthPaymentBloc>()),
        
        BlocProvider(create: (_) => getIt<OrderBloc>()),
        BlocProvider(create: (_) => getIt<OrderDetailBloc>()),
        BlocProvider(create: (_) => getIt<OrderProcessBloc>()),
      ],
      child: const KopsapApp(),
    ),
  );
}
