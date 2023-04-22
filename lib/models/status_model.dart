import 'state_model.dart';

class StatusModel {
  int? id;
  String? name;
  String? emoji;
  String? emojiU;
  List<States>? state;

  StatusModel({this.id, this.name, this.emoji, this.emojiU, this.state});

  StatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emoji = json['emoji'];
    emojiU = json['emojiU'];
    if (json['state'] != null) {
      state = <States>[];
      json['state'].forEach(
        (v) {
          state!.add(States.fromJson(v));
        },
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['emoji'] = emoji;
    data['emojiU'] = emojiU;
    if (state != null) {
      data['state'] = state!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
