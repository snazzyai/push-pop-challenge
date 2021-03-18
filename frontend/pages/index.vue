<template>
  <div>
    <Notification v-if="showNotification"/>
    <div>
      <div class='btn-container'>
        <Button :hoverEnterColor="colors.hoverEnterColor" :hoverLeaveColor="colors.hoverLeaveColor" :buttonText="'Undo Last'" @button-action="undoButtonAction"/>
        <Button :hoverEnterColor="colors.hoverEnterColor" :hoverLeaveColor="colors.hoverLeaveColor" :buttonText="'Undo All'" @button-action="undoAll"/>
      </div>
    </div>
    <div class="container">
    <div class="error-card-container">
      <p class="error-heading"> Resolved Errors </p>
      <p v-if="resolved.length == 0" class="error-empty">No errors in resolve </p>
      <ErrorCard v-for="resolve in resolved"  :key="resolve.id"  @resolve-unresolve='unresolveError' :errorId="resolve.index" :errorMessage="resolve.text"  :color="colors.resolvedColor" :hoverColor="colors.resolvedHoverColor" :errorCode="resolve.code"/>
    </div>
    <div class="error-card-container">
      <p class="error-heading"> Unresolved Errors </p>
      <p v-if="resolved.length == 0" class="error-empty">No errors in unresolved </p>
      <ErrorCard v-for="unresolve in unresolved" @resolve-unresolve='resolveError' :key="unresolve.id" :errorId="unresolve.index" :errorMessage="unresolve.text" :color="colors.unresolvedColor" :hoverColor="colors.unresolvedHoverColor" :errorCode="unresolve.code"/>
    </div>
    <div class="error-card-container">
       <p class="error-heading" > Backlog Errors </p>
       <p v-if="resolved.length == 0" class="error-empty">No errors in backlog </p>
      <ErrorCard v-for="backlog in backlogs" @resolve-unresolve='moveBacklog' :key="backlog.id" :errorId="backlog.index" :errorMessage="backlog.text" :color="colors.backlogColor" :hoverColor="colors.backlogHoverColor" :errorCode="backlog.code" />
    </div>
    </div>
  </div>
</template>

<script>

import ErrorCard from '../components/ErrorCard'
import Vue from 'vue'
import Notification from '~/components/Notification.vue';
import Button from '../components/Button'

export default {
  components: { ErrorCard, Notification, Button },
  // async asyncData({ $axios }) {
  //   try {
  //     const { resolved, unresolved, backlog } = await $axios.$get(
  //       "http://localhost:8000/get_lists"
  //     );
  //     console.log({resolved})
  //     return {
  //       resolved,
  //       unresolved,
  //       backlog
  //     };
  //   } catch (error) {
  //     console.log(
  //       `Couldn't get error lists:\n${error}\nDid you start the API?`
  //     );
  //     console.log(
  //       "HINT: You can comment out the full `asyncData` method and work with mocked data for UI/UX development, if you want to."
  //     );
  //   }
  // },
  methods: {

    notificationAction(){
      this.showNotification = !this.showNotification
      setTimeout(()=>{
        this.showNotification = !this.showNotification
      }, 2000)
    },

  
    unresolveError(id){
      let resolvedData = this.resolved.find(data => data.index === id)
      let position = this.resolved.findIndex(data=> data.index === id)
      let resolvedArray = this.resolved.filter(data => data.index !== id)
      let resolvedObject = {...resolvedData, text: "Error ABC occured, that is `unresolved`"}

      let newUnresolved = [...this.unresolved, resolvedObject]
      this.unresolved = newUnresolved
      this.resolved = resolvedArray
      this.undoData = {...resolvedObject, from: 'resolved', position}
      this.notificationAction()
      
     
    },
    resolveError(id){
      let unresolvedData = this.unresolved.find(data => data.index === id)
      let position = this.unresolved.findIndex(data=> data.index === id)
      let unresolvedArray = this.unresolved.filter(data => data.index !== id)
      let unresolvedObject = {...unresolvedData, text: "Error ABC occured, that is `resolved`"}

      let newResolved = [...this.resolved, unresolvedObject]
      this.resolved = newResolved
      this.unresolved = unresolvedArray
      this.undoData = {...unresolvedObject, from: 'unresolved', position}
      this.notificationAction()
    },
    moveBacklog(id){
      let backlogData = this.backlogs.find(data => data.index === id)
      let position = this.backlogs.findIndex(data=> data.index === id)
      let backlogArray = this.backlogs.filter(data => data.index !== id)
      let backlogObject = {...backlogData, text: "Error ABC occured, that is `unresolved`"}

      let newUnresolved = [...this.unresolved, backlogObject]
      this.unresolved = newUnresolved
      this.backlogs = backlogArray
      this.undoData = {...backlogObject, from: 'backlog', position}
      this.notificationAction()
     
    },
   
    undoButtonAction(){
      let undoData = this.undoData
      let errorType = undoData.from
      let errorPosition = undoData.position
      let id = undoData.index
      switch(errorType){
        case 'resolved': 
          let filteredUnresolvedArray = this.unresolved.filter(data => data.index !== id)
          this.unresolved = filteredUnresolvedArray
          delete undoData.from
          delete undoData.position
          this.resolved.splice(errorPosition, 0, undoData)
          console.log(errorPosition)
          this.undoData = {}
          break;
        case 'unresolved':
          let filteredResolvedArray = this.resolved.filter(data => data.index !== id)
          this.resolved = filteredResolvedArray
          delete undoData.from
          delete undoData.position
          this.unresolved.splice(errorPosition, 0, undoData)
          console.log(errorPosition)
          this.undoData = {}
          break;
        case 'backlog':
          //do something
          let filtered = this.unresolved.filter(data => data.index !== id)
          this.uresolved = filtered
          delete undoData.from
          delete undoData.position
          this.backlogs.splice(errorPosition, 0, undoData)
          this.undoData = {}
          break;
        default:
          return
      }
      return
    },
    undoAll(){
    setTimeout(() => { 
      this.resolved = [
         {
          index: 100,
          code: 12, 
          text: 'Error ABC occured, that is `resolved`'
        },
        {
          index: 101,
          code: 11, 
          text: 'Error ABC occured, that is `resolved`'
        }, 
        {
          index: 102,
          code: 45, 
          text: 'Error ABC occured, that is `resolved`'
        }, 
        {
          index: 103,
          code: 43, 
          text: 'Error ABC occured, that is `resolved`'
        }, 
        {
          index: 104,
          code: 5, 
          text: 'Error ABC occured, that is `resolved`'
        },
        {
          index: 105,
          code: 33, 
          text: 'Error ABC occured, that is `resolved`'
        },
        {
          index: 106,
          code: 30, 
          text: 'Error ABC occured, that is `resolved`'
        },
        {
          index: 107,
          code: 29, 
          text: 'Error ABC occured, that is `resolved`'
        },
        {
          index: 108,
          code: 24, 
          text: 'Error ABC occured, that is `resolved`'
        },
        {
          index: 109,
          code: 4, 
          text: 'Error ABC occured, that is `resolved`'
        },
      ]
      this.unresolved = [
          {
          index: 110,
          code: 15, 
          text: 'Error ABC occured, that is `unresolved`'
        },
        {
          index:111,
          code: 66, 
          text: 'Error ABC occured, that is `unresolved`'
        },
        {
          index: 112,
          code: 34, 
          text: 'Error ABC occured, that is `unresolved`'
        },
        {
          index: 113,
          code: 89, 
          text: 'Error ABC occured, that is `unresolved`'
        },
        {
          index: 114,
          code: 77, 
          text: 'Error ABC occured, that is `unresolved`'
        },
        {
          index: 115,
          code: 74, 
          text: 'Error ABC occured, that is `unresolved`'
        },
        {
          index: 116,
          code: 68, 
          text: 'Error ABC occured, that is `unresolved`'
        },
        {
          index: 117,
          code: 47, 
          text: 'Error ABC occured, that is `unresolved`'
        },
         {
          index: 118,
          code: 84, 
          text: 'Error ABC occured, that is `unresolved`'
        }, {
          index: 119,
          code: 59, 
          text: 'Error ABC occured, that is `unresolved`'
        },
      ]
      this.backlogs = [
       {
          index: 120,
          code: 81, 
          text: 'Error ABC occured, that is `backlogged`'
        },
        {
          index: 121,
          code: 11, 
          text: 'Error ABC occured, that is `backlogged`'
        },
        {
          index: 122,
          code: 76, 
          text: 'Error ABC occured, that is `backlogged`'
        },
        {
          index: 123,
          code: 73, 
          text: 'Error ABC occured, that is `backlogged`'
        },
        {
          index: 124,
          code: 72, 
          text: 'Error ABC occured, that is `backlogged`'
        },
        {
          index: 125,
          code: 87, 
          text: 'Error ABC occured, that is `backlogged`'
        },
        {
          index: 126,
          code: 95, 
          text: 'Error ABC occured, that is `backlogged`'
        },
        {
          index: 127,
          code: 99, 
          text: 'Error ABC occured, that is `backlogged`'
        },
        {
          index: 128,
          code: 92, 
          text: 'Error ABC occured, that is `backlogged`'
        },
        {
          index: 129,
          code: 93, 
          text: 'Error ABC occured, that is `backlogged`'
        },
      ]
    }, 500)
  }
  },
  
  created(){
    setTimeout(() => { 
      this.resolved = [
         {
          index: 100,
          code: 12, 
          text: 'Error ABC occured, that is `resolved`'
        },
        {
          index: 101,
          code: 11, 
          text: 'Error ABC occured, that is `resolved`'
        }, 
        {
          index: 102,
          code: 45, 
          text: 'Error ABC occured, that is `resolved`'
        }, 
        {
          index: 103,
          code: 43, 
          text: 'Error ABC occured, that is `resolved`'
        }, 
        {
          index: 104,
          code: 5, 
          text: 'Error ABC occured, that is `resolved`'
        },
        {
          index: 105,
          code: 33, 
          text: 'Error ABC occured, that is `resolved`'
        },
        {
          index: 106,
          code: 30, 
          text: 'Error ABC occured, that is `resolved`'
        },
        {
          index: 107,
          code: 29, 
          text: 'Error ABC occured, that is `resolved`'
        },
        {
          index: 108,
          code: 24, 
          text: 'Error ABC occured, that is `resolved`'
        },
        {
          index: 109,
          code: 4, 
          text: 'Error ABC occured, that is `resolved`'
        },
      ]
      this.unresolved = [
          {
          index: 110,
          code: 15, 
          text: 'Error ABC occured, that is `unresolved`'
        },
        {
          index:111,
          code: 66, 
          text: 'Error ABC occured, that is `unresolved`'
        },
        {
          index: 112,
          code: 34, 
          text: 'Error ABC occured, that is `unresolved`'
        },
        {
          index: 113,
          code: 89, 
          text: 'Error ABC occured, that is `unresolved`'
        },
        {
          index: 114,
          code: 77, 
          text: 'Error ABC occured, that is `unresolved`'
        },
        {
          index: 115,
          code: 74, 
          text: 'Error ABC occured, that is `unresolved`'
        },
        {
          index: 116,
          code: 68, 
          text: 'Error ABC occured, that is `unresolved`'
        },
        {
          index: 117,
          code: 47, 
          text: 'Error ABC occured, that is `unresolved`'
        },
         {
          index: 118,
          code: 84, 
          text: 'Error ABC occured, that is `unresolved`'
        }, {
          index: 119,
          code: 59, 
          text: 'Error ABC occured, that is `unresolved`'
        },
      ]
      this.backlogs = [
       {
          index: 120,
          code: 81, 
          text: 'Error ABC occured, that is `backlogged`'
        },
        {
          index: 121,
          code: 11, 
          text: 'Error ABC occured, that is `backlogged`'
        },
        {
          index: 122,
          code: 76, 
          text: 'Error ABC occured, that is `backlogged`'
        },
        {
          index: 123,
          code: 73, 
          text: 'Error ABC occured, that is `backlogged`'
        },
        {
          index: 124,
          code: 72, 
          text: 'Error ABC occured, that is `backlogged`'
        },
        {
          index: 125,
          code: 87, 
          text: 'Error ABC occured, that is `backlogged`'
        },
        {
          index: 126,
          code: 95, 
          text: 'Error ABC occured, that is `backlogged`'
        },
        {
          index: 127,
          code: 99, 
          text: 'Error ABC occured, that is `backlogged`'
        },
        {
          index: 128,
          code: 92, 
          text: 'Error ABC occured, that is `backlogged`'
        },
        {
          index: 129,
          code: 93, 
          text: 'Error ABC occured, that is `backlogged`'
        },
      ]
    }, 500)
  },
  data() {
    return {
      undoData: {},
      resolved: [],
      unresolved: [],
      backlogs: [],
      colors:{
        resolvedColor: '#C8E417',
        unresolvedColor: '#E49F17',
        backlogColor: '#17BFE4',
        resolvedHoverColor: '#93D93B',
        unresolvedHoverColor: '#A57312',
        backlogHoverColor: '#1390AB',
        hoverEnterColor: '#CCCCCC',
        hoverLeaveColor: '#E06AF3',
        
      },
      showNotification: false,
      showHoverButtonColor: false
    };
  },
};
</script>
<style scoped>
.error-card-container{
  background: #eee;
  padding: 10px;
  margin: 1.5rem;
  height: 20rem;
  overflow: scroll;
}
.error-heading{
    font-size: 15px;
    font-family: Arial, Helvetica, sans-serif;
    font-weight: bold;
    text-align: center;
    padding: 1rem;
}

.error-empty{
  text-align: center;
  font-size:15px;
  color: red;
}
.container{
  margin: 8% auto;
  display: flex;
  flex-direction: row; 
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;
}
.btn-container{
    text-align: center;
    padding: 1rem;
    margin-top: 2rem;
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;

}
.btn{
  background: slateblue;
  color: #fff;
  padding: .5rem .7rem;
  border-radius: 10px;
  margin: 0 2rem
}

</style>
