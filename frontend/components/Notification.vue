<template>
        <div class="notification-card">
            <p>Changes made successfully!</p>
        </div>
</template>

<script>
    export default {
        name: 'Notification',
        props: [],
        methods: {
       
        },
    }
</script>

<style scoped>
.notification-card{
    padding: 0.5rem;
    text-align: center;
    margin: 1rem;
    cursor: pointer;
    width: 20rem;
    background: #93D93B;
    float: right;
    animation: moveInRight 1.2s ease-out
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