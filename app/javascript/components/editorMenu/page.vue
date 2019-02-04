<template>
  <div class="component-example">
      <VueNestable
      v-model="menus"
      :max-depth="2"
      key-prop="position"
      children-prop="nested"
      @change="updateMenu()"
    >
      <template slot-scope="{ item }">
        <VueNestableHandle :item="item">
          <i class="fa fa-bars" />
        </VueNestableHandle>
        <span>{{ item.title }}</span>
      </template>
    </VueNestable>
  </div>
</template>

<script>
import EditorServices from '../../services/index';
import { VueNestable, VueNestableHandle } from 'vue-nestable';
import _ from 'lodash';

export default {
  props: ['template', 'fb_page_id'],
  data() {
    return {
      menus: [],
    };
  },
  methods: {
    updateMenu() {
      EditorServices.updateMenu(this.fb_page_id,this.menus);
    },
  },

  created() {
    _.each(JSON.parse(this.template).pages, (page) => {
      this.menus.push(page);
    });
  },
  components: {
    VueNestable,
    VueNestableHandle
  },
};
</script>

<style>
/*
* Style for nestable
*/
.component-example {
  position: relative;
  border-radius: 4px;
  box-shadow: 0 2px 3px 0 rgba(16, 17, 23, 0.1), 0 0 1px 0 rgba(16, 17, 23, 0.1);
  background-color: white;
  color: #49494d;
  padding: 1em;
  flex: 1;
  margin: 1em;
  overflow: hidden;
}

.nestable {
  position: relative;
}
.nestable .nestable-list {
  margin: 0;
  padding: 0 0 0 40px;
  list-style-type: none;
}
.nestable > .nestable-list {
  padding: 0;
}
.nestable-item,
.nestable-item-copy {
  margin: 10px 0 0;
}
.nestable-item:first-child,
.nestable-item-copy:first-child {
  margin-top: 0;
}
.nestable-item .nestable-list,
.nestable-item-copy .nestable-list {
  margin-top: 10px;
}
.nestable-item {
  position: relative;
}
.nestable-item.is-dragging .nestable-list {
  pointer-events: none;
}
.nestable-item.is-dragging * {
  opacity: 0;
  filter: alpha(opacity=0);
}
.nestable-item.is-dragging:before {
  content: ' ';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(106, 127, 233, 0.274);
  border: 1px dashed rgb(73, 100, 241);
  -webkit-border-radius: 5px;
  border-radius: 5px;
}
.nestable-drag-layer {
  position: fixed;
  top: 0;
  left: 0;
  z-index: 100;
  pointer-events: none;
}
.nestable-drag-layer > .nestable-list {
  position: absolute;
  top: 0;
  left: 0;
  padding: 0;
  background-color: rgba(106, 127, 233, 0.274);
}
.nestable [draggable="true"] {
  cursor: move;
}
.nestable-handle {
  display: inline;
}
.blue-text-color {
  color: #415ad4;
}
.purple-text-color {
  color: #b43ceb;
}
.red-text-color {
  color: #e13a3a;
}

</style>