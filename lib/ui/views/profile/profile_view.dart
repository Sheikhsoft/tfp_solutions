import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_app/ui/smart_widgets/appbar.dart';
import 'package:my_app/ui/views/profile/profile_viewmodel.dart';
import 'package:country_picker/country_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 90),
          child: AppBarWedget(
            title: "Profile",
          ),
        ),
        body: Container(
            child: model.customer == null
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : _buildBody(model, context)),
      ),
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (model) => SchedulerBinding.instance
          .addPostFrameCallback((_) => model.initDynamicLinks()),
    );
  }

  _buildBody(ProfileViewModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          new Container(
            width: 190.0,
            height: 190.0,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: model.customerPhoto,
          ),
          Text("Name"),
          SizedBox(height: 5.0),
          TextFormField(
            controller: TextEditingController(text: model.name.value),
            autocorrect: false,
            decoration: buildInputDecoration(
              labelText: "name",
              icon: Icons.person,
              errorText: model.name.error,
            ),
            onChanged: (String value) {
              model.setName(value);
            },
          ),
          SizedBox(height: 15.0),
          Text("Moblie NO"),
          SizedBox(height: 5.0),
          TextField(
            autofocus: false,
            keyboardType: TextInputType.number,
            decoration: buildInputDecoration(
              labelText: "Moblie NO",
              errorText: model.mobile.error,
              icon: Icons.phone,
            ),
            onChanged: (String value) {
              model.setMobileNumber(value);
            },
          ),
          SizedBox(height: 15.0),
          Text("Email"),
          SizedBox(height: 5.0),
          TextField(
            controller: TextEditingController(text: model.email.value),
            autofocus: false,
            keyboardType: TextInputType.emailAddress,
            decoration: buildInputDecoration(
              labelText: "abc@",
              errorText: model.email.error,
              icon: Icons.email,
            ),
            onChanged: (String value) {
              model.setEmail(value);
            },
          ),
          SizedBox(height: 15.0),
          Text("Address"),
          SizedBox(height: 5.0),
          TextField(
            controller: TextEditingController(text: model.address.value),
            autofocus: false,
            decoration: buildInputDecoration(
              labelText: "Address",
              errorText: model.address.error,
              icon: Icons.add_location,
            ),
            onChanged: (String value) {
              model.setAddress(value);
            },
          ),
          SizedBox(height: 15.0),
          Text("City"),
          SizedBox(height: 5.0),
          TextField(
            controller: TextEditingController(text: model.city.value),
            decoration: buildInputDecoration(
              labelText: "City",
              icon: Icons.location_city,
              errorText: model.city.error,
            ),
            onChanged: (String value) {
              model.setCity(value);
            },
          ),
          SizedBox(height: 15.0),
          Text("State"),
          SizedBox(height: 5.0),
          TextField(
            controller: TextEditingController(text: model.statevalue.value),
            decoration: buildInputDecoration(
              labelText: "State",
              icon: Icons.location_searching_sharp,
              errorText: model.statevalue.error,
            ),
            onChanged: (String value) {
              model.setStateValue(value);
            },
          ),
          SizedBox(height: 15.0),
          Text("Country"),
          SizedBox(height: 5.0),
          TextField(
            controller: new TextEditingController(text: model.country.value),
            readOnly: true,
            onTap: () => showCountryPicker(
              context: context,
              showPhoneCode: false,
              onSelect: (Country country) {
                print('Select country: ${country.displayName}');
                model.setCountry(country.displayName);
              },
            ),
            decoration: buildInputDecoration(
                labelText: "Country",
                errorText: model.country.error,
                icon: Icons.location_city_sharp),
            onChanged: (String value) {
              model.setCountry(value);
            },
          ),
          SizedBox(height: 15.0),
          Text("Nationality"),
          SizedBox(height: 5.0),
          TextField(
            controller: TextEditingController(text: model.nationality.value),
            decoration: buildInputDecoration(
              labelText: "Nationality",
              icon: Icons.location_city,
              errorText: model.nationality.error,
            ),
            onChanged: (String value) {
              model.setNationality(value);
            },
          ),
          SizedBox(height: 15.0),
          Text("Postal Code"),
          SizedBox(height: 5.0),
          TextField(
            controller: TextEditingController(text: model.postalCode.value),
            decoration: buildInputDecoration(
                labelText: "Postal Code",
                errorText: model.postalCode.error,
                icon: Icons.local_post_office),
            onChanged: (String value) {
              model.setPostalCode(value);
            },
          ),
          SizedBox(height: 15.0),
          Text("Date Of Birth"),
          SizedBox(height: 5.0),
          GestureDetector(
            onTap: () => _selectDate(context, model),
            child: AbsorbPointer(
              child: TextField(
                controller: TextEditingController(text: model.birthDay.value),
                decoration: buildInputDecoration(
                    labelText: 'Date Of Birth',
                    errorText: model.birthDay.error,
                    icon: Icons.calendar_today),
              ),
            ),
          ),
          SizedBox(height: 15.0),
          Text("Gender"),
          SizedBox(height: 5.0),
          DropdownButtonFormField(
            decoration:
                buildInputDecoration(labelText: "Gender", icon: Icons.person),
            value: model.gender.value,
            onChanged: (String value) {
              model.setGender(value);
            },
            items: <String>['Male', 'Female', 'Other'].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 15.0),
          Text("Id Type"),
          SizedBox(height: 5.0),
          DropdownButtonFormField(
            decoration:
                buildInputDecoration(labelText: "Id Type", icon: Icons.person),
            value: model.idType.value,
            onChanged: (String value) {
              model.setIdType(value);
            },
            items: <String>[
              'Passport',
              'Driving licence',
              'National Id',
              'Other'
            ].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 15.0),
          Text("IdNumber"),
          SizedBox(height: 5.0),
          TextField(
            controller: TextEditingController(text: model.idNumber.value),
            decoration: buildInputDecoration(
              labelText: "IdNumber",
              icon: Icons.location_city,
              errorText: model.idNumber.error,
            ),
            onChanged: (String value) {
              model.setIdNumber(value);
            },
          ),
          SizedBox(height: 20.0),
          RaisedButton(
            textColor: Colors.white,
            child: Text(
              'Direction',
            ),
            color: Color(0xFF651FFF),
            onPressed: (!model.isValid) ? null : model.submitData,
            //onPressed: model.submitData,
          )
        ],
      ),
    );
  }

  _selectDate(BuildContext context, ProfileViewModel model) async {
    DateTime _selectedDate;
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (context) {
        DateTime tempPickedDate = _selectedDate ?? DateTime.now();
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Done'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(tempPickedDate);
                      model.setBirthDay(formattedDate.toString());
                      print('Birthday Select: ${formattedDate.toString()}');
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  InputDecoration buildInputDecoration(
      {String labelText, IconData icon, String errorText}) {
    return InputDecoration(
        prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
        // hintText: hintText,
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        errorText: errorText);
  }
}
