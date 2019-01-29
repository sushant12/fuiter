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
          frame.style.width = "992px";
          frame.style.left = "50%";
          frame.style.marginLeft = "-496px";
          break;
        case 'tablet':
          frame.style.width = "768px";
          frame.style.left = "50%";
          frame.style.marginLeft = "-384px";
          break;
        case 'phone':
          frame.style.width = "412px";
          frame.style.left = "50%";
          frame.style.marginLeft = "-206px";
          break;
        default:
          frame.style.width = "1920px";
      }
    },
  },
};
</script>
