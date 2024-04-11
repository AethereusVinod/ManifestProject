import { LightningElement } from 'lwc';
import LightningAlert from 'lightning/alert';


export default class TestHelloworld extends LightningElement {
    async handleAlertClick() {
        await LightningAlert.open({
            message: 'this is a alert message',
            theme: 'error', // a red theme intended for error states
            label: 'Error!', // this is the header text
        });
    }
}