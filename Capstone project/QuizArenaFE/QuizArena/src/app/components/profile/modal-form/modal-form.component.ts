import { Component } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { AccountService } from 'src/app/services/account.service';

@Component({
  selector: 'app-modal-form',
  templateUrl: './modal-form.component.html',
  styleUrls: ['./modal-form.component.scss']
})
export class ModalFormComponent {
  passForm: FormGroup;
  messNewPass?: string;
  messConfirmPass?: string;
  mess?: string;
  messSucc?: string;

  constructor(private formBuilder: FormBuilder, private accService: AccountService, private router: Router) {
    this.passForm = this.formBuilder.group({
      oldPass: [''],
      newPass: [''],
      confirmPass: ['']
    });
  }

  checkValid() {
    const password = this.passForm.get('newPass')?.value;
    const confirmPassword = this.passForm.get('confirmPass')?.value;
    const oldPassword = this.passForm.get('oldPass')?.value;

    if (this.messNewPass == '' && this.messConfirmPass == '' && password && confirmPassword && oldPassword) {
      this.accService.changePass(oldPassword, password).subscribe(
        (response: any) => {
          this.mess = '';
          this.messSucc = 'Change password success.';
          setTimeout(() => {
            window.location.reload();
          }, 2000);
        },
        (error) => {
          if (!error.error.status) {
            this.messSucc = '';
            this.mess = error.error.message;
            return;
          }
        }
      );
    } else {

    }
  }

  checkPassword() {
    //ktra username trống
    const password = this.passForm.get('newPass')?.value;
    this.checkConfirmPassword();
    const regexPass = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$/;
    if (password) {
      if (password.length <= 6) {
        this.messNewPass = 'Password must be at least 6 characters long.';
        return;
      }
      //Mật khẩu phải chứa ít nhất một chữ cái viết hoa và một chữ số
      if (!regexPass.test(password)) {
        this.messNewPass = 'Password must contain at least one capital letter and one number.';
        return;
      }
    }
  }

  checkConfirmPassword() {
    //ktra username trống
    const confirmPassword = this.passForm.get('confirmPass')?.value;
    const password = this.passForm.get('newPass')?.value;
    if (password && confirmPassword) {
      if (password === confirmPassword) {
        this.messConfirmPass = '';
      } else {
        this.messConfirmPass = 'Not match new password.';
        return;
      }
    }
  }

  clearMessConfirmPassword() {
    this.messConfirmPass = '';
  }

  clearMessPassword() {
    this.messNewPass = '';
  }
}
