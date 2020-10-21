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
                    `<p>高校B</p>
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
  
  // 編集機能
  
  
//   function appendOption(category){
//     let html = '<option value="${category.id}" data_category="${category.id}">${category.name}</option>'
//     return html;
//   }
  
//   function appendChild(insertHTML){
//     let childSelectHTML = '';
//     childSelectHTML =`<div class="select-school>
//     <select class="tournament_select_edit_child" id="children_category_edit" name="tweet[:category_id]">
//     <option value="---" data-category="---">---</option>
//     ${insertHTML}
//     </select>
//     </div>`;
//     $(".select").append(childSelectHtml)
//     let childSelectHTML2 = '';
//     childSelectHtml2 = `<div class="select-school2>
//     <select class="tournament_select_edit2_child" id="children_category_edit2" name="tweet[:category_id]">
//     <option value="---" data-category="---">---</option>
//     ${insertHTML}
//     </select>
//     </div>`;
//     $(".select").append(childSelectHtml2)
//   }
  
//   $('#parent_category_edit').on('change',function(){
//     let editId = $(this).data('update-id')
//     let parentCategoryEdit = $("#parent_category_edit").val();
//     if(parentCategoryEdit != '選択してください'){
//       $.ajax({
//         url: 'tweets//edit',
//         type: 'GET',
//         data: {tournament_id: parentCategoryEdit},
//         dataType: 'json'
//       })
//       .done(function(children){
//         $(".school_edit").empty();
//         $(".school2_edit").empty();
//         let insertHTML = '';
//         children.forEach(function(child){
//           insertHTML += appendOption(child);
//         });
//         appendChild(insertHTML);
//       })
//       .fail(function(){
//         alert("カテゴリー取得に失敗しました")
//       })
//     }else{
//       $('#parent_category_edit').remove();
//     }
//   });