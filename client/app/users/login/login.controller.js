class LoginController {
  constructor($auth, $http) {
    this.$auth = $auth;
    this.$http = $http;
  }

  submit() {
    this.$auth.submitLogin({
        email: this.email,
        password: this.password}
    ).then(() => {
      console.log("u win");
      this.$http.get(this.$auth.apiUrl() + "/references");
    });
  }
}

LoginController.$inject = ['$auth', '$http'];

export default LoginController;
