<template>
  <div id="editor-setting-component">
    <div class="legal-info-save-area">
      <h1>Settings</h1>
      <button class="button is-info" @click="saveSetting()">Save Info</button>
    </div>
    <div class="component-example">
      <div class="domain-search-box m-40">
          <h1 class="subtitle">search for domain</h1>
        <div class="domain-search-row">
          <div class="one-row-cig">
            <div class="subdomain">
              <h2>www.</h2>
              <input class="sub-input" type="text" placeholder="">
              <!-- <h2>.fuiter.com</h2> -->
            </div>

            <div class="dropdown btn-for-custom-domain"" id="domain-dropdown" >
              <div class="dropdown-trigger">
                <button class="button is-light border-green" aria-haspopup="true" aria-controls="dropdown-menu">
                  <span>.com</span>
                  <span class="icon is-small">
                    <i class="fas fa-angle-down" aria-hidden="true"></i>
                  </span>
                </button>
              </div>
              <div class="dropdown-menu" id="dropdown-menu" role="menu">
                <div class="dropdown-content">
                  <a class="dropdown-item"  :href='domain' target='__blank'>
                    ok
                  </a>

                </div>
              </div>
            </div>
            <div class="btn-for-custom-domain">
              <!-- <h1 class="subtitle">Connect Your Domain</h1> -->
              <button class="button is-info">search</button>

            </div>
          </div>
        </div>

      </div>
      <div class="domain-options-box">
        <div class="m-40">
          <div class="is-flex">
            <h1 class="subtitle"> select sub-domain</h1>
            <span class="icon tooltip is-tooltip-right" data-tooltip="if you don't have any purchased domain build website with subdomain ">
              <icon class="fas fa-question-circle" ></icon>
            </span>
          </div>

          <div class="one-row-cig">

            <div class="dropdown" id="domain-dropdown" @click="showDomainDropDown">
              <div class="dropdown-trigger">
                <button class="button is-light border-green" aria-haspopup="true" aria-controls="dropdown-menu">
                  <span>{{domains[0]}}</span>
                  <span class="icon is-small">
                    <i class="fas fa-angle-down" aria-hidden="true"></i>
                  </span>
                </button>
              </div>
              <div class="dropdown-menu" id="dropdown-menu" role="menu">
                <div class="dropdown-content">
                  <a class="dropdown-item" v-for="domain in domains" :href='domain' target='__blank'>
                    {{domain}}
                  </a>

                </div>
              </div>
            </div>
          </div>
          <h6 class="has-text-grey">Your website is published at the domain above</h6>
        </div>
        <h1 class="subtitle">link domain</h1>
        <div class="one-row-cig ">

          <div class="subdomain">
            <h2>www.</h2>
            <input class="sub-input" v-model="customDomain" type="text" placeholder="">
            <!-- <h2>.fuiter.com</h2> -->
          </div>
          <div class="btn-for-custom-domain">
            <!-- <h1 class="subtitle">Connect Your Domain</h1> -->
            <button @click="saveSetting()" class="button is-info">Link domain</button>

          </div>
        </div>

        <!-- <h6 class="has-text-grey">Your website is published at the domain above</h6>-->
      </div>

      <div>
        <div class="long-doc-wysiwyg-area">
          <h6>Terms and Conditions</h6>
          <div class="field ">
            <input id="switchRoundedOutlinedDefault" type="checkbox" name="enableTermsCondition" class="switch is-rounded is-outlined" checked="checked" v-model="enableTermsCondition">
            <label class="has-text-grey"for="switchRoundedOutlinedDefault">Enable?</label>
          </div>
          <!-- <input type="checkbox" v-model="enableTermsCondition"  > Enable? -->
          <wysiwyg v-model="termsCondition" class="long-doc-wysiwyg"/>
        </div>
        <div class="long-doc-wysiwyg-area">
          <h6>Privacy Policy</h6>
          <div class="field ">
            <input id="switchRoundedOutlinedDefault" type="checkbox" name="enablePrivacyPolicy" class="switch is-rounded is-outlined" checked="checked" v-model="enablePrivacyPolicy">
            <label class="has-text-grey"for="switchRoundedOutlinedDefault">Enable?</label>
          </div>
          <!-- <input type="checkbox" v-model="enablePrivacyPolicy">Enable? -->
          <wysiwyg v-model="privacyPolicy" class="long-doc-wysiwyg"/>
        </div>
      </div>
      <div class="messenger-toggle-area">
        <div class="">
          <h6 class="text-bold">
            <span class="icon has-text-info is-large  fas fa-2x ">
              <i class="fab fa-facebook-messenger"></i>
            </span>
            Facebook Messenger
          </h6>

        </div>
        <!-- <div class="message">

          activate facebook messenger on your website that allows site visiors to send message directly to your facebook page.
        </div> -->
        <div class="field ">
          <input id="switchRoundedOutlinedDefault" type="checkbox" name="switchRoundedOutlinedDefault" class="switch is-rounded is-outlined" checked="checked" v-model="enableFbMessenger">
          <label class="has-text-grey"for="switchRoundedOutlinedDefault"></label>
        </div>

      </div>
      <div class="messenger-toggle-area">
        <!-- <div class="">
          <h6 class="text-bold">
            <span class="icon has-text-info is-large  fas fa-2x ">
              <i class="fab fa-facebook-messenger"></i>
            </span>
            Facebook Messenger
          </h6>

        </div> -->
        <div class="message">

          activate facebook messenger on your website that allows site visiors to send message directly to your facebook page.
        </div>
        <!-- <div class="field ">
          <input id="switchRoundedOutlinedDefault" type="checkbox" name="switchRoundedOutlinedDefault" class="switch is-rounded is-outlined" checked="checked" v-model="enableFbMessenger">
          <label class="has-text-grey"for="switchRoundedOutlinedDefault"></label>
        </div> -->

      </div>
    </div>

    <!-- <button class="button is-info" @click="saveSetting()">Save Info</button> -->
  </div>
</template>

<script>
import EditorServices from "../../services/index.js";
import _ from 'lodash';

export default {
  props: ["fb_page_id", "template", "fb_page_name"],
  data() {
    return {
      domains: [],
      customDomain: '',
      subDomain: '',
      enableTermsCondition: false,
      enablePrivacyPolicy: false,
      enableFbMessenger: false,
      termsCondition: `<p class="pad-10">Terms of Service</p>
          <p class="pad-10"><b>1. Terms</b></p>
          <p>By accessing the website at ${this.domain}, you are agreeing to be bound by these terms of
          service, all applicable laws and regulations, and agree that you are responsible for compliance with any
          applicable local laws. If you do not agree with any of these terms, you are prohibited from using or accessing
          his site. The materials contained in this website are protected by applicable copyright and trademark law.</p>
          <p class="pad-10"><b>2. Use License</b></p>
          <p>a. Permission is granted to temporarily download one copy of the materials (information or software) on
          ${this.fb_page_name}'s website for personal, non-commercial transitory viewing only. This is the grant of a license, not a
          transfer of title, and under this license you may not:
          <ul>
            <li>1. modify or copy the materials;</li>
            <li>2. use the materials for any commercial purpose, or for any public display (commercial or non-commercial);</li>
            <li>3. attempt to decompile or reverse engineer any software contained on ${this.fb_page_name}'s website;</li>
            <li>4. remove any copyright or other proprietary notations from the materials; or</li>
            <li>5. transfer the materials to another person or 'mirror' the materials on any other server.</li>
          </ul>
          <p class="pad-10">b. This license shall automatically terminate if you violate any of these restrictions and may be terminated
          by ${this.fb_page_name} at any time. Upon terminating your viewing of these materials or upon the termination of this license,
          you must destroy any downloaded materials in your possession whether in electronic or printed format.</p>
          <p class="pad-10"><b>3. Disclaimer</b></p>
          <p>a. The materials on ${this.fb_page_name}'s website are provided on an 'as is' basis. ${this.fb_page_name} makes no warranties, expressed
            or implied, and hereby disclaims and negates all other warranties including, without limitation, implied warranties
            or conditions of merchantability, fitness for a particular purpose, or non-infringement of intellectual property
            or other violation of rights.</p>
            <p class="pad-10">b. Further, ${this.fb_page_name} does not warrant or make any representations concerning the accuracy, likely results, or reliability
            of the use of the materials on its website or otherwise relating to such materials or on any sites linked to this site.</p>
            <p class="pad-10"><b>4. Limitations</b></p>
            <p>In no event shall ${this.fb_page_name} or its suppliers be liable for any damages (including, without limitation, damages for loss of data
            or profit, or due to business interruption) arising out of the use or inability to use the materials on ${this.fb_page_name}'s website,
            even if ${this.fb_page_name} or a ${this.fb_page_name} authorized representative has been notified orally or in writing of the possibility
            of such damage. Because some jurisdictions do not allow limitations on implied warranties, or limitations of
            liability for consequential or incidental damages, these limitations may not apply to you.</p>
            <p class="pad-10"><b>5. Accuracy of materials</b></p>
            <p>The materials appearing on ${this.fb_page_name}'s website could include technical, typographical, or photographic errors.
            ${this.fb_page_name} does not warrant that any of the materials on its website are accurate, complete or current. ${this.fb_page_name} may make changes to the
            materials contained on its website at any time without notice. However ${this.fb_page_name} does not make any commitment
            to update the materials.</p>
            <p class="pad-10"><b>6. Links</b></p>
            <p>${this.fb_page_name} has not reviewed all of the sites linked to its website and is not responsible for the contents of
            any such linked site. The inclusion of any link does not imply endorsement by ${this.fb_page_name} of the site. Use of any such
            linked website is at the user's own risk.</p>
            <p class="pad-10"><b>7. Modifications</b></p>
            <p>${this.fb_page_name} may revise these terms of service for its website at any time without notice. By using this website
            you are agreeing to be bound by the then current version of these terms of service.</p>
            <p class="pad-10"><b>8. Governing Law</b></p>
            <p>These terms and conditions are governed by and construed in accordance with the laws of United States and
            you irrevocably submit to the exclusive jurisdiction of the courts in that State or location.</p>`,
      privacyPolicy: `<h1>${this.fb_page_name} Privacy Policy</h1>
          <p class="pad-10">${
            this.fb_page_name
          } (the “Company”) is committed to protecting the privacy of its users. This Privacy Policy (“Privacy
          Policy”) is designed to help you understand what information we gather, how we use it, what we do to protect
          it, and to assist you in making informed decisions when using our Service. Unless otherwise indicated below,
          this Privacy Policy applies to any website that references this Privacy Policy, any Company website, as well
          as any data the Company may collect across partnered and unaffiliated sites.</p>
          <p class="pad-10">For purposes of this Agreement, “Service” refers to the Company’s service which can be accessed via our
          website at ${
            this.domain
          } or through our mobile application. The terms “we,” “us,” and “our”
          refer to the Company. “You” refers to you, as a user of Service.</p>
          <p class="pad-10"><b>i. CONSENT</b></p>
          <p>By accessing our Service, you accept our Privacy Policy and Terms of Use, and you consent to our collection,
          storage, use and disclosure of your personal information as described in this Privacy Policy. In addition, by
          using our Service, or services across partnered and unaffiliated sites, you are accepting the policies and
          practices described in this Privacy Policy. Each time you visit our website, or use the Service, and any time
          you voluntarily provide us with information, you agree that you are consenting to our collection, use and
          disclosure of the information that you provide, and you are consenting to receive emails or otherwise be
          contacted, as described in this Privacy Policy. Whether or not you register or create any kind of account with
          us, this Privacy Policy applies to all users of the website and the Service.</p>
          <p class="pad-10"><b>ii. INFORMATION WE COLLECT</b></p>
          <p>We may collect both “Non-Personal Information” and “Personal Information” about you. “Non-Personal Information”
          includes information that cannot be used to personally identify you, such as anonymous usage data, general
          demographic information we may collect, referring/exit pages and URLs, platform types, preferences you submit
          and preferences that are generated based on the data you submit and number of clicks. “Personal Information”
          includes information that can be used to personally identify you, such as your name, address and email address.</p>
          <p class="pad-10">In addition, we may also track information provided to us by your browser or by our mobile application when
          you view or use the Service, such as the website you came from (known as the “referring URL”), the type of browser
          you use, the device from which you connected to the Service, the time and date of access, and other information
          that does not personally identify you. We use this information for, among other things, the operation of the
          Service, to maintain the quality of the Service, to provide general statistics regarding use of the Service and
          for other business purposes. We track this information using cookies, or small text files which include an
          anonymous unique identifier. Cookies are sent to a user’s browser from our servers and are stored on the user’s
          computer hard drive. Sending a cookie to a user’s browser enables us to collect Non-Personal Information about
          that user and keep a record of the user’s preferences when utilizing our services, both on an individual and
          aggregate basis. The Company may use both persistent and session cookies; persistent cookies remain on your
          computer after you close your session and until you delete them, while session cookies expire when you close
          your browser. Persistent cookies can be removed by following your Internet browser help file directions. If you
          choose to disable cookies, some areas of the Service may not work properly.</p>
          <p class="pad-10"><b>iii. HOW WE USE AND SHARE INFORMATION</b></p>
          <p class="pad-10"><b>Personal Information:</b></p>
          <p>In general, we do not sell, trade, rent or otherwise share your Personal Information with third parties
          without your consent. We may share your Personal Information with vendors and other third-party providers who
          are performing services for the Company. In general, the vendors and third-party providers used by us will
          only collect, use and disclose your information to the extent necessary to allow them to perform the services
          they provide for the Company. For example, when you provide us with personal information to complete a
          transaction, verify your credit card, place an order, arrange for a delivery, or return a purchase, you
          consent to our collecting and using such personal information for that specific purpose, including by transmitting
          such information to our vendors (and their service providers) performing these services for the Company.</p>
          <p class="pad-10">However, certain third-party service providers, such as payment processors, have their own privacy policies in
          respect of the information that we are required to provide to them in order to use their services. For these
          third-party service providers, we recommend that you read their privacy policies so that you can understand the
          manner in which your Personal Information will be handled by such providers.</p>
          <p class="pad-10">In addition, we may disclose your Personal Information if required to do so by law or if you violate our Terms of Use.</p>
          <p class="pad-10"><b>Non-Personal Information:</b></p>
          <p>In general, we use Non-Personal Information to help us improve the Service and customize the user experience.
          We also aggregate Non-Personal Information in order to track trends and analyze use patterns of the Service.
          This Privacy Policy does not limit in any way our use or disclosure of Non-Personal Information and we reserve
          the right to use and disclose such Non-Personal Information to our partners, advertisers and other third parties
          at our sole discretion.</p>
          <p class="pad-10"><b>iv. HOW WE PROTECT INFORMATION</b></p>
          <p>We implement reasonable precautions and follow industry best practices in order to protect your Personal
          Information and ensure that such Personal Information is not accessed, disclosed, altered or destroyed.
          However, these measures do not guarantee that your information will not be accessed, disclosed, altered or
          destroyed by breach of such precautions. By using our Service, you acknowledge that you understand and agree
          to assume these risks.</p>
          <p class="pad-10"><b>v. YOUR RIGHTS REGARDING THE USE OF YOUR PERSONAL INFORMATION</b></p>
          <p>You have the right at any time to prevent us from contacting you for marketing purposes. When we send a
          promotional communication to a user via Pagevamp , the user can opt out of further promotional communications
          by following the unsubscribe instructions provided in each promotional e-mail. Please note that notwithstanding
          the promotional preferences you indicate by either unsubscribing or opting out in the Settings section of the
          Site, we may continue to send you administrative emails including, for example, periodic updates to our Privacy
          Policy.</p>
          <p class="pad-10"><b>vi. Fuitter</b></p>
          <p>Our Service is hosted by Fuitter, Inc. (Fuitter). Fuitter provides us with the online e-commerce platform
          that allows us to provide the Service to you. Your information, including Personal Information, may be stored
          through Fuitter's servers. By using the Service, you consent to Fuitter's collection, disclosure, storage,
          and use of your Personal Information in accordance with Fuitter's privacy policy available at https://www.fuitter.com/privacy.</p>
          <p class="pad-10"><b>vii. LINKS TO OTHER WEBSITES</b></p>
          <p>As part of the Service, we may provide links to or compatibility with other websites or applications.
          However, we are not responsible for the privacy practices employed by those websites or the information or
          content they contain. This Privacy Policy applies solely to information collected by us through the Service.
          Therefore, this Privacy Policy does not apply to your use of a third-party website accessed by selecting a
          link via our Service. To the extent that you access or use the Service through or on another website or
          application, then the privacy policy of that other website or application will apply to your access or use of
          that site or application. We encourage our users to read the privacy statements of other websites before
          proceeding to use them.</p>
          <p class="pad-10"><b>viii. AGE OF CONSENT</b></p>
          <p>By using the Service, you represent that you are at least 18 years of age.</p>
          <p class="pad-10"><b>ix. CHANGES TO OUR PRIVACY POLICY</b></p>
          <p>The Company reserves the right to change this Privacy Policy and our Terms of Use at any time. If we decide
          to change this Privacy Policy, we will post these changes on this page so that you are always aware of what
          information we collect, how we use it, and under what circumstances we disclose it. Any such modifications
          become effective upon your continued access to and/or use of the Service five (5) days after we first post the
          changes on the website or otherwise provide you with notice of such modifications. It is your sole responsibility
          to check this website from time to time to view any such changes to the terms of this Privacy Policy. If you do not
          agree to any changes, if and when such changes may be made to this Privacy Policy, you must cease access to this
          website. If you have provided your email address to us, you give us permission to email you for the purpose of
          notification as described in this Privacy Policy.</p>
          <p class="pad-10"><b>x. MERGER OR ACQUISITION</b></p>
          <p>In the event we (or Fuitter) undergo a business transaction such as a merger, acquisition by another
          company, or sale of all or a portion of our assets, your Personal Information may be among the assets
          transferred. You acknowledge and consent that such transfers may occur and are permitted by this Privacy
          Policy, and that any acquirer of our (or Pagevamp’s) assets may continue to process your Personal Information
          as set forth in this Privacy Policy. If our information practices change at any time in the future, we will
          post the policy changes here so that you may opt out of the new information practices. We suggest that you
          check this Privacy Policy periodically if you are concerned about how your information is used.</p>
          <p class="pad-10"><b>xi. EMAIL COMMUNICATIONS & OPTING OUT</b></p>
          <p>We will send you Service-related announcements on occasions when it is necessary to do so. For instance,
          if our Service is temporarily suspended for maintenance, or a new enhancement is released, which will affect
          the way you use our Service, we might send you an email. Generally, you may not opt-out of these communications,
          which are not promotional in nature. Based upon the Personal Information that you provide us, we may communicate
          with you in response to your inquiries to provide the services you request and to manage your account. We will
          communicate with you by email or telephone, in accordance with your wishes. We may also use your Personal
          Information to send you updates and other promotional communications. If you no longer wish to receive those
          email updates, you may opt-out of receiving them by following the instructions included in each update or
          communication.</p>
          <p class="pad-10"><b>xii. CONTACT US & WITHDRAWING CONSENT</b></p>
          <p>If you have any questions regarding this Privacy Policy or the practices of this Site, or wish to withdraw
          your consent for the continued collection, use or disclosure of your Personal Information, please contact us
          by sending an email to.</p>`
    };
  },

  methods: {
    showDomainDropDown(e) {
      let elem = document.getElementById('domain-dropdown');
      if(_.includes(elem.classList, 'is-active')){
        elem.classList.remove('is-active');
      }else{
        elem.className += " is-active";
      }
    },
    saveSetting() {
      EditorServices.updateSetting(this.fb_page_id, {
        subdomain: this.subDomain,
        domain: this.customDomain,
        fb_page_template_id: this.template.id,
        fb_messenger: this.enableFbMessenger,
        legal_info: {
          terms_condition: {
            value: this.termsCondition,
            enable: this.enableTermsCondition,
          },
          privacy_policy: {
            value: this.privacyPolicy,
            enable: this.enablePrivacyPolicy,
          }
        }
      })
        .then( res => {
          this.domains = [];
          this.domains.push(`https://www.${this.subDomain}/fuiter.com`, `https://www.${this.customDomain}`)
        });
    }
  },

  created() {
    EditorServices.showSetting(this.template.id).then(res => {
      if (!_.isNil(res.data)) {
        const settingData = res.data;
        const legalInfo = settingData.legal_info;
        this.customDomain = settingData.domain;

        this.subDomain = settingData.subdomain;
        this.enableFbMessenger = settingData.fb_messenger;

        this.domains.push(`https://www.${this.subDomain}.fuiter.com`);
        if(settingData.domain != null) {
          this.domains.push(`https://www.${settingData.domain}`);
        }
        this.termsCondition = legalInfo.terms_condition.value;
        this.privacyPolicy = legalInfo.privacy_policy.value;
        this.enablePrivacyPolicy = legalInfo.privacy_policy.enable;
        this.enableTermsCondition = legalInfo.terms_condition.enable;
      }
    });
  },
};
</script>

<!-- .legal-info-save-area{
  display:flex;

  <!-- justify -->


<style scoped>
.messenger-toggle-area{
  display:flex;
  width: 100%;
  margin-bottom: 5px;
}
.messenger-toggle-area div{
  margin-right: 20px;
}
.messenger-toggle-area .field{
  margin-top: 15px;
}
.messenger-toggle-area .message{
  width: 80%;
  margin-bottom: 20px;
}
.domain-search-box{
  display:flex;
  flex-flow: column;
  width:100%;
}
.border-green{
  border: 1px solid #00b289;
}
.border-green:hover{
  border: 1px solid #00b289;
}
.m-40{
  margin-bottom: 40px;
}
.subdomain {
  display: flex;
  flex-flow: row;
  /* width: 80%; */
  /* padding-left: 20px; */
  align-items: flex-end;
  height: 45px;
}
.subdomain h2 {
  font-size: 1.5rem;
  padding-bottom: 0;
}
.subdomain .sub-input {
  background-color: transparent;
  border: 1px solid #00b289;
  color: darkgrey;
  height: 2.3rem;
  /* border-style: none none solid none; */
  font-size: 1.5rem;
  outline: none;
  margin: 0 10px 0 10px;
  padding-left: 10px;
  padding-right: 10px;
  border-radius: 5px;
}
.one-row-cig .btn-for-custom-domain{
  display: flex;
  flex-flow: row;
  align-items: end;
  padding-right: 10px;
  background-color: transparent;
}
.legal-info-save-area {
  display: flex;
  flex-flow: row;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  position: -webkit-sticky;
  position: sticky;
  top: 0;
  z-index: 40;
  background-color: white;
  padding: 20px;
}
.legal-info-save-area h1 {
  font-size: 2rem;
}
.legal-info-save-area .button {
  width: 200px;
  border-radius: 0;
  height: 50px;
  font-size: 1.5rem;
}
.one-row-cig {
  display: flex;
  flex-flow: row;
}
.one-row-cig h1 {
  /* //width: 20%; */
  background-color: #00b289;
  color: white;
  text-align: center;
  padding: 5px 10px;

}
.one-row-cig .input {
  /* width: 80%; */
  border: 1px solid #00b289;
  border-radius: 0;
  height: 45px;
  font-size: 1.5rem;
}
.one-row-cig .input::placeholder {
  color: darkgray;
  font-size: 1.5rem;
}
.component-example {
  width: 100%;
  /* margin: 20px 5vw; */
  overflow-y: scroll;
  height: 100%;
  padding: 20px 10vw;
  display: flex;
  align-items: center;
  flex-flow: column;
}
.component-example h1 {
  margin-bottom: 0;
}
/* #4CB289 */
/* 00b289 */
.domain-options-box {
  margin: 20px;
  width: 100%;
}
.long-doc-wysiwyg-area {
  margin: 40px 0;
}
.long-doc-wysiwyg-area h6 {
  font-size: 1.2rem;
  margin-bottom: 10px;
}
.button {
  /* width: 80%; */
}
.long-doc-save-area {
  display: flex;
  justify-content: space-between;
  flex-flow: row;
  width: 100%;
  align-items: center;
}
.long-doc-save-area h1 {
  font-size: 2.5rem;
}
</style>
<style>
.long-doc-wysiwyg {
  /* box-shadow: 5px 5px 5px darkgrey; */
  border: 2px solid #00b289;
}
.long-doc-wysiwyg .editr--toolbar {
  background-color: #00b289;
  padding: 5px 10px 20px 10px;
  height: 45px;
}
.long-doc-wysiwyg .editr--toolbar a svg {
  fill: white;
}
.long-doc-wysiwyg .editr--toolbar a {
  transform: scale(1.2);
}
.long-doc-wysiwyg .editr--content {
  background-color: white;
  height: 300px;
  overflow-y: scroll;
  padding: 10px;
}
#editor-setting-component {
  display: none;
  flex-flow: column;
}
</style>
