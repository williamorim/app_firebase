login = function() {
  var email = document.getElementById("email").value;
  var password = document.getElementById("password").value;
  firebase.auth().signInWithEmailAndPassword(email, password)
    .then(function(user){
      alert("Logado com sucesso");
      auth = user;
    }).catch(function(error){
      alert("Falha ao logar");
    });
}
