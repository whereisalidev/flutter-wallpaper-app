import 'Src.dart';

/// id : 18112362
/// width : 4000
/// height : 6000
/// url : "https://www.pexels.com/photo/city-france-street-rooftop-18112362/"
/// photographer : "Niklas Jeromin"
/// photographer_url : "https://www.pexels.com/@njeromin"
/// photographer_id : 1766970
/// avg_color : "#7E7E80"
/// src : {"original":"https://images.pexels.com/photos/18112362/pexels-photo-18112362.jpeg","large2x":"https://images.pexels.com/photos/18112362/pexels-photo-18112362.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940","large":"https://images.pexels.com/photos/18112362/pexels-photo-18112362.jpeg?auto=compress&cs=tinysrgb&h=650&w=940","medium":"https://images.pexels.com/photos/18112362/pexels-photo-18112362.jpeg?auto=compress&cs=tinysrgb&h=350","small":"https://images.pexels.com/photos/18112362/pexels-photo-18112362.jpeg?auto=compress&cs=tinysrgb&h=130","portrait":"https://images.pexels.com/photos/18112362/pexels-photo-18112362.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800","landscape":"https://images.pexels.com/photos/18112362/pexels-photo-18112362.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200","tiny":"https://images.pexels.com/photos/18112362/pexels-photo-18112362.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"}
/// liked : false
/// alt : "Free stock photo of 2k, 4k, 4k background"

class Photos {
  Photos({
      num? id, 
      num? width, 
      num? height, 
      String? url, 
      String? photographer, 
      String? photographerUrl, 
      num? photographerId, 
      String? avgColor, 
      Src? src, 
      bool? liked, 
      String? alt,}){
    _id = id;
    _width = width;
    _height = height;
    _url = url;
    _photographer = photographer;
    _photographerUrl = photographerUrl;
    _photographerId = photographerId;
    _avgColor = avgColor;
    _src = src;
    _liked = liked;
    _alt = alt;
}

  Photos.fromJson(dynamic json) {
    _id = json['id'];
    _width = json['width'];
    _height = json['height'];
    _url = json['url'];
    _photographer = json['photographer'];
    _photographerUrl = json['photographer_url'];
    _photographerId = json['photographer_id'];
    _avgColor = json['avg_color'];
    _src = json['src'] != null ? Src.fromJson(json['src']) : null;
    _liked = json['liked'];
    _alt = json['alt'];
  }
  num? _id;
  num? _width;
  num? _height;
  String? _url;
  String? _photographer;
  String? _photographerUrl;
  num? _photographerId;
  String? _avgColor;
  Src? _src;
  bool? _liked;
  String? _alt;

  num? get id => _id;
  num? get width => _width;
  num? get height => _height;
  String? get url => _url;
  String? get photographer => _photographer;
  String? get photographerUrl => _photographerUrl;
  num? get photographerId => _photographerId;
  String? get avgColor => _avgColor;
  Src? get src => _src;
  bool? get liked => _liked;
  String? get alt => _alt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['width'] = _width;
    map['height'] = _height;
    map['url'] = _url;
    map['photographer'] = _photographer;
    map['photographer_url'] = _photographerUrl;
    map['photographer_id'] = _photographerId;
    map['avg_color'] = _avgColor;
    if (_src != null) {
      map['src'] = _src?.toJson();
    }
    map['liked'] = _liked;
    map['alt'] = _alt;
    return map;
  }

}