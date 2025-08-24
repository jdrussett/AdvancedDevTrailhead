public with sharing class AnimalLocator {
    private static final String GET = 'GET';

    // run: AnimalLocator.getAnimalNameById(1);
    public static String getAnimalNameById(Integer animalId) {
        String endpoint = 'callout:AnimalsCallout/' + String.valueOf(animalId);
        HttpRequest request = new HttpRequest();
        request.setMethod(GET);
        request.setEndpoint(endpoint);
        HttpResponse response = new Http().send(request);
        JSONResponse structuredResponse = (JSONResponse) JSON.deserialize(response.getBody(), JSONResponse.class);
        Animal animal = structuredResponse.animal;
        return animal.name;
    }

    private class Animal {
        private Integer id;
        private String name;
        private String eats;
        private String says;
    }

    private class JSONResponse {
        private Animal animal;
    }
}
