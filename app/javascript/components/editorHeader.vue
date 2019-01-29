<template>
  <div class="device-selections">
    <span data-device="monitor">
      <a name="monitor" value="monitor" @click="updateResolution('monitor')">
        <i class="fa fa-desktop fa-2x"></i>
      </a>
    </span>
    <span data-device="tablet">
      <a name="tablet" value="tablet" @click="updateResolution('tablet')">
        <i class="fa fa-tablet fa-2x"></i>
      </a>
    </span>
    <span data-device="phone">
      <a name="phone" value="phone" @click="updateResolution('phone')">
        <i class="fa fa-mobile fa-2x"></i>
      </a>
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
          frame.style.width = "1200px";
          frame.style.left = "50%";
          frame.style.margin = "0 0 0 -600px";
          frame.style.borderTop = "5px solid #fff";
          frame.style.borderBottom = "5px solid #fff";
          frame.style.borderLeft = "5px solid #fff";
          frame.style.borderRight = "5px solid #fff";
          frame.style.height = "880px";
          frame.style.borderRadius = "1px";
          break;
        case 'tablet':
          frame.style.width = "991px";
          frame.style.left = "50%";
          frame.style.margin = "30px 0 0 -496px";
          frame.style.borderTop = "75px solid #555555";
          frame.style.borderBottom = "75px solid #555555";
          frame.style.borderLeft = "15px solid #555555";
          frame.style.borderRight = "15px solid #555555";
          frame.style.height = "880px";
          frame.style.borderRadius = "25px 25px 25px 25px";
          break;
        case 'phone':
          frame.style.width = "360px";
          frame.style.left = "50%";
          frame.style.margin = "30px 0 0 -180px";
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
  },
};
</script>
