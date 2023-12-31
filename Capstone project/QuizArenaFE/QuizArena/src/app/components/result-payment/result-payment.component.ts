import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { DashboardService } from 'src/app/services/dashboard.service';
import { FeatureCommonService } from 'src/app/services/feature-common.service';
import { UserDataService } from 'src/app/services/user-data.service';

@Component({
  selector: 'app-result-payment',
  templateUrl: './result-payment.component.html',
  styleUrls: ['./result-payment.component.scss']
})
export class ResultPaymentComponent implements OnInit {
  resultPayment: boolean = false; // biến kết quả payment
  messFaild?: string; // biến hiển thị lỗi thanh toán
  paymentId?: string; // biến id
  amount: number = 10; // biến amount
  method: string = 'MoMo'; // biến method payment
  result: { amount?: number, orderInfo?: string, orderId?: string, errorCode?: number, orderType?: string, message?: string, localMessage?: string } = {}; // biến lưu trữ dữ liệu result


  constructor(private route: ActivatedRoute, private dashboardService: DashboardService, private userDataService: UserDataService, private commonServive: FeatureCommonService) {
    this.route.queryParams.subscribe(params => {
      this.result.amount = params['amount'];
      this.result.orderInfo = params['orderInfo'];
      this.result.orderId = params['orderId'];
      this.result.errorCode = params['errorCode'];
      this.result.orderType = params['orderType'];
      this.result.message = params['message'];
      this.result.localMessage = params['localMessage'];

      console.log(this.result);
    });


  }

  ngOnInit() {
    this.paymentId = this.result.orderId;
    if (this.result.errorCode == 0) {
      this.resultPayment = true;
      this.userDataService.userCurr.subscribe(user => {
        if (user.userId) {
          this.saveInforPayment(user.userId);
        }
      });
    } else {
      this.resultPayment = false;
    }
  }

  private async updateRole(userId: number) {
    if (userId) {
      this.dashboardService.updateUser(userId, undefined, 5).subscribe(
        (res: any) => {
          localStorage.removeItem('authToken');
        },
        (error: any) => {
          console.error('Lỗi khi update role user:', error);
        }
      );
    }
  }

  private async saveInforPayment(userId: number) {
    if (this.amount) {
      this.commonServive.addPaymentInfo("Momo", this.amount).subscribe(
        (res: any) => {
          this.updateRole(userId);
        },
        (error: any) => {
          console.error('Lỗi khi lưu thông tin thanh toán:', error);
        }
      );
    }
  }

}
