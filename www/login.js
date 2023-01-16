login = function() {
  var email = document.getElementById("email").value;
  var password = document.getElementById("password").value;
  firebase.auth().signInWithEmailAndPassword(email, password)
    .then(function(user){
      location.replace("http://127.0.0.1:4242/?t=true")
      auth = user;
    }).catch(function(error){
      alert("Falha ao logar");
    });
}
