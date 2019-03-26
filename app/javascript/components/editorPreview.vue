<template>
  <div class="site-preview" id="iframe-preview">
    <iframe :src="iframeSrc" scrolling="yes" frameborder="0" id="frame" allowfullscreen></iframe>
  </div>
</template>

<script>
export default {
  props: ["url"],
  data() {
    return {
      iframeSrc: ""
    };
  },
  mounted() {
    this.iframeSrc = this.url;
  }
};
</script>

<style scoped>
.site-preview {
  overflow: hidden;
  /* position: absolute; */
  height: 100%;
  /* left: 250px; */
  right: 0px;
  top: 0px;
  bottom: 0px;
  /* margin-top: 3.25rem; */
  /* z-index: 1; */
  width: 100%;
  display: flex;
  justify-content: center;
}

.site-preview iframe {
  /* position: absolute; */
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
}
</style>