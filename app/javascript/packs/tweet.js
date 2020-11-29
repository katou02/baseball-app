window.onload=function(){
  new Vue({
    el: '#app',
    data: {
      current_slide: 0,
      slides: [
        {img: "/assets/81573810.jpeg"},
        {img: "/assets/ball.jpg"}
      ],
    },
    mounted() {
      setInterval(() => {
        this.current_slide = this.current_slide < this.slides.length -1 ? this.current_slide +1 : 0
      }, 5000)
    }
  })
}