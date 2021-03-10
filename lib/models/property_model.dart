

class PropertyModel {
  String caption;
  String canon;
  String picture;

  PropertyModel({ this.caption, this.canon, this.picture });

  factory PropertyModel.fromJson(Map<String, dynamic> json) 
    => PropertyModel(
      canon  : json['canon'],
      caption: json['caption'],
      picture: json['picture'] ,
    );

}