class LoginController {
  constructor(UsersService) {
    this.name = 'login';
    this.UsersService = UsersService;
  }

  submit() {
    console.log("OK");
    this.UsersService.login(this.email, this.password).then(() => {
      this.name = "hooray";
    });
  }
}

LoginController.$inject = ['UsersService'];

export default LoginController;
