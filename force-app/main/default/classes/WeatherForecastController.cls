public with sharing class WeatherForecastController {
    
    @AuraEnabled(cacheable = true)
    public static WrapperClass getWeather(string recId){
        WrapperClass wc = new WrapperClass();
        try {
            if(recId != ''){
                system.debug('contact Id '+recId);
                Contact con = [SELECT Id, MailingLatitude, MailingLongitude FROM Contact WHERE id =: recId];
                system.debug(con);
                decimal latt = con.MailingLatitude.setScale(2, RoundingMode.HALF_UP);
                decimal longit = con.MailingLongitude.setScale(2, RoundingMode.HALF_UP);
                system.debug('lattitutde **'+latt+' ** longitude :'+longit);
                Http http = new Http();
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://weatherbit-v1-mashape.p.rapidapi.com/current?lat='+latt+'&lon='+longit);
                req.setMethod('GET');
                req.setHeader('X-RapidAPI-Key', '7727c09c17msh4f2b5f4e3ffdfa3p17821djsneace83401fa4');
                req.setHeader('X-RapidAPI-Host','weatherbit-v1-mashape.p.rapidapi.com');
                HttpResponse res = http.send(req);
                
                if(res.getStatusCode() == 200){
                    String resBody = res.getbody();
                    String jsonStr = resBody.replaceAll( '\\s+', ''); 
                    system.debug(jsonStr);
                    wc = (Wrapperclass)json.deserialize(jsonStr,Wrapperclass.class);
                    system.debug('W**C**'+wc);
                    system.debug('W**C**'+wc.data);
                }
                else{
                    system.debug('Failed status code '+res.getStatusCode());
                    system.debug('Failed status ****'+res.getBody());
                }
            }
            else{
                system.debug('No record ID found');
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return wc;
        
    }    
    
    
    
    public class WrapperClass{
        @AuraEnabled public Integer count;	//1
        @AuraEnabled public cls_data[] data;
    }
    public class cls_data {
        @AuraEnabled public Double app_temp;	//27
        @AuraEnabled public Integer aqi;	//14
        @AuraEnabled public String city_name;	//Talegaon Dābhāde
        @AuraEnabled public Integer clouds;	//0
        @AuraEnabled public String country_code;	//IN
        @AuraEnabled public String datetme;	//2022-11-17:07
        @AuraEnabled public Double dewpt;	//5.9
        @AuraEnabled public Double dhi;	//118.04
        @AuraEnabled public Double dni;	//932.41
        @AuraEnabled public Double elev_angle;	//52.08
        @AuraEnabled public Double ghi;	//846.15
        @AuraEnabled public Double gust;	//4.6992188
        @AuraEnabled public Integer h_angle;	//0
        @AuraEnabled public Double lat;	//18.83
        @AuraEnabled public Double lon;	//73.67
        @AuraEnabled public String ob_time;	//2022-11-17 07:39
        @AuraEnabled public String pod;	//d
        @AuraEnabled public Integer  precip;
        @AuraEnabled public Integer pres;	//939
        @AuraEnabled public Integer rh;	//24
        @AuraEnabled public Double slp;	//1011.5
        @AuraEnabled public Integer snow;
        @AuraEnabled public Double solar_rad;	//846.1
        @AuraEnabled public String[] sources;
        @AuraEnabled public String state_code;	//16
        @AuraEnabled public String station;	//VABB
        @AuraEnabled public String sunrise;	//01:17
        @AuraEnabled public String sunset;	//12:30
        @AuraEnabled public Double temp;	//28.3
        @AuraEnabled public String timezone;	//Asia/Kolkata
        @AuraEnabled public Integer ts;	//1668670760
        @AuraEnabled public Double uv;	//7.541912
        @AuraEnabled public Integer vis;	//16
        @AuraEnabled public cls_weather weather;
        @AuraEnabled public String wind_cdir;	//ENE
        @AuraEnabled public String wind_cdir_full;	//east-northeast
        @AuraEnabled public Integer wind_dir;	//67
        @AuraEnabled public Double wind_spd;	//4.433678
    }

 
    public class cls_weather {
        @AuraEnabled public String icon;	//a02d
        @AuraEnabled public String description;	//Smoke
        @AuraEnabled public Integer code;	//711
    }
}