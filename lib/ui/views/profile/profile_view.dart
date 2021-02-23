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
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 90,
            child: CustomPaint(
              painter: RPSCustomPainter(),
              child: Container(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.navigate_before,
                        size: 40,
                        color: Colors.transparent,
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      Icon(
                        Icons.navigate_before,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Container(
          child: _buildBody(model, context),
        ),
      ),
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (model) => SchedulerBinding.instance
          .addPostFrameCallback((_) => model.initDynamicLinks()),
    );
  }

  _buildBody(ProfileViewModel model, BuildContext context) {
    DateTime _selectedDate;

    String dropDownValue;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          Text("Name"),
          SizedBox(height: 5.0),
          TextFormField(
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
          Text("Country"),
          SizedBox(height: 5.0),
          TextField(
            controller: TextEditingController(text: model.country.value),
            readOnly: true,
            onTap: () => showCountryPicker(
              context: context,
              //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
              //exclude: <String>['KN', 'MF'],
              //Optional. Shows phone code before the country name.
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
          Text("Postal Code"),
          SizedBox(height: 5.0),
          TextField(
            keyboardType: TextInputType.number,
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
            decoration: buildInputDecoration(
                labelText: "Gender",
                errorText: model.postalCode.error,
                icon: Icons.person),
            value: dropDownValue,
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
