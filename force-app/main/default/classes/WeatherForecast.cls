public class WeatherForecast {
    
    public static Decimal City(String cityName) {
        
        Decimal Temperature = 0.0;
        HTTP h = new HTTP();
        HTTPRequest req = new HTTPRequest();
        
        req.setEndpoint('http://api.openweathermap.org/data/2.5/weather?q='+'cityName'+'&appid=1b48a9c380525f5aa82a0467a3df1121');
        req.setMethod('GET');
        
        HTTPResponse res = h.send(req);
        
        Map<String,Object> JSONBody = (Map<String,Object>) json.deserializeUntyped(res.getBody());
        
        system.debug('JSONBody'+JSONBody);
        
        Map<String,Object> tempMap =(Map<String,Object>)JSONBody.get('temp');
        
        return Temperature;
        
    }

}