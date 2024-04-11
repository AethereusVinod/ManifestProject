public with sharing class myYoutubeController {
    @AuraEnabled(cacheable=true)
    public static Wrapperclass searchyoutubechannel(string channelstr, string typ){
        system.debug('Method has been called ****');
        try {
            string finalstr = ChannelStr.replaceAll(' ','+');
            system.debug('*** finalstr ***');
            Wrapperclass listWrapZipReturnedInfo = new Wrapperclass();
            
            http http = new http();
            HttpRequest  req = new HttpRequest();
            req.setEndpoint('https://youtube.googleapis.com/youtube/v3/search?part=snippet&q='+finalstr+'&type='+typ+'&key=AIzaSyCqW20_1V71nXf9kpfN7-GCu8nsaq_z54I');
            req.setMethod('GET');
            HttpResponse res = http.send(req);
            system.debug('status code for call out'+res.getStatusCode());
            if(res.getStatusCode() == 200){
                String resBody = res.getbody();
                String jsonStr = resBody.replaceAll( '\\s+', ''); 
                system.debug(jsonStr);
                listWrapZipReturnedInfo =(Wrapperclass)json.deserialize(jsonStr,Wrapperclass.class);
                if(listWrapZipReturnedInfo != null){
                    system.debug('Kind '+listWrapZipReturnedInfo.kind);
                    system.debug('etag '+listWrapZipReturnedInfo.etag);
                    system.debug('nextPageToken '+listWrapZipReturnedInfo.nextPageToken);
                    system.debug('regionCode '+listWrapZipReturnedInfo.regionCode);
                    system.debug('items '+listWrapZipReturnedInfo.items);
                }
            }
            else{
                system.debug('Failed status code '+res.getStatusCode());
                system.debug('Failed status ****'+res.getBody());
            }
            return listWrapZipReturnedInfo;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static Wrapperclass callnextpage(string channelstr, string typ, string ntoken){
        system.debug('callnextpage Method has been called ****');
        system.debug('ntoken ***'+ntoken);
        try {
            string finalstr = ChannelStr.replaceAll(' ','+');
            system.debug('*** finalstr ***');
            Wrapperclass listWrapZipReturnedInfo = new Wrapperclass();
            
            http http = new http();
            HttpRequest  req = new HttpRequest();
            req.setEndpoint('https://youtube.googleapis.com/youtube/v3/search?part=snippet&q='+finalstr+'&pageToken='+ntoken+'&type='+typ+'&key=AIzaSyCqW20_1V71nXf9kpfN7-GCu8nsaq_z54I');
            req.setMethod('GET');
            HttpResponse res = http.send(req);
            system.debug('status code for call out'+res.getStatusCode());
            if(res.getStatusCode() == 200){
                String resBody = res.getbody();
                String jsonStr = resBody.replaceAll( '\\s+', ''); 
                system.debug(jsonStr);
                listWrapZipReturnedInfo =(Wrapperclass)json.deserialize(jsonStr,Wrapperclass.class);
                if(listWrapZipReturnedInfo != null){
                    system.debug('Kind '+listWrapZipReturnedInfo.kind);
                    system.debug('etag '+listWrapZipReturnedInfo.etag);
                    system.debug('nextPageToken '+listWrapZipReturnedInfo.nextPageToken);
                    system.debug('regionCode '+listWrapZipReturnedInfo.regionCode);
                    system.debug('pageInfo '+listWrapZipReturnedInfo.pageInfo);
                    system.debug('items '+listWrapZipReturnedInfo.items);
                }
            }
            else{
                system.debug('Failed status code '+res.getStatusCode());
                system.debug('Failed status ****'+res.getBody());
            }
            return listWrapZipReturnedInfo;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static Wrapperclass callprevpage(string channelstr, string typ, string ptoken){
        system.debug('callprevpage Method has been called ****');
        system.debug('ptoken ***'+ptoken);
        try {
            string finalstr = ChannelStr.replaceAll(' ','+');
            system.debug('*** finalstr ***');
            Wrapperclass listWrapZipReturnedInfo = new Wrapperclass();
            
            http http = new http();
            HttpRequest  req = new HttpRequest();
            req.setEndpoint('https://youtube.googleapis.com/youtube/v3/search?part=snippet&q='+finalstr+'&pageToken='+ptoken+'&type='+typ+'&key=AIzaSyCqW20_1V71nXf9kpfN7-GCu8nsaq_z54I');
            req.setMethod('GET');
            HttpResponse res = http.send(req);
            system.debug('status code for call out'+res.getStatusCode());
            if(res.getStatusCode() == 200){
                String resBody = res.getbody();
                String jsonStr = resBody.replaceAll( '\\s+', ''); 
                system.debug(jsonStr);
                listWrapZipReturnedInfo =(Wrapperclass)json.deserialize(jsonStr,Wrapperclass.class);
                if(listWrapZipReturnedInfo != null){
                    system.debug('Kind '+listWrapZipReturnedInfo.kind);
                    system.debug('etag '+listWrapZipReturnedInfo.etag);
                    system.debug('nextPageToken '+listWrapZipReturnedInfo.nextPageToken);
                    system.debug('regionCode '+listWrapZipReturnedInfo.regionCode);
                    system.debug('pageInfo '+listWrapZipReturnedInfo.pageInfo);
					system.debug('total results '+listWrapZipReturnedInfo.pageInfo.totalResults);
                    system.debug('results per page '+listWrapZipReturnedInfo.pageInfo.resultsPerPage);
                    system.debug('items '+listWrapZipReturnedInfo.items);
                }
            }
            else{
                system.debug('Failed status code '+res.getStatusCode());
                system.debug('Failed status ****'+res.getBody());
            }
            return listWrapZipReturnedInfo;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    public class WrapperClass{
        @AuraEnabled public String kind;	//youtube#searchListResponse
        @AuraEnabled public String etag;	//zqbcV7-iH220dtJngnZpGmNTDhw
        @AuraEnabled public String nextPageToken;
        @AuraEnabled public String prevPageToken;	//CAUQAA
        @AuraEnabled public String regionCode;	//IN
        @AuraEnabled public cls_pageInfo pageInfo;
        @AuraEnabled public cls_items[] items;
    }
    public class cls_pageInfo {
        @AuraEnabled public Integer totalResults;	//12800
        @AuraEnabled public Integer resultsPerPage;	//5
    }
    public class cls_items {
        @AuraEnabled public String kind;	//youtube#searchResult
        @AuraEnabled public String etag;	//HlNAeRVSj1ZQWX5mg8V8LVqRYyc
        @AuraEnabled public cls_id id;
        @AuraEnabled public cls_snippet snippet;
    }
    public class cls_id {
        @AuraEnabled public String kind;	//youtube#channel
        @AuraEnabled public String channelId;	//UCqwUrj10mAEsqezcItqvwEw
    }
    public class cls_snippet {
        @AuraEnabled public String publishedAt;	//2015-06-20T08:40:00Z
        @AuraEnabled public String channelId;	//UCqwUrj10mAEsqezcItqvwEw
        @AuraEnabled public String title;	//BB Ki Vines
        @AuraEnabled public String description;	//BB Ki Vines is a channel that chronicles the everyday happenings in the lives of BB and his family members. Bhuvan Bam is an ...
        @AuraEnabled public cls_thumbnails thumbnails;
        @AuraEnabled public String channelTitle;	//BB Ki Vines
        @AuraEnabled public String liveBroadcastContent;	//upcoming
        @AuraEnabled public String publishTime;	//2015-06-20T08:40:00Z
    }
    public class cls_thumbnails {
        @AuraEnabled public cls_default defaul;
        @AuraEnabled public cls_medium medium;
        @AuraEnabled public cls_high high;
    }
    public class cls_default {
        @AuraEnabled public String url;	//https://yt3.ggpht.com/l_ZIXrVEQcHTBTsmpt2CFiWJF9_0hwB3rngr1_lxozZ3Lz58Ij5TcDFOp2TYlioU2gI9RlyExw=s88-c-k-c0xffffffff-no-rj-mo
    }
    public class cls_medium {
        @AuraEnabled public String url;	//https://yt3.ggpht.com/l_ZIXrVEQcHTBTsmpt2CFiWJF9_0hwB3rngr1_lxozZ3Lz58Ij5TcDFOp2TYlioU2gI9RlyExw=s240-c-k-c0xffffffff-no-rj-mo
    }
    public class cls_high {
        @AuraEnabled public String url;	//https://yt3.ggpht.com/l_ZIXrVEQcHTBTsmpt2CFiWJF9_0hwB3rngr1_lxozZ3Lz58Ij5TcDFOp2TYlioU2gI9RlyExw=s800-c-k-c0xffffffff-no-rj-mo
    }
    
    // public class Wrapperclass{
    //     @AuraEnabled public String kind{get;set;}
    //     @AuraEnabled public String etag{get;set;}
    //     @AuraEnabled public String nextPageToken{get;set;}
    //     @AuraEnabled public String regionCode{get;set;}
    //     @AuraEnabled public cls_pageInfo pageInfo{get;set;}
    //     @AuraEnabled public List<cls_items> items;
    //     @AuraEnabled public List<cls_id> id;
    //     @AuraEnabled public List<cls_snippet> snippet;
    //     @AuraEnabled public List<cls_thumbnails> thumbnails;
    //     @AuraEnabled public List<cls_default> defaul;
    //     @AuraEnabled public List<cls_medium> medium;
    //     @AuraEnabled public List<cls_high> high;
    
    // }
    // public class cls_pageInfo {
    //     @AuraEnabled public Integer totalResults{get;set;}
    //     @AuraEnabled public Integer resultsPerPage{get;set;}
    // }
    // public class cls_items {
    //     @AuraEnabled public String kind{get;set;}
    //     @AuraEnabled public String etag{get;set;}	
    //     @AuraEnabled public List<cls_id> id{get;set;}
    //     @AuraEnabled public List<cls_snippet> snippet{get;set;}
    // }
    // public class cls_id {
    //     @AuraEnabled public String kind{get;set;}	
    //     @AuraEnabled public String channelId{get;set;}
    // }
    // public class cls_snippet {
    //     @AuraEnabled public String publishedAt{get;set;}
    //     @AuraEnabled public String channelId{get;set;}	
    //     @AuraEnabled public String title{get;set;}
    //     @AuraEnabled public String description{get;set;}
    //     @AuraEnabled public List<cls_thumbnails> thumbnails{get;set;}
    //     @AuraEnabled public String channelTitle{get;set;}
    //     @AuraEnabled public String liveBroadcastContent{get;set;}
    //     @AuraEnabled public String publishTime{get;set;}
    // }
    // public class cls_thumbnails {
    //     @AuraEnabled public List<cls_default> defaul{get;set;}
    //     @AuraEnabled public List<cls_medium> medium{get;set;}
    //     @AuraEnabled public List<cls_high> high{get;set;}
    // }
    // public class cls_default {
    //     @AuraEnabled public String url{get;set;}	
    // }
    // public class cls_medium {
    //     @AuraEnabled public String url{get;set;}
    // }
    // public class cls_high {
    //     @AuraEnabled public String url{get;set;}	
    // }
    
}