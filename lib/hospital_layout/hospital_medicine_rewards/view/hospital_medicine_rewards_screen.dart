import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/widget/global_snackbar.dart';
import 'package:blood_donation/core/widget/globla_textformfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_lacator.dart';
import '../../../core/enum/request_state.dart';
import '../model/hospital_medicine_rewards_model.dart';
import '../view_model/cubit/hospital_medicine_rewards_cubit.dart';

class HospitalMedicineRewardsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Medicine Rewards".tr(context))),
      body: BlocConsumer<HospitalMedicineRewardsCubit,
          HospitalMedicineRewardsState>(
        bloc: getIt<HospitalMedicineRewardsCubit>()..fetchMedicines(),
        listener: (context, state) {
          if (state.addMedicineRewardsState == RequestState.success) {
            globalSnackbar(context, "Medicine Added Successfully".tr(context),
                backgroundColor: Colors.green);
          }
          if (state.addMedicineRewardsState == RequestState.error) {
            globalSnackbar(context, "Medicine Add Failed".tr(context),
                backgroundColor: Colors.red);
          }
          if (state.updateMedicineRewardsState == RequestState.success) {
            globalSnackbar(context, "Medicine Updated Successfully".tr(context),
                backgroundColor: Colors.green);
          }
          if (state.updateMedicineRewardsState == RequestState.error) {
            globalSnackbar(context, "Medicine Update Failed".tr(context),
                backgroundColor: Colors.red);
          }
          if (state.deleteMedicineRewardsState == RequestState.success) {
            globalSnackbar(context, "Medicine Deleted Successfully".tr(context),
                backgroundColor: Colors.green);
          }
          if (state.deleteMedicineRewardsState == RequestState.error) {
            globalSnackbar(context, "Medicine Delete Failed".tr(context),
                backgroundColor: Colors.red);
          }
        },
        builder: (context, state) {
          switch (state.getMedicineRewardsState) {
            case RequestState.init:
            case RequestState.loading:
              return const Center(child: CircularProgressIndicator());
            case RequestState.success:
              final medicines = state.getMedicineRewardsModel;
              if (state.getMedicineRewardsModel!.isEmpty) {
                return Center(child: Text("No Medicines".tr(context)));
              }
              return ListView.builder(
                itemCount: medicines!.length,
                itemBuilder: (context, index) {
                  final medicine = medicines[index];

                  return ListTile(
                    title: Text(medicine.name!),
                    leading:
                        CircleAvatar(child: Icon(Icons.medical_information)),
                    subtitle: Text(
                        "${"quantity".tr(context)}: ${medicine.quantity} - ${"points".tr(context)}: ${medicine.points}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () =>
                              _showMedicineDialog(context, medicine: medicine),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => getIt<HospitalMedicineRewardsCubit>()
                              .deleteMedicine(medicine.id!),
                        ),
                      ],
                    ),
                  );
                },
              );
            case RequestState.error:
              return Center(child: Text("Some thing went wrong"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showMedicineDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showMedicineDialog(BuildContext context,
      {HospitalMedicineRewardsModel? medicine}) {
    final nameController = TextEditingController(text: medicine?.name ?? "");
    final quantityController =
        TextEditingController(text: medicine?.quantity.toString() ?? "");
    final descriptionController =
        TextEditingController(text: medicine?.description ?? "");
    final pointsController =
        TextEditingController(text: medicine?.points.toString() ?? "");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(medicine == null
              ? "add medicine".tr(context)
              : "update medicine".tr(context)),
          content: SingleChildScrollView(
            child: Column(
              spacing: 5,
              mainAxisSize: MainAxisSize.min,
              children: [
                GlobalTextFormFiled(
                    textEditingController: nameController,
                    lableText: "name".tr(context)),
                GlobalTextFormFiled(
                    textEditingController: quantityController,
                    lableText: "quantity".tr(context),
                    keyboardType: TextInputType.number),
                GlobalTextFormFiled(
                    textEditingController: descriptionController,
                    lableText: "description".tr(context)),
                GlobalTextFormFiled(
                    textEditingController: pointsController,
                    lableText: "price".tr(context),
                    keyboardType: TextInputType.number),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("cancel".tr(context)),
            ),
            ElevatedButton(
              onPressed: () {
                final cubit = getIt<HospitalMedicineRewardsCubit>();
                if (medicine == null) {
                  cubit.addMedicine(
                    nameController.text,
                    int.parse(quantityController.text),
                    descriptionController.text,
                    int.parse(pointsController.text),
                  );
                } else {
                  cubit.updateMedicine(
                    medicine.id!,
                    nameController.text,
                    int.parse(quantityController.text),
                    descriptionController.text,
                    int.parse(pointsController.text),
                  );
                }
                Navigator.pop(context);
              },
              child: Text(
                  medicine == null ? "add".tr(context) : "update".tr(context)),
            ),
          ],
        );
      },
    );
  }
}
