class OrderStatus{
  static const String WAITING ="waiting";  //Customer making order, waiting for Cashier response.
  static const String NO_RESPONSE = "no_response"; //Customer making order, Cashier not giving any response till time limit.
  static const String ACCEPTED ="accepted"; //Customer making order, Cashier accepted customer order.
  static const String FINISHED ="finished"; //Order were finished by Customer. Payment accepted.
  static const String CANCELED ="canceled"; //Accepted order were Canceled by Customer.
  static const String DENIED ="denied"; // Customer making order, Cashier denied customer order.
}