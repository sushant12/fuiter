<template>
<div>
 <div class="border-wrap">
      <p class="p-inner-label">Pages</p>
      <select class="select-page" v-model="page" @change="showBills">
        <option
          class="option-page"
          v-for="page in pages"
          :value="page.id"
        >{{page.name}}</option>
      </select>
    </div>
  <div v-if="pageStatus === 'online'"> 
    <button @click='cancelSubscription'>Cancel Subscription</button>
  </div>  
  <div v-for='bill in billingHistory'>
    Start: {{convertDateTime(bill['start_date'])}} <br>
    Expires: {{convertDateTime(bill['end_date'])}} <br>
  </div>
</div>

</template>

<script>
import BillingService from '../services/billingService';
import moment from 'moment';

export default {
  props: ["pages"],
  data() {
    return {
      page: '',
      pageStatus: '',
      billingHistory: [],
    };
  },
  methods: {
    showBills() {
      const that = this;
      BillingService.getBillingHistory(this.page)
        .then(({data}) => {
          that.billingHistory = data;
          that.pages.forEach((page) => {
            if(page.id == that.page){
              that.pageStatus = page.status;
            }
          });
        })
        .catch(() => {
          that.billingHistory = [];
        });
    },
    convertDateTime(value) {
      return moment(value).format('MMMM Do YYYY, h:mm:ss a');
    },
    cancelSubscription() {
      BillingService.cancelSubscription(this.page)
        .then(({data}) => {
          this.pageStatus = 'in progress';
        });
    }
  },
};
</script>

<style scoped>
  
</style>

