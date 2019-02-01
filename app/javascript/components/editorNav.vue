<template>
  <nav class="navbar navbar-wrapper is-solid navbar-inverse is-reverse">
    <div class="container">
      <div class="navbar-brand">
        <a class="navbar-item" href="http://localhost:3000/">
          <img alt="" src="https://bulkitv2.cssninja.io/agency/assets/images/logos/bulkit-white.svg">
        </a>
        <div class="custom-burger" data-target="">
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
            <span data-device="monitor"><i class="fa fa-desktop fa-2x"></i></span>
          </a>
          <a class="navbar-item">
            <span data-device="tablet"><i class="fa fa-tablet fa-2x"></i></span>
          </a>
          <a class="navbar-item">
            <span data-device="phone"><i class="fa fa-tablet fa-2x"></i></span>
          </a>
        </div>
        <div class="navbar-end">
          <div class="navbar-item">
            <div class="mobile-drop is-hidden-desktop">
              <a class="navbar-item is-slide" href="/users/sign_out">Go Live</a>
              <a class="navbar-item is-slide" href="/users/sign_out">Sync</a>
            </div>
            <div class="navbar-item is-hidden-mobile is-hidden-tablet-only">
              <a :href="preview" class="button warning-btn btn-outlined rounded" target="__BLANK">Preview</a>
            </div>
            <div class="navbar-item is-hidden-mobile is-hidden-tablet-only">
              <a @click="fbSync" class="button primary-btn btn-outlined rounded">Sync</a>
            </div>
            <div class="navbar-item is-hidden-mobile is-hidden-tablet-only">
              <a href="goLive" class="button success-btn btn-outlined rounded">Go Live</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </nav>
</template>
<script>

import EditorServices from '../services/index.js';

export default {
  props: ['sync', 'goLive', 'preview'], 
  methods: {
    updateResolution(type) {
      const frame = document.getElementById("frame");
      switch(type) {
        case 'monitor':
          frame.style.width = "1920px";
          break;
        case 'tablet':
          frame.style.width = "768px";
          break;
        case 'phone':
          frame.style.width = "412px";
          break;
        default:
          frame.style.width = "1920px";
      }
    },
    fbSync() {
      EditorServices.fbSync(this.sync);
    },
  },
};
</script>
