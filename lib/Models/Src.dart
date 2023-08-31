/// original : "https://images.pexels.com/photos/18112362/pexels-photo-18112362.jpeg"
/// large2x : "https://images.pexels.com/photos/18112362/pexels-photo-18112362.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"
/// large : "https://images.pexels.com/photos/18112362/pexels-photo-18112362.jpeg?auto=compress&cs=tinysrgb&h=650&w=940"
/// medium : "https://images.pexels.com/photos/18112362/pexels-photo-18112362.jpeg?auto=compress&cs=tinysrgb&h=350"
/// small : "https://images.pexels.com/photos/18112362/pexels-photo-18112362.jpeg?auto=compress&cs=tinysrgb&h=130"
/// portrait : "https://images.pexels.com/photos/18112362/pexels-photo-18112362.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800"
/// landscape : "https://images.pexels.com/photos/18112362/pexels-photo-18112362.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200"
/// tiny : "https://images.pexels.com/photos/18112362/pexels-photo-18112362.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"

class Src {
  Src({
      String? original, 
      String? large2x, 
      String? large, 
      String? medium, 
      String? small, 
      String? portrait, 
      String? landscape, 
      String? tiny,}){
    _original = original;
    _large2x = large2x;
    _large = large;
    _medium = medium;
    _small = small;
    _portrait = portrait;
    _landscape = landscape;
    _tiny = tiny;
}

  Src.fromJson(dynamic json) {
    _original = json['original'];
    _large2x = json['large2x'];
    _large = json['large'];
    _medium = json['medium'];
    _small = json['small'];
    _portrait = json['portrait'];
    _landscape = json['landscape'];
    _tiny = json['tiny'];
  }
  String? _original;
  String? _large2x;
  String? _large;
  String? _medium;
  String? _small;
  String? _portrait;
  String? _landscape;
  String? _tiny;

  String? get original => _original;
  String? get large2x => _large2x;
  String? get large => _large;
  String? get medium => _medium;
  String? get small => _small;
  String? get portrait => _portrait;
  String? get landscape => _landscape;
  String? get tiny => _tiny;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['original'] = _original;
    map['large2x'] = _large2x;
    map['large'] = _large;
    map['medium'] = _medium;
    map['small'] = _small;
    map['portrait'] = _portrait;
    map['landscape'] = _landscape;
    map['tiny'] = _tiny;
    return map;
  }

}