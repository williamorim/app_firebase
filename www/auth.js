// 1) Create a new firebaseui.auth instance stored to our local variable ui
const ui = new firebaseui.auth.AuthUI(firebase.auth())

// 2) These are our configurations.
const uiConfig = {
  callbacks: {
    signInSuccessWithAuthResult(authResult, redirectUrl) {
      return true
    },
    uiShown() {
      document.getElementById("loader").style.display = "none";
    },
  },
  signInFlow: "redirect",
  signInSuccessUrl: "http://127.0.0.1:4242/?t=true",
  signInOptions: [
    firebase.auth.EmailAuthProvider.PROVIDER_ID,
    // Additional login options should be listed here
    // once they are enabled within the console.
  ],
}

// 3) Call the 'start' method on our ui class
// including our configuration options.
ui.start("#firebaseui-auth-container", uiConfig)

logout = function() {
  firebase.auth().signOut().then(function() {
    console.log('Signed Out');
  }, function(error) {
    console.error('Sign Out Error', error);
  });
}
