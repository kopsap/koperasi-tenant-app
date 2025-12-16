import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:koperasitenantapp/bloc/auth/auth_bloc.dart';
import 'package:koperasitenantapp/models/auth/auth.dart';
import 'package:koperasitenantapp/service/storage.dart';
import 'package:koperasitenantapp/themes/colors.dart';
import 'package:koperasitenantapp/themes/widgets/buttons.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  Auth _creds = Auth();

  @override
  void initState() {
    super.initState();
    // _loadToken(); // Testing Purpose
    _loadCredentials();
  }

  void _loadCredentials() async {
    final data = await context.read<SecureStorage>().getCredentials();
    setState(() {
      _creds = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (_, state) {
        if (state is AuthInitial) {
          context.read<SecureStorage>().deleteToken();
          context.read<SecureStorage>().deleteCredentials();
          context.goNamed("authLogin");
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Card(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 15.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selamat datang!",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        "Kode Tenant: ${_creds.workerId}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Nama: ${_creds.workerName}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: PrimaryButton(
                onPress: () => context.goNamed('order'),
                label: "Buat Pesanan",
                icon: Icon(Icons.nfc),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: PrimaryButton(
                onPress: () => context.goNamed('orderList'),
                label: "Riwayat Pesanan Masuk",
                icon: Icon(Icons.list),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: PrimaryButton(
                onPress: () => {context.read<AuthBloc>().add(AuthLogout())},
                label: "Logout",
                icon: Icon(Icons.logout),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
