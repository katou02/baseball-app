$(document).on('turbolinks:load', (function(){
  function appendOption(category) {
    let html = 
      `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendChildrenBox(insertHTML) {
    let childSelectHtml = '';
    childSelectHtml = 
                     `<p>高校</p>
                      <select name= "champion[champion_school_id]" class="tournament_select_child" id="children_category">
                        <option value="" data-category="" >学校を選択してください</option>
                        ${insertHTML}</select>`
                      $(".champion-school").append(childSelectHtml)
  }

  $("#parent_category_champion").on("change",function(){
    let parentCategory = $("#parent_category_champion").val();
    if(parentCategory !=""){
      $.ajax({
        type: "GET",
        url: "/champions/new",
        data: {tournament_id: parentCategory},
        dataType: "json"
      })
      .done(function(children){
        $(".champion-school").empty();
        let insertHTML = "";
        children.forEach(function(child){
        insertHTML += appendOption(child);
        });
        appendChildrenBox(insertHTML);
      })
      .fail(function(){
        alert("error: 取得に失敗");
      })
    }
  });
}));