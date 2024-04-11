import { LightningElement, api, wire, track } from 'lwc';
import ContList from '@salesforce/apex/ContactInfoController.ContList';
import SystemModstamp from '@salesforce/schema/Account.SystemModstamp';

const CARD_VISIBILE_CLASS = 'slds-show'
const CARD_HIDDEN_CLASS = 'slds-hide'

const PageDotVisible_Class = 'dotActive'
const PageDotHidden_Class = 'dot'

var pagenumber = 1;
export default class ChildContactInfo extends LightningElement {
    @api parentAccountId;
    @api lstSelectedRecords;
    @track contactsinfo;
    @track contacts;
    @track oncontactcreate;
    @api refreshchild;

    @wire(ContList, { accId: '$parentAccountId' })
    WireContList({ error, data }) {
        console.log('^^^^^^^^Error^^^^^' + error + '^^^^^^^^DATA^^^^^^^^' + JSON.stringify(data));
        if (data) {
            this.contacts = data.map((item, index) => {
                return index <= 2 ? {
                    ...item,
                    contactIndex: index + 1,
                    cardClasses: CARD_VISIBILE_CLASS,
                    Page: ((index + 3) % 3 == 0) ? true : false,
                    pagedot: ((index + 3) % 3 == 0) ? PageDotHidden_Class : null,
                    PageNumber: index < 2 ? pagenumber : pagenumber++
                } :
                    {
                        ...item,
                        contactIndex: index + 1,
                        cardClasses: CARD_HIDDEN_CLASS,
                        Page: ((index + 3) % 3 == 0) ? true : false,
                        pagedot: ((index + 3) % 3 == 0) ? PageDotHidden_Class : null,
                        PageNumber: (index%3) == 0 ? pagenumber++ : pagenumber
                    }

            })
            console.log('Con*** ' + JSON.stringify(this.contacts));
        }

        else {
            this.error = error;
            this.contacts = undefined;
            console.log('Contacts not recieved+++' + JSON.stringify(error));
        }

    }
    getSelectedName(event) {


        // var selectedRecords =  this.template.querySelector("lightning-input");
        var selectedRecords = [...this.template.querySelectorAll('lightning-input')]
            .filter(element => element.checked)
            .map(element => element.label);
        console.log('SELECTED Rows &&&&&& ' + JSON.stringify(selectedRecords));

        var contactIds = [...this.template.querySelectorAll('lightning-input')]
            .filter(element => element.checked)
            .map(element => element.value);
        console.log('Contact Ids selected &&&&&& ' + JSON.stringify(contactIds));

        const selectEvent = new CustomEvent("selectedcontacts", {
            detail: { contact: { contactIds }, selectedcon: { selectedRecords } }
        });

        console.log('Event on dispatch state' + selectEvent);
        this.dispatchEvent(selectEvent);
    }

    prevcon() {
        var showvar;
        var hidevar = [];
        this.contacts.forEach(element => {
            if (element.cardClasses === 'slds-show') {
                // element.cardClasses ='slds-hide'
                showvar = element.contactIndex;
            }
            else {
                // element.cardClasses ='slds-show'
                hidevar = element.contactIndex;
            }
        });
        console.log('Hide Var ' + hidevar + '* Show var*' + showvar);
    }

    nextcon() {
        console.log('next buttton called');
        console.log('Contact index ' + JSON.stringify(this.contacts));
        var showele = [];
        var hideele = [];
        this.contacts.forEach(element => {
            if (element.cardClasses === 'slds-show') {
                console.log('Contact Index  **** ' + JSON.stringify(element.contactIndex));
                showele = JSON.stringify(element.contactIndex);
                element.cardClasses = 'slds-hide'
            }
            else {
                element.cardClasses = 'slds-show'
                console.log('Inside hide classes ' + element.contactIndex);
            }
        });
        // this.contacts[showele+1].cardClasses ='slds-show'
        // this.contacts[showele+2].cardClasses ='slds-show'
        // this.contacts[showele+3].cardClasses ='slds-show'
        // this.contacts[showele].cardClasses ='slds-hide'
        // this.contacts[showele-1].cardClasses ='slds-hide'
        // this.contacts[showele-2].cardClasses ='slds-hide'

        console.log(JSON.stringify(showele));
        console.log(JSON.stringify(hideele));

        if (showele != null) {
        }
        let contactIndex = this.ContactIndex
        this.contactslidehandler(contactIndex)
    }

    contactslidehandler(id) {
        console.log('slider handler buttton called' + id);
        if (id > this.contacts.length) {
            this.contactIndex = 1
        }
        else if (id < this.contacts.length) {
            this.contactIndex = this.contacts.length
        }
        else {
            this.contactIndex = id
        }
    }
}