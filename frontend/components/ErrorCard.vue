<template>
        <div class="error-card" :style="{'backgroundColor': showHoverBackground ? hoverColor : color }" @mouseenter="hoverAction" @mouseleave="hoverAction" @click="onClick(errorId)">
            <p><b>Error Message:</b> {{errorMessage}}</p>
            <p><b>Error Code:</b> {{errorCode}}</p>
            <p>Index: {{errorId}}</p>
        </div>
</template>

<script>
    export default {
        name: 'ErrorCard',
        props: ['errorMessage', 'errorCode','errorId', 'color', 'hoverColor'],
        methods: {
            onClick(id){
                this.$emit('resolve-unresolve', id)
            },
            hoverAction(){
                this.showHoverBackground = !this.showHoverBackground
            },
        },
        emits: ['resolve-unresolve'],
        data(){
            return {
                showHoverBackground: false
            }
        }
        
    }
</script>

<style scoped>


.error-card {
 padding: 1.2rem;
 margin: 0.5rem;
 cursor: pointer;
 box-shadow: 1.5px 1.5px 0.5px #000;
 animation: moveInBottom 1.2s ease-out
}

.error-card p{
    font-size: 11px;
}
.error-card{
    
    background: #17BFE4
}
@keyframes moveInBottom {
    0% {
        opacity: 0;
        transform: translateY(50px);
    }
    50%{
        
        transform: translateY(-10px)
    }
    100%{
        opacity: 1;
        transform: translateY(0)
    }
}
</style>