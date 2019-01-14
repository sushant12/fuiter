<template>
  <div id="site_preview">
    <iframe :src="iframeSrc" scrolling="yes" frameborder="0" id="frame" allowfullscreen></iframe>
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

</style>