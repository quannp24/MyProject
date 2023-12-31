import { Component } from '@angular/core';
import { AccountService } from 'src/app/services/account.service';

@Component({
  selector: 'app-forgotpassword',
  templateUrl: './forgotpassword.component.html',
  styleUrls: ['./forgotpassword.component.scss']
})
export class ForgotpasswordComponent {
  inputLogin: any = {
    username: '',
    password:''
  };
  error: string = '';
  constructor(private accService: AccountService) {}

  login(): void {
    this.accService.login(this.inputLogin.username, this.inputLogin.password).subscribe(
      (response: any) => {
        console.log(response);
        this.error = 'Đăng nhập thành công.\n'+response.accId+"\n"+response.token+'\n'+response.username;

      },
      (error) => {
        console.error('Login failed:', error);
        this.error = 'Đăng nhập thất bại. Vui lòng kiểm tra thông tin đăng nhập và thử lại.';
      }
    );
  }

}
