window.onload=function(){
  new Vue({
    el: '#app',
    data: {
      current_slide: 0,
      slides: [
        {img: "/images/81573810.jpeg"},
        {img: "/images/ball.jpg"},
        {img: "/images/thumb_ground.jpg"},
        {img: "/images/thumb_front.jpg"},
        {img: "/images/mykosien.JPG"}
      ],
    },
    mounted() {
      setInterval(() => {
        this.current_slide = this.current_slide < this.slides.length -1 ? this.current_slide +1 : 0
      }, 3000)
    }
  })
};