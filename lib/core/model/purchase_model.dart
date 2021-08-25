class ListViewScreenModel {
  String image;
  String title;
  int year;
  int price;
  int quantity;
  int avQt;
  DateTime purchaseDate;
  List genre;

  ListViewScreenModel({this.image, this.title, this.price,
                       this.genre, this.avQt, this.year, 
                       this.purchaseDate, this.quantity});
  void setImage(String getImage) {
    image = getImage;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setPrice(int getPrice) {
    price = getPrice;
  }

  void setQuantity(int getQuantity) {
    quantity = getQuantity;
  }

  void setAvQt(int getAvQt) {
    avQt = getAvQt;
  }

  void setYear(int getYear) {
    year = getYear;
  }

  void setGenre(List getGenre) {
    genre = getGenre;
  }

   void setPurchaseDate(DateTime getPurchaseDate) {
    purchaseDate = getPurchaseDate;
  }

  //  void setDateTime(DateTime getDateTime) {
  //   dateTime = getDateTime;
  // }



  String getImage() {
    return image;
  }

  String getTitle() {
    return title;
  }

  int getPrice() {
    return price;
  }

  int getQuantity() {
    return quantity;
  }

  int getAvQt() {
    return avQt;
  }

  int getYear() {
    return year;
  }

  List getGenre(){
    return genre;
  }

  DateTime getPurchaseDate(){
    return purchaseDate;
  }

  // DateTime getDateTime(){
  //   return dateTime;
  // }
}