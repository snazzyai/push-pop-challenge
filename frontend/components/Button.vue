<template>
      <div>
        <button class="btn" @mouseenter="btnAnimate" @mouseleave="btnAnimate" @click="buttonAction" :style="{'backgroundColor': showHoverButtonColor ? hoverEnterColor : hoverLeaveColor }" > {{buttonText}} </button>
      </div>
</template>

<script>
    export default {
        name: 'Button',
        props: ['hoverEnterColor', 'hoverLeaveColor', 'buttonText'],
        methods: {
            btnAnimate(){
                this.showHoverButtonColor  = !this.showHoverButtonColor
            },
            buttonAction(){
                this.$emit('button-action')
            },
        },
        data(){
            return{
                showHoverButtonColor: false
            }
        }
    }

</script>

<style scoped>

.btn{
  background: slateblue;
  color: #fff;
  padding: .5rem .7rem;
  border-radius: 10px;
  margin: 0 2rem
}
@keyframes moveInRight {
    0% {
        opacity: 0;
        transform: translateX(100px);
    }
    50%{
        
        transform: translateX(-10px)
    } 
    100%{
        opacity: 1;
        transform: translateX(0)
    }
}


</style>