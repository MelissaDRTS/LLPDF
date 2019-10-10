/**
 * Created by melissaderricott on 10/8/19.
 */

import { LightningElement, track, wire } from 'lwc';
import viewPDF from '@salesforce/apex/DownloadPDF.match1';

export default class PdfComponent extends LightningElement {

    @track pdf;
    @track error;

    @wire(viewPDF)
    wiredPDF({error, data}){
        if(data){
            this.pdf=data[0];
            this.error=undefined;
        } else if(error){
            this.error = error;
        }
    }
   // @wire (viewPDF) this.pdf;



}