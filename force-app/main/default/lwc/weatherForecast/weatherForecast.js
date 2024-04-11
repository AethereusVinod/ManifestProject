import { LightningElement,api,wire,track } from 'lwc';
import getWeather from '@salesforce/apex/WeatherForecastController.getWeather';

export default class WeatherForecast extends LightningElement {
    @api recordId;
    results = true;
    @track Information={};
    clicked = true;

    refreshWeather(evt){
        console.log('Refresh button called *********');
        getWeather({
            recId : this.recordId
        })
        .then((result)=>{
                console.log('**data* '+result);
                console.log('**data** JSON '+JSON.stringify(result));
                this.Information = result.data;
                this.error = undefined;
                //this.clicked = false;
        })
        .catch((error) =>{
            console.log(error);
        });
    }
    
}