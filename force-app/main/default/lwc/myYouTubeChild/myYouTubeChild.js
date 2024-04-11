import { LightningElement, track, api, wire } from 'lwc';
import searchyoutubechannel from '@salesforce/apex/myYoutubeController.searchyoutubechannel';
import callnextpage from '@salesforce/apex/myYoutubeController.callnextpage';
import callprevpage from '@salesforce/apex/myYoutubeController.callprevpage';


export default class MyYouTubeChild extends LightningElement {
    @api searchkeyword;
    @api searchtype;
    @track results=[];
    @track etag;
    @track items=[{
        snippet: [{
            thumbnails: {
            }
        }]
    }];
    @track nextPageToken;
    @track previouspage;
    @track title; 
    @track description; 
    @track snippet=[];
    @track resultsPerPage;
    @track regionCode;
    @track total;
    @track ids=[];
    

    @wire(searchyoutubechannel, {
        channelstr: '$searchkeyword',
        typ: '$searchtype'
    })
    Wiresearchyoutubechannel({ error, data }) {
        console.log('Code runsss$$');
        if (data) {
            console.log('DATA ****'+JSON.stringify(data));
            // console.log('class  id ****'+(data.snippet));

            // let parseData = JSON.parse(JSON.stringify(data));
            // for (let i = 0; i < parseData.length; i++) {
            //     parseData[i]._children = parseData[i]["items"];
            //   }
            // this.results = parseData;
            this.results = data;
            this.nextPageToken = data.nextPageToken;
            this.total = data.pageInfo.totalResults;
            this.resultsPerPage = data.pageInfo.resultsPerPage;
            this.regionCode = data.regionCode;
            this.items = JSON.stringify(data.items);
            this.error = undefined;
            // data.items.forEach(element => {
            //     console.log('** element inside for loop in JS **'+JSON.stringify(element));
            //     element.snippet.forEach(snipp => {
            //         console.log('** snippet inside for loop in JS **'+JSON.stringify(snipp.channelId));
            //     })
            // });
            // console.log('*etag*'+JSON.stringify(data.etag));
            console.log('*total results*'+JSON.stringify(data.pageInfo.totalResults));
            // console.log('*items*'+JSON.stringify(data.items));
            // console.log('*title*'+JSON.stringify(this.snippet));
            // console.log('*description*'+JSON.stringify(data.items.snippet.description));
            // console.log('*Default url*'+JSON.stringify(data.items.snippet.thumbnails.default.url));
            
        }
        else {
            console.log('***Error***' + JSON.stringify(error));
            this.results = undefined;
            this.error = error;
        }
    }

    nextpagecall(evt){
        console.log('NEXT Page called ****');
        callnextpage({
            ntoken : this.nextPageToken,
            channelstr: this.searchkeyword,
            typ: this.searchtype
        })
        .then((result)=>{
            console.log('prev Page token'+JSON.stringify(result.prevPageToken));
            this.results = result;
            this.nextPageToken = result.nextPageToken;
            this.previouspage= result.prevPageToken;
            console.log('Previous page token at next'+JSON.stringify(result.prevPageToken));
        })
        .catch((error) =>{
            console.log(error);
        })
    }
    prevpagecall(evt){
        console.log('Prev Page called ****');
        console.log('*** ptoken at recived at previous call ***'+JSON.stringify(this.previouspage));
        callprevpage({
            ptoken : this.previouspage,
            channelstr: this.searchkeyword,
            typ: this.searchtype
        })
        .then((result)=>{
            console.log('Previous Page'+JSON.stringify(result));
            this.results = result;
            this.nextPageToken = result.nextPageToken;
            this.previouspage= result.prevPageToken;
        })
        .catch((error) =>{
            console.log(error);
        })
    }
}