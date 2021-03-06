$(document).on('turbolinks:load', (function(){
function appendOption(category) {
  let html = 
    `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
  return html;
}
function appendChildrenBox(insertHTML) {
  let childSelectHtml = '';
  childSelectHtml = 
                    `<p>高校A</p>
                    <select name="tweet[school_a_id]" class="tournament_select_child" id="children_category">
                      <option value="" data-category="" >学校を選択してください</option>
                      ${insertHTML}</select>`
                    $(".school").append(childSelectHtml)
  childSelectHtml2 = 
                    `<br><p>高校B</p>
                    <select name="tweet[school_b_id]" class="tournament_select_child" id="children_category">
                      <option value="" data-category="" >学校を選択してください</option>
                      ${insertHTML}</select>`
                    $(".school2").append(childSelectHtml2)
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
        $(".school").empty();
        $(".school2").empty();
        let insertHTML = '';
        children.forEach(function(child) {
        insertHTML += appendOption(child);
      });
      appendChildrenBox(insertHTML);
    })

      .fail(function() {
        alert('error：取得に失敗');
      })
    }
  });
}));