class UsersService {
  constructor($http) {
    this.$http = $http;
  }

  login(email, password) {
    return this.$http.post("http://localhost:5000/api/v1/auth/sign_in", {
      email: email,
      password: password
    });
  }

  signUp(email, password) {
    return this.$http.post("http://localhost:5000/api/v1/auth", {
      email: email,
      password: password
    });
  }
}
  
UsersService.$inject = ['$http'];

export default UsersService;
