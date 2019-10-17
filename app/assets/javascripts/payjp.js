$(function(){

  var submit = document.getElementById("token_submit");

  submit.addEventListener('click', function(e){
    e.preventDefault();
    Payjp.setPublicKey("pk_test_50682211a79cb20179a84c3c");
    var card = {
      number: document.getElementById("card_number").value,
      exp_month: document.getElementById("exp_month").value,
      exp_year: document.getElementById("exp_year").value,
      cvc: document.getElementById("cvc").value
    };
    if (document.URL.match("/signup/payment")) {
      if (card.number == "", card.exp_month == "1", card.exp_year == "2019", card.cvc == "") {
        $('#charge-form').attr({
          'action':'/users',
          'method':'post'
        });
        $('#charge-form').submit();
      } else {
        Payjp.createToken(card, function(status, response) {
          if (status === 200) {
            $("#card_number").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name"); 
            $("#cvc").removeAttr("name");
            $("#card_token").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
            ); 
            document.inputForm.submit();
            alert("登録が完了しました");
          } else {
            alert("正しいカード情報を入力してください。");
          }
        });
      }
    } else {
      Payjp.createToken(card, function(status, response) {
        if (status === 200) {
          $("#card_number").removeAttr("name");
          $("#exp_month").removeAttr("name");
          $("#exp_year").removeAttr("name"); 
          $("#cvc").removeAttr("name");
          $("#card_token").append(
            $('<input type="hidden" name="payjp-token">').val(response.id)
          ); 
          document.inputForm.submit();
          alert("登録が完了しました");
        } else {
          alert("正しいカード情報を入力してください。");
        }
      });
    }
    false
  });
});
