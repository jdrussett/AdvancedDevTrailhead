public with sharing class ParkLocator {
    public static List<String> country(String countryName) {
        ParkService.ParksImplPort service = new ParkService.ParksImplPort();
        return service.byCountry(countryName);
    }
}