$(document).on('turbolinks:load', (function(){
  function appendOption(category) {
    let html =
      `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendChildrenBox(insertHTML) {
    let childSelectHtml = "";
    childSelectHtml =  
                     `<p>勝利予想</p>
                      <select name="forecast[win_school_id]" class="tournament_select_child" id="children_category">
                      <option value="" data-category="" >勝つと思う学校を選択してください</option>
                      ${insertHTML}</select>`
                      $(".win-school").append(childSelectHtml)
    childSelectHtml2 = 
                      `<p>敗退予想</p>
                       <select name="forecast[lose_school_id]" class="tournament_select_child" id="children_category">
                       <option value="" data-category="" >負けると思う学校を選択してください</option>
                       ${insertHTML}</select>`
                       $(".lose-school").append(childSelectHtml2)
    }

  $("#parent_category_forecast").on("change",function(){
    let parentCategory = $("#parent_category_forecast").val();
    if(parentCategory !=""){
      $.ajax({
        type: "GET",
        url: "/forecasts/new",
        data: {tournament_id: parentCategory},
        dataType: "json"
      })
      .done(function(children){
        $(".win-school").empty();
        $(".lose-school").empty();
        let insertHTML = "";
        children.forEach(function(child){
        insertHTML += appendOption(child);
        });
        appendChildrenBox(insertHTML);
      })
      .fail(function(){
        alert("error: 取得に失敗")
      })
    }
  });
}));