import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AccountService } from 'src/app/services/account.service';
import { UserDataService } from 'src/app/services/user-data.service';
import { faUser, faEnvelope, faLock } from '@fortawesome/free-solid-svg-icons';



@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})

export class LoginComponent {
  isLoginForm = true;
  loginForm: FormGroup;
  signupForm: FormGroup;
  forgotForm: FormGroup;
  formloginSubmitted = false;
  formsignupSubmitted = false;
  resetPassSuccess = false; // biến để hiển thị khi reset pass thành công
  errorMess: string = '';

  messUsername?: string;
  messFullname?: string;
  messEmail?: string;
  messEmailForgot?: string;
  messPassword?: string;


  //icon
  faUser = faUser;
  faEnvelope = faEnvelope;
  faLock = faLock;

  constructor(private formBuilder: FormBuilder, private accService: AccountService, private userDataService: UserDataService, private router: Router) {
    this.loginForm = this.formBuilder.group({
      username: ['', [Validators.required]],
      password: ['', Validators.required]
    });

    this.signupForm = this.formBuilder.group({
      username: [''],
      fullname: [''],
      email: [''],
      password: ['']
    });

    this.forgotForm = this.formBuilder.group({
      email: ['']
    });

    //code khi nhấn login sẽ trở về form login
    this.userDataService.loginForm$.subscribe(loginForm => {
      this.isLoginForm = loginForm;
    });
  }


  login(): void {
    this.formloginSubmitted = true;
    if (this.loginForm.invalid) {
      return;
    }
    const username = this.loginForm.get('username')?.value;
    const password = this.loginForm.get('password')?.value;
    const currentURL = this.router.url;
    this.accService.login(username, password).subscribe(
      (response: any) => {
        if (response.status) {
          this.accService.saveToken(response.result) //save token to session
          this.accService.logHistory().subscribe(
            (response) => {
              if (response.status) {  //log lịch sử thành công
                if (currentURL === '/home') {// ktra nếu là login ở home thì load lại
                  window.location.reload();
                } else {
                  if (currentURL === '/login') {
                    this.router.navigate(['/home']); // nếu login ở page login thì chuyển tới home
                  } else {
                    window.location.reload();
                  }
                }
              }
            },
            (error) => {
              console.error('Lỗi khi log lịch sử login:', error);
            }
          );


          // if (currentURL === '/home') {// ktra nếu là login ở home thì load lại
          //   window.location.reload();
          // } else {
          //   if (currentURL === '/login') {
          //     this.router.navigate(['/home']); // nếu login ở page login thì chuyển tới home
          //   } else {
          //     window.location.reload();
          //   }
          // }


        } else {
          this.errorMess = 'Invalid email or password. Please try again.';
        }
      },
      (error) => {
        console.error('Login failed:', error);
        this.errorMess = 'Wrong something about server. Please try again.';
      }
    );
  }




  signup(): void {

    const username = this.signupForm.get('username')?.value;
    const password = this.signupForm.get('password')?.value;
    const fullname = this.signupForm.get('fullname')?.value;
    const email = this.signupForm.get('email')?.value;
    const currentURL = this.router.url;
    this.accService.signup(fullname, email, username, password).subscribe(
      (response: any) => {
        //dk thành công
        if (response.status && this.formsignupSubmitted) {
          this.accService.login(username, password).subscribe(
            (response: any) => {
              if (response.status) {
                console.log(response);
                this.accService.saveToken(response.result) //save token to session


                if (currentURL === '/home') {// ktra nếu là login ở home thì load lại
                  window.location.reload();
                } else {
                  this.router.navigate(['/home']); // nếu login ở page login thì chuyển tới home
                }

              } else {
                this.errorMess = 'Invalid email or password. Please try again.';
              }
            },
            (error) => {
              console.error('Login failed:', error);
              this.errorMess = 'Wrong something about server. Please try again.';
            }
          );
        }

      },
      (error) => {
        if (!error.error.status) {
          this.messUsername = 'Username existed';
        }
      }
    );
  }


  forgot(): void {
    const email = this.forgotForm.get('email')?.value;
    const regexEmail = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    if (email) {
      if (!regexEmail.test(email)) {
        this.messEmailForgot = 'Invalid email format';
        this.checkInpuEmpty();
        return;
      }

      this.accService.forgot(email).subscribe(
        (response: any) => {
          this.resetPassSuccess = true;
        },
        (error) => {
          if (!error.error.status)
            this.messEmailForgot = error.error.message;
          return;
        }
      );
    } else {
      this.messEmailForgot = 'Email not empty.';
      return;
    }

  }

  changeForm(): void {
    this.isLoginForm = false;
    this.resetPassSuccess = false;
    this.messEmailForgot = '';
  }

  changeFormBack(): void {
    this.userDataService.setloginForm(true);
  }

  checkUsername() {
    //ktra username trống
    const username = this.signupForm.get('username')?.value;
    const password = this.signupForm.get('password')?.value;
    const fullname = this.signupForm.get('fullname')?.value;
    const email = this.signupForm.get('email')?.value;
    if (username) {
      //ktra các validate username
      if (username.length <= 6) {
        this.messUsername = 'Username must be at least 6 characters long.';
        this.checkInpuEmpty();
        return;
      }
    }
    this.checkInpuEmpty();
  }

  clearMessUsername() {
    this.messUsername = '';
  }

  clearMessEmail() {
    this.messEmail = '';
  }

  clearMessPassword() {
    this.messPassword = '';
  }

  checkFullname() {
    this.checkInpuEmpty();
  }

  checkEmail() {
    //ktra username trống
    const email = this.signupForm.get('email')?.value;
    const regexEmail = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    if (email) {
      if (!regexEmail.test(email)) {
        this.messEmail = 'Invalid email format';
        this.checkInpuEmpty();
        return;
      }
      //check email call api
      this.accService.signup('', email, '', '').subscribe(
        (response: any) => {

        },
        (error) => {
          if (error.error.errors.email)  // nếu có lỗi username trả về
            this.messEmail = error.error.errors.email[0]; // gán cho messUsername và hiển thị ra
          this.checkInpuEmpty();
          return;
        }
      );
    }
    this.checkInpuEmpty();
  }

  checkPassword() {
    //ktra username trống
    const password = this.signupForm.get('password')?.value;
    const regexPass = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$/;
    if (password) {
      if (password.length <= 6) {
        this.messPassword = 'Password must be at least 6 characters long.';
        this.checkInpuEmpty();
        return;
      }
      //Mật khẩu phải chứa ít nhất một chữ cái viết hoa và một chữ số
      if (!regexPass.test(password)) {
        this.messPassword = 'Password must contain at least one uppercase letter, one lowercase letter, and one number.';
        this.checkInpuEmpty();
        return;
      }
      //check pass call api
      this.accService.signup('', '', '', password).subscribe(
        (response: any) => {

        },
        (error) => {
          if (error.error.errors.password)
            this.messPassword = error.error.errors.password[0];
          this.checkInpuEmpty();
          return;
        }
      );
    }
    this.checkInpuEmpty();
  }

  private checkInpuEmpty() {
    const username = this.signupForm.get('username')?.value;
    const password = this.signupForm.get('password')?.value;
    const fullname = this.signupForm.get('fullname')?.value;
    const email = this.signupForm.get('email')?.value;
    if (username && password && fullname && email && !this.messEmail && !this.messFullname &&
      !this.messPassword && !this.messUsername) { // nếu các input không bị trống và ko bị lỗi validate thì bật nút submit
      this.formsignupSubmitted = true;
    } else {
      this.formsignupSubmitted = false;
    }
  }



}
