import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final name =
        user?.userMetadata?['full_name'] ??
        user?.userMetadata?['name'] ??
        user?.email ??
        'usuário';

    return Scaffold(
      appBar: AppBar(
        title: const Text('OrcaZap'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
            },
          ),
        ],
      ),
      body: Center(child: Text('Bem-vindo, $name!')),
    );
  }
}
