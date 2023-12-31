import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user.model';
import { FeatureCommonService } from 'src/app/services/feature-common.service';
import { UserDataService } from 'src/app/services/user-data.service';

@Component({
  selector: 'app-select-payment',
  templateUrl: './select-payment.component.html',
  styleUrls: ['./select-payment.component.scss']
})
export class SelectPaymentComponent implements OnInit {
  selectedType: string = ''; // Default selected type
  fullname: string = ''; // biến lưu fullname
  phone: string = ''; // biến lưu fullname
  email: string = ''; // biến lưu fullname
  messError?: string; // biến lưu mess lỗi
  userData?: User; // biến lưu thông tin user

  constructor(private commonService: FeatureCommonService, private userDataService: UserDataService, private router: Router) { }

  async ngOnInit(): Promise<void> {
    await this.userDataService.userCurr.subscribe(user => {
      if (user.userId) {
        this.userData = user;
        this.email = user.email;
        this.fullname = user.fullname;
      }
    });

  }

  selectPaymentType(type: string): void {
    this.selectedType = type;
  }

  async requestPayment(): Promise<void> {
    console.log(this.fullname + ` - ` + this.phone + ` - ` + this.email);
    if (this.fullname.length > 0 && this.phone.length > 9 && this.email.length > 0) {
      this.messError = '';
      await this.commonService.payment(this.fullname, 242300).subscribe(
        (response: any) => {
          if (response.status) {
            window.location.href = response.result.payUrl;
          } else {
            this.messError = 'Payment system error something, try again.';
          }
        },
        (error) => {
          this.messError = 'Payment system error something, try again.';
          console.error('Gửi yêu cầu thanh toán thất bại:', error);
        }
      );
    } else {
      this.messError = 'Please enter all your infomation.';
    }

  }
}
