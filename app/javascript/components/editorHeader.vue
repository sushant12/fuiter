<template>
  <div class="main-navbar">
    <div class="device-selections">
      <span data-device="monitor" class="demo-device-icon-monitor is-active">
        <a class="icon-link" name="monitor" value="monitor" @click="updateResolution('monitor')" href="#">
          <i class="fas fa-desktop"></i>
        </a>
      </span>
      <span data-device="tablet" class="demo-device-icon-tablet">
        <a class="icon-link" name="tablet" value="tablet" @click="updateResolution('tablet')">
          <i class="fas fa-tablet-alt"></i>
        </a>
      </span>
      <span data-device="phone" class="demo-device-icon-phone">
        <a class="icon-link" name="phone" value="phone" @click="updateResolution('phone')">
          <i class="fas fa-mobile-alt"></i>
          </a>
      </span>
    </div>
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
<style scoped>
  .icon-link{
    padding-left: 20px;
    color: #999999;
  }
  .main-navbar{
    height: 3.3rem;
    
    background-color: #434d58; 
  }
  .device-selections{
    margin-left: 50%;
    padding-top: 15px; 
  }
</style>
