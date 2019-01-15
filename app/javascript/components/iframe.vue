<template>
  <div>
    <nav class="navbar is-black" role="navigation" aria-label="main navigation">
      <div class="navbar-brand">
        <a class="navbar-item" href="#">
          <h1>Site Title</h1>
        </a>

        <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false">
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
        </a>
      </div>
      <div id="navbarBasicExample" class="navbar-menu">
        <div class="navbar-start">
          <a class="navbar-item">
            Home
          </a>

          <a class="navbar-item">
            Documentation
          </a> 
        </div>
      </div>
    </nav> 
    <div class="site-preview">
      <iframe :src="iframeSrc" scrolling="yes" frameborder="0" id="frame" allowfullscreen></iframe>
    </div>
  </div>
</template>

<script>
export default {
  props: ['url'],
  data() {
    return {
      iframeSrc: '',
    };
  },
  mounted() {
    this.iframeSrc = this.url;
  },

};
</script>

<style scoped>
  .site-preview{
  overflow: hidden;
  position: absolute;
  /* height: 100%; */
  left: 250px;
  right: 0px;
  top: 0px;
  bottom: 0px;
  margin-top: 3.25rem;
  /* z-index: 1; */
}

.site-preview iframe {
  position: absolute;
  top:0;
  left:0;
  height: 100%;
  width: 100%;
}
</style>