// new BusScheduleCache().putSchedule('OmahaCentral', new List<Time>{
//   Time.newInstance(8, 0, 0, 0),
//   Time.newInstance(10, 0, 0, 0),
//   Time.newInstance(12, 0, 0, 0),
//   Time.newInstance(2, 0, 0, 0),
//   Time.newInstance(4, 0, 0, 0)
// });

HttpRequest request = new HttpRequest();
request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
request.setMethod('GET');
HttpResponse response = new Http().send(request);
System.debug('mydebug :: response status code: ' + response.getStatusCode());
System.debug('mydebug :: serialized response: ' + response.getBody());
Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(
  response.getBody()
);
List<Object> animals = (List<Object>) responseBody.get('animals');
for (Object animal : animals) {
  String animalName = (String) animal;
  System.debug('mydebug :: animal name retrieved: ' + animalName);
}

request = new HttpRequest();
request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
request.setMethod('POST');
request.setHeader('Content-Type', 'application/json;charset=UTF-8');
request.setBody('{"name": "mighty moose"}');
response = new Http().send(request);
System.debug('mydebug :: response status code: ' + response.getStatusCode());
System.debug('mydebug :: response: ' + response.getBody());

calculatorServices.CalculatorImplPort calculator = new calculatorServices.CalculatorImplPort();
Double x = 1.0;
Double y = 2.0;
Double result = calculator.doAdd(x, y);
System.debug(result);
