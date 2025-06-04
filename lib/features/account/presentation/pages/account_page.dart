import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:untitled3/core/constants/constants.dart';
import 'package:untitled3/features/account/domain/entities/update_account_entity.dart';
import '../blocs/account_cubit.dart';
import '../blocs/account_state.dart';

class AccountPage extends StatefulWidget {
  final String prevPath;

  const AccountPage({super.key, required this.prevPath});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late final AccountCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = GetIt.instance<AccountCubit>();
    _cubit.fetchCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Account'),
          backgroundColor: kPrimarycolor,
        ),
        body: BlocConsumer<AccountCubit, AccountState>(
          listener: (context, state) {
            if (state.status == AccountStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated')),
              );
            } else if (state.status == AccountStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error ?? 'Update failed')),
              );
            }
          },
          builder: (context, state) {
            if (state.status == AccountStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _AvatarSection(imageUrl: state.imageUrl),
                const SizedBox(height: 12),
                _NameEmailSection(state: state),
                const SizedBox(height: 24),
                const Divider(),
                _EditableField(
                  label: "First Name",
                  value: state.firstName ?? '',
                  icon: Icons.person,
                  onSave: (v) => _updateField(context, state, firstName: v),
                ),
                _EditableField(
                  label: "Last Name",
                  value: state.lastName ?? '',
                  icon: Icons.person_outline,
                  onSave: (v) => _updateField(context, state, lastName: v),
                ),
                _EditableField(
                  label: "Email",
                  value: state.email ?? '',
                  icon: Icons.email,
                  onSave: (v) => _updateField(context, state, email: v),
                ),
                _EditableField(
                  label: "Date of Birth",
                  value: state.dob != null ? state.dob!.toIso8601String().split('T').first : '',
                  icon: Icons.calendar_today,
                  onSave: (v) {
                    final d = DateTime.tryParse(v);
                    if (d != null) _updateField(context, state, dob: d);
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  style: ElevatedButton.styleFrom(backgroundColor: kPrimarycolor),
                  label: const Text('Back', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    if (widget.prevPath.isNotEmpty) {
                      GoRouter.of(context).push(widget.prevPath);
                    } else {
                      throw Exception("No prev path provided");
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _updateField(
      BuildContext context,
      AccountState state, {
        String? firstName,
        String? lastName,
        String? email,
        DateTime? dob,
      }) {
    final updated = UpdateAccountEntity(
      username: state.username!,
      firstName: firstName ?? state.firstName!,
      lastName: lastName ?? state.lastName!,
      email: email ?? state.email!,
      dateOfBirth: dob ?? state.dob!,
    );
    context.read<AccountCubit>().updateUserInfo(updated);
  }
}

class _AvatarSection extends StatelessWidget {
  final String? imageUrl;

  const _AvatarSection({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => context.read<AccountCubit>().updateProfileImage(),
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey[200],
          child: ClipOval(
            child: imageUrl == null || imageUrl!.isEmpty
                ? Image.asset('assets/paper.png')
                : CachedNetworkImage(
              imageUrl: imageUrl!,
              placeholder: (_, __) => const CircularProgressIndicator(),
              errorWidget: (_, __, ___) => const Icon(Icons.error),
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}

class _NameEmailSection extends StatelessWidget {
  final AccountState state;

  const _NameEmailSection({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            '${state.firstName ?? ''} ${state.lastName ?? ''}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 4),
        Center(
          child: Text(state.email ?? '', style: const TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}

class _EditableField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final void Function(String) onSave;

  const _EditableField({
    required this.label,
    required this.value,
    required this.icon,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: kPrimarycolor),
          title: Text(label),
          subtitle: Text(value),
          trailing: const Icon(Icons.edit),
          onTap: () => _showEditDialog(context, label, value, onSave),
        ),
        const Divider(),
      ],
    );
  }

  void _showEditDialog(
      BuildContext context,
      String label,
      String current,
      void Function(String) onSave,
      ) {
    final ctl = TextEditingController(text: current);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit $label'),
        content: TextField(
          controller: ctl,
          decoration: InputDecoration(hintText: 'Enter new $label'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              onSave(ctl.text.trim());
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
