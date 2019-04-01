<template>
  <nav class="navbar navbar-wrapper is-solid navbar-inverse is-reverse">
    <div class="navbar-brand">
      <a class="navbar-item brand-logo editor-bulkit-logo" :href="url">
        <img alt src="https://bulkitv2.cssninja.io/agency/assets/images/logos/bulkit-white.svg">
      </a>
      <div class="tab-only">
        <a class="navbar-item">
          <span data-device="monitor">
            <a name="monitor" value="monitor" @click="updateResolution('monitor')">
              <i class="fa fa-desktop fa-2x"></i>
            </a>
          </span>
        </a>
        <a class="navbar-item">
          <span data-device="tablet">
            <a name="tablet" value="tablet" @click="updateResolution('tablet')">
              <i class="fa fa-tablet fa-2x"></i>
            </a>
          </span>
        </a>
        <a class="navbar-item">
          <span data-device="phone">
            <a name="phone" value="phone" @click="updateResolution('phone')">
              <i class="fa fa-mobile fa-2x"></i>
            </a>
          </span>
        </a>
      </div>
      <div class="custom-burger" data-target>
        <a class="responsive-btn" href="javascript:void(0);">
          <span class="menu-toggle">
            <span class="icon-box-toggle">
              <span class="rotate">
                <i class="icon-line-top"></i>
                <i class="icon-line-center"></i>
                <i class="icon-line-bottom"></i>
              </span>
            </span>
          </span>
        </a>
      </div>
    </div>
    <div class="navbar-menu">
      <div class="navbar-start">
        <a class="navbar-item">
          <span data-device="monitor">
            <a name="monitor" value="monitor" @click="updateResolution('monitor')">
              <i class="fa fa-desktop fa-2x"></i>
            </a>
          </span>
        </a>
        <a class="navbar-item">
          <span data-device="tablet">
            <a name="tablet" value="tablet" @click="updateResolution('tablet')">
              <i class="fa fa-tablet fa-2x"></i>
            </a>
          </span>
        </a>
        <a class="navbar-item">
          <span data-device="phone">
            <a name="phone" value="phone" @click="updateResolution('phone')">
              <i class="fa fa-mobile fa-2x"></i>
            </a>
          </span>
        </a>
      </div>
      <div class="navbar-end">
        <div class="page-launch-menu">
          <div
            class="mobile-drop is-hidden-desktop"
            style="display:flex; justify-content:flex-end;"
          >
            <a class="navbar-item is-slide" href="/users/sign_out">Go Live</a>
            <a class="navbar-item is-slide" href="/users/sign_out">Sync</a>
            <a class="navbar-item is-slide" href="/users/sign_out">preview</a>
          </div>
          <div class="navbar-item is-hidden-mobile is-hidden-tablet-only">
            <a
              :href="preview"
              class="button warning-btn"
              target="__BLANK"
            >Preview</a>
          </div>
          <div v-if="fbSyncLoading" class="navbar-item is-hidden-mobile is-hidden-tablet-only">
            <Loader />
          </div>
          <div v-else class="navbar-item is-hidden-mobile is-hidden-tablet-only">
            <a @click="fbSync" class="button primary-btn">Sync</a>
          </div>    
          <div class="navbar-item is-hidden-mobile is-hidden-tablet-only">
            <a href="goLive" class="button success-btn ">Go Live</a>
          </div>
        </div>
      </div>
    </div>
  </nav>
</template>
<script>
import EditorServices from "../services/index.js";
import Loader from './Shared/Loader.vue';

export default {
  data() {
    return {
      fbSyncLoading: false,
    }
  },
  props: ["sync", "goLive", "preview", "url"],
  methods: {
    updateResolution(type) {
      const frame = document.getElementById("frame");
      switch (type) {
        case "monitor":
          frame.style.width = "1300px";
          frame.style.marginTop = "0";
          // frame.style.left = "50%";
          // frame.style.margin = "0 0 0 -600px";
          frame.style.borderTop = "5px solid #fff";
          frame.style.borderBottom = "5px solid #fff";
          frame.style.borderLeft = "5px solid #fff";
          frame.style.borderRight = "5px solid #fff";
          frame.style.height = "880px";
          frame.style.borderRadius = "1px";
          break;
        case "tablet":
          frame.style.width = "991px";
          frame.style.marginTop = "20px";
          // frame.style.left = "50%";
          // frame.style.margin = "30px 0 0 -496px";
          frame.style.borderTop = "75px solid #555555";
          frame.style.borderBottom = "75px solid #555555";
          frame.style.borderLeft = "15px solid #555555";
          frame.style.borderRight = "15px solid #555555";
          frame.style.height = "880px";
          frame.style.borderRadius = "25px 25px 25px 25px";
          break;
        case "phone":
          frame.style.width = "360px";
          frame.style.marginTop = "20px";
          // frame.style.left = "50%";
          // frame.style.margin = "30px 0 0 -180px";
          frame.style.borderTop = "50px solid #555555";
          frame.style.borderBottom = "50px solid #555555";
          frame.style.borderLeft = "10px solid #555555";
          frame.style.borderRight = "10px solid #555555";
          frame.style.height = "650px";
          frame.style.borderRadius = "25px 25px 25px 25px";
          break;
        default:
          frame.style.width = "1920px";
      }
    },
    fbSync() {
      this.fbSyncLoading = true
      EditorServices.fbSync(this.sync).then(response => {
        this.fbSyncLoading = false
        document.getElementById("frame").contentWindow.location.reload();
      }).catch(error => {
        this.fbSyncLoading = false
      })
    }
  },
  components: {
   Loader,
  }
};
</script>
<style scoped>
/* .brand-logo {
  width: 336px;
} */
.navbar-start {
  display: flex;
  justify-content: center;
}
.navbar-start a span a .fa {
  color: white;
}
</style>
<style>
.editor-bulkit-logo {
  width: 336px;
}
.tab-only {
  display: none;
}
@media screen and (max-width: 1088px) {
  .tab-only {
    display: flex;
    flex-flow: row;
    justify-content: center;
    width: 100%;
    margin-right: 10%;
  }
  .tab-only a span a .fa {
    color: white;
  }
  .editor-bulkit-logo {
    width: 141px;
  }
  #editor .navbar-wrapper .navbar-brand .custom-burger {
    display: flex;
  }
  #editor .navbar-wrapper .navbar-menu .navbar-start {
    display: none;
  }
  #editor .navbar-wrapper .navbar-menu .navbar-end .navbar-item .mobile-drop {
    display: flex;
    flex-direction: column;
    justify-content: center;
    text-align: center;
  }
}
@media screen and (max-width: 768px) {
  .tab-only {
    display: none;
    /* flex-flow: row;
    justify-content: center; */
  }
  .navbar-start {
    display: none;
  }
  /* .tab-only a span a .fa {
    color: white;
  }
  .editor-bulkit-logo {
    width: 141px;
  }
  #editor .navbar-wrapper .navbar-brand .custom-burger {
    display: flex;
  } */
}
.page-launch-menu{
  display: flex;
  flex-flow: row;
}
</style>
