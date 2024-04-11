import { LightningElement,  track,api, wire} from 'lwc';
import fetchAcc from '@salesforce/apex/ContactInfoController.fetchAcc'
import SaveContact from '@salesforce/apex/ContactInfoController.SaveContact'
import deleteContacts from '@salesforce/apex/ContactInfoController.deleteContacts'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';


export default class ContactInformation extends LightningElement {
    @api recordId;
    @track contactSelected;
    @track contactids = [];
    @track AccountInfo;
    @track contactInserted;
    @track isDelete = false;
    @api RefreshC = false;
    @track newcontacttoast = false;

    @wire(fetchAcc, {recId: '$recordId'})
    WirefetchAcc({error, data}){
        if(data){
            console.log('Account Details recieved+++'+JSON.stringify(data));
            this.AccountInfo = data;
            this.error = undefined;
            console.log('Account values #####'+JSON.stringify(this.AccountInfo));
            console.log('Account name #####'+JSON.stringify(this.AccountInfo.Name));
            console.log('Account Website #####'+JSON.stringify(this.AccountInfo.Website));
            
        }else{
            console.log('recieved nothing +++');
            this.error = error;
            this.AccountInfo = undefined;
        }
    }

    handleContactSelection(event){
        this.contactSelected = event.detail.selectedcon;
        this.contactids = event.detail.contact;
        if(this.contactids.contactIds.length !=0){
            this.deleteButton = true
        }
        else{
            this.deleteButton = false;
        }
        console.log('Event returned to Parent  Detail:'+JSON.stringify(event.detail));
        console.log('Event returned to Parent  last Name:'+JSON.stringify(this.contactSelected));
        console.log('Event returned to Parent  Id:'+JSON.stringify(this.contactids));
    }

    @track isModalOpen = false;

    openModal() {
        this.isModalOpen = true;
    }
    closeModal() {        
        this.isModalOpen = false;
    }
    openDelete() {
        console.log('Delete button called');
        console.log('Delete button called length '+this.contactids.contactIds.length);
        if(this.contactids.contactIds.length != 0){
            this.isDelete = true;
        }
        else{
             this.dispatchEvent(
                new ShowToastEvent({
                  title: "Error",
                  message: "Please select atleast one contact",
                  variant: "Error"
                })
              );
        }
    }
    closeDelete(){
        this.isDelete = false;
    }
    Delcontacts(){
        console.log('Delete Called ');
        console.log(' Contact Ids '+JSON.stringify(this.contactids.contactIds));
        var cntids = [];
        cntids = this.contactids;
        console.log('cntids'+cntids.contactIds);
        deleteContacts({
            SetcontactIds : this.contactids.contactIds
        })
        .then(result=>{
            console.log('Resultttt - *** '+result);
            if(result==='SUCCESS'){
                // refreshApex(this.WirefetchAcc);

                console.log(' inside success ');
                this.dispatchEvent(
                    new ShowToastEvent({
                              title: 'Success',
                              message: 'The record has been deleted successfully.',
                              variant: 'Caution',
                              mode: 'pester'
                          })
                 );
                 this.isDelete = false;
                          }
        })
   
    }
    submitDetails() {

        const inputFields = [...this.template.querySelectorAll(
            'lightning-input-field'
        )].map(Element => Element.value)
        
        SaveContact({  FirstNme : inputFields[0].FirstName,
                 LastNme: inputFields[0].LastName,
                 Phne: inputFields[1],
                 emal: inputFields[2],
                AccId : this.recordId
        })
            .then(res=>{
                console.log('result '+res);
                if(res==='SUCCESS'){
                    console.log(' inside sucess ');
                    this.dispatchEvent(
                        new ShowToastEvent({
                                  title: 'Success',
                                  message: 'The record has been created successfully.',
                                  variant: 'success',
                                  mode: 'pester'
                              })
                     );
                     this.isModalOpen = false;
               }
               else{
                this.newcontacttoast = false;
               }
            });

    }
 
}