class conventionHall
{
  String Name,Id,City,street,facility,parking,mnprice,mxprice,image,contact_info,dist;
  double Lat, Long;
  String date,month,shift;
  conventionHall(this.City,this.dist,this.street,this.Name,this.Id, this.facility, this.parking, this.mnprice, this.mxprice, this.image, this.Lat, this.Long);

  conventionHall.fromJson(Map<String, dynamic> json)
      : Name = json['Name'],
        Id = json['Id'],
        City= json['City'],
        street= json['Street'],
        facility= json['Facility'],
        parking= json['Parking'],
        mnprice= json['MinPrice'],
        mxprice= json['MaxPrice'],
        image= json['Image'],
        Lat= double.parse(json['Lat']),
        Long= double.parse(json['Long']);
//conventionHall(this.city,this.contact_info,this.Di)


}