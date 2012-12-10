// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function(){
  $('a[rel=tooltip]').tooltip();
});

// プレビュー取得
function message_preview(){
  // 全コメント取得
  $.post(
    // 送信先
    "/messages/preview",
    // 送信データ
    { 'sentence': $("#message_sentence").val() },
    // コールバック
    function(data, status) {
      $('#message_preview').html(data);
    },
    // 応答データ形式
    "html"
  );
};
