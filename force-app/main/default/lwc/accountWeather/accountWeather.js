import { LightningElement, api, wire, track } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import getWeatherByCity from '@salesforce/apex/AccountWeatherController.getWeatherByCity';

// Native fields to fetch the Account's billing city
import BILLING_CITY_FIELD from '@salesforce/schema/Account.BillingCity';

const FIELDS = [BILLING_CITY_FIELD];

export default class AccountWeather extends LightningElement {
    @api recordId; // Automatically receives the ID of the current Account page
    @track weatherData;
    @track error;
    @track loading = true;

    cityName;

    // Fetch the account record data reactively
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    wiredAccount({ error, data }) {
        if (data) {
            this.cityName = getFieldValue(data, BILLING_CITY_FIELD);
            if (this.cityName) {
                this.fetchWeather();
            } else {
                this.error = 'Billing City is not defined for this account.';
                this.loading = false;
            }
        } else if (error) {
            this.error = 'Failed to load account data.';
            this.loading = false;
        }
    }

    // Call our Apex controller to fetch integration data
    fetchWeather() {
        this.loading = true;
        getWeatherByCity({ cityName: this.cityName })
            .then((result) => {
                const parsedData = JSON.parse(result);
                // Map the JSON properties safely
                this.weatherData = {
                    temp: parsedData.main?.temp.toFixed(1),
                    description: parsedData.weather?.[0]?.description
                };
                this.error = undefined;
            })
            .catch((err) => {
                this.error = err.body?.message || 'An unexpected error occurred while fetching weather.';
                this.weatherData = undefined;
            })
            .finally(() => {
                this.loading = false;
            });
    }
}