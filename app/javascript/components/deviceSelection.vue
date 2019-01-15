<template>
  <div class="device-selections">
    <span data-device="monitor" class="demo-device-icon-monitor is-active">
      <a><input type="button" name="monitor" value="monitor" @click="monitor"></a>
    </span>
    <span data-device="tablet" class="demo-device-icon-tablet">
      <a><input type="button" name="tablet" value="tablet" @click="tablet"></a>
    </span>
    <span data-device="phone" class="demo-device-icon-phone">
      <a><input type="button" name="phone" value="phone" @click="phone"></a>
    </span>
  </div>
</template>
<script>
export default {
  methods: {
    monitor() {
      document.getElementById("frame").width = "1920";
      document.getElementById("frame").height = "1080";
    },
    tablet() {
      document.getElementById("frame").width = "768";
      document.getElementById("frame").height = "1024";
    },
    phone(){
      document.getElementById("frame").width = "412";
      document.getElementById("frame").height = "732";
    },
  }
}
</script>
