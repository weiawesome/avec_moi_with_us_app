import "package:avec_moi_with_us/models/user/information/preference.dart";
import "package:avec_moi_with_us/services/user/information.dart";
import "package:avec_moi_with_us/utils/exception.dart";
import "package:avec_moi_with_us/widgets/title.dart";
import "package:avec_moi_with_us/widgets/toast_notification.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";


class EditPreferencePage extends StatefulWidget {
  const EditPreferencePage({super.key});
  @override
  State<EditPreferencePage> createState() => _EditPreferencePageState();
}

class _EditPreferencePageState extends State<EditPreferencePage> {
  Set<int> selectedItems = {};
  InformationService i=InformationService();
  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try{
        ResponsePreference r=await i.getPreference();
        r.pairs.forEach((element) {selectedItems.add(element.id);});
        setState(() {
          selectedItems=selectedItems;
        });
      } on AuthException{
        toastError(context, "權限錯誤", "請重新登入");
        Navigator.pop(context);
      } catch (e){
        toastError(context, "未知錯誤", "出現未知錯誤 請稍後再嘗試");
        Navigator.pop(context);
      }

    });
  }

  void edit(){
    try{
      i.editPreference(RequestPreference(genres: selectedItems.toList()));
      toastInfo(context, "成功更新", "成功修改個人資訊");
      Navigator.pop(context);
    } on AuthException{
      toastError(context, "權限錯誤", "請重新登入");
    } catch (e){
      toastError(context, "更新錯誤", "出現未知錯誤 請稍後再嘗試");
    }

  }
  final data = genreIndexPair.keys.toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TitleBarSubPage(title: "Edit Preference"),
                Flexible(
                  flex:13,
                  child: Semantics(
                    label: "列出所有偏好項目",
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        bool isSelected = selectedItems.contains(data[index]);
                        return Semantics(
                          label: "此為偏好選擇按鈕按一下表示選擇再按一下視為取消",
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedItems.remove(data[index]);
                                } else {
                                  selectedItems.add(data[index]);
                                }
                              });
                            },
                            child: Card(
                              color: isSelected ? const Color(0xFFFFE27C) : null,
                              child: Center(
                                child: Text(genreIndexPair[data[index]]!),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Flexible(
                  flex:2,
                  child: Container(
                    alignment: Alignment.center,
                    child: Semantics(
                      label: "送出修改偏好的按鈕",
                      child: ElevatedButton(
                          onPressed: (){edit();},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xA8FF0000)),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                            ),
                          ),
                          child: const Text("EDIT",style: TextStyle(color: Colors.white),)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}