$(function(){
function appendOption(category) {
  let html = 
    `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
  return html;
}
function appendChildrenBox(insertHTML) {
  let childSelectHtml = '';
  childSelectHtml = 
                    `<select class="tournament_select_child" id="children_category">
                      <option value="" data-category="" >選択してください</option>
                      ${insertHTML}</select>`
                    $(".school").append(childSelectHtml)
  }

  $("#parent_category").on("change",function(){
    let parentCategory = $("#parent_category").val();
    if(parentCategory !=""){
      $.ajax({
        type: 'GET',
        url: '/tweets/new',
        data: {tournament_id: parentCategory},
        dataType: 'json'
      })
      .done(function(children){
        $(".tournament_select_child").empty();
        let insertHTML = '';
        children.forEach(function(child) {
        insertHTML += appendOption(child);
      });
      appendChildrenBox(insertHTML);
    })

      .fail(function() {
        alert('error：子カテゴリーの取得に失敗');
      })
    }
  });
});