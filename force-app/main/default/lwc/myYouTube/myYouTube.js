import { LightningElement,track, api} from 'lwc';
import  YouTubeLogo from '@salesforce/resourceUrl/YouTubeLogo';
import searchyoutubechannel from '@salesforce/apex/myYoutubeController.searchyoutubechannel';


export default class MyYouTube extends LightningElement {
    @track Info;
    @api queryTerm;
    @api yvalue;
    @api newtext;

    backgroundImage = YouTubeLogo;
    get backgroundStyle() {
        return `height:50rem;background-image:url(${YouTubeLogo})`;
       }

    handleKeyUp(evt) {
        const isEnterKey = evt.keyCode === 13;
        if (isEnterKey) {
            this.queryTerm = evt.target.value;
            this.newtext = evt.target.value;
            console.log('**** New text value ****'+this.newtext);
        }
    }

    value = '';

    get options() {
        return [
            { label: 'Channel', value: 'Channel' },
            { label: 'Video', value: 'Video' },
            { label: 'Playlist', value: 'Playlist' }, 
        ];
    }


    onfilterChange(evt){
        console.log('Button called******** '+evt.target.value);
        this.yvalue = evt.target.value;
    }
}