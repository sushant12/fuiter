<template>
  <div class="device-selections">
    <span data-device="monitor" class="demo-device-icon-monitor is-active">
      <a><input type="button" name="monitor" value="monitor" @click="updateResolution('monitor')"></a>
    </span>
    <span data-device="tablet" class="demo-device-icon-tablet">
      <a><input type="button" name="tablet" value="tablet" @click="updateResolution('tablet')"></a>
    </span>
    <span data-device="phone" class="demo-device-icon-phone">
      <a><input type="button" name="phone" value="phone" @click="updateResolution('phone')"></a>
    </span>
  </div>
</template>
<script>
export default {
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
  },
};
</script>
