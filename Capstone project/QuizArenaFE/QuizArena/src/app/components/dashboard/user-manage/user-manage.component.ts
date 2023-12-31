import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { Page } from 'src/app/models/page.model';
import { DashboardService } from 'src/app/services/dashboard.service';
import { JwtService } from 'src/app/services/jwt.service';
import { UserDataService } from 'src/app/services/user-data.service';
import { faPencil, faPaperPlane } from '@fortawesome/free-solid-svg-icons';
import { User } from 'src/app/models/user.model';
import { FeatureCommonService } from 'src/app/services/feature-common.service';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';

@Component({
  selector: 'app-user-manage',
  templateUrl: './user-manage.component.html',
  styleUrls: ['./user-manage.component.scss']
})
export class UserManageComponent {

  isLoading: boolean = true; // Ban đầu, hiển thị khối div lúc đang load
  isLoggedIn = false;
  listAllUsers: any
  selectedFilter: number = 0;
  searchText: string = "";
  selectedUser!: User;
  listRecentActivity: any
  listInfrequentActivity: any
  user?: User; // biến lưu thông tin user
  searchTextInfrequent: any
  displaySendMailCustom: boolean = false
  displayDialog: boolean = false;
  emailSubject: string = ""
  emailContent: string = ""
  email: string = ""
  resultSend: boolean = false
  showResultReset: boolean = false;
  showResult: boolean = false; // biến hiển thị kết quả add
  resultAdd: boolean = false;
  loading: boolean = true;
  faPencil = faPencil
  faPaperPlane = faPaperPlane
  currentContent: number = 0;
  constructor(private dashboardService: DashboardService, private userDataService: UserDataService, private commonServiece: FeatureCommonService,
    private firebase: FirebaseImageService) { }

  async ngOnInit() {

    await this.userDataService.userCurr.subscribe(user => {
      if (user.userId) {
        this.user = user;
        this.dashboardService.getAllUsesrList("", 1, 1000).subscribe(
          (res: any) => {
            this.setupUserInChallenge(res);
            this.loading = false;
            if (res) {
              this.dashboardService.getUsersRecentActivity("", 1, 1000).subscribe(res => {
                this.listRecentActivity = res
                this.loading = false;
                if (res) {
                  this.dashboardService.getUsersInfrequentActivity("", 1, 1000).subscribe(res => {
                    this.listInfrequentActivity = res
                    this.isLoading = false;
                    this.loading = false;
                  })
                }
              })
            }
          },
          (error: any) => {
            console.error('Error:', error);
            this.isLoading = false;
          }
        );
      }
    });

  }


  /*
  * Hàm setup các thông tin cho user
  */
  private async setupUserInChallenge(users: User[]) {
    if (users) {
      const promises = users.map(async (slide) => {
        if (slide.images) {
          try {
            const url = await this.firebase.getImageUrl(slide.images).toPromise();
            slide.images = url;
          } catch (error) {
            console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
          }
        } else {
          slide.images = '';
        }
        return slide;
      });

      try {
        const list = await Promise.all(promises);
        this.listAllUsers = list;
      } catch (error) {
        console.error('Lỗi khi xử lý setup user challenge:', error);
      }
    }
  }

  mailCustomeButton(email: string) {
    this.displaySendMailCustom = true
    this.email = email
  }

  resetSession() {
    if (this.user?.role == 1) {
      this.commonServiece.resetSession().subscribe(
        (res: any) => {
          if (res.status) {
            this.showResultReset = true;
          }
        },
        (error: any) => {
          console.error('Lỗi khi call api reset:', error);
        }
      );
    }
  }

  showDialogReset() {
    this.displayDialog = true;
  }

  onSearch() {
    this.dashboardService.getAllUsesrList(this.searchText, 1, 10).subscribe(
      (res: any) => {
        this.listAllUsers = res
      },
      (error: any) => {
        console.error('Error:', error);
        this.isLoading = false;
      }
    );
  }


  // gửi mail cho tất cả các user thường xuyên hoạt động
  sendActivityReminderEmail() {
    this.showResult = true;
    this.resultAdd = true;
    this.dashboardService.sendActivityReminderEmail().subscribe(res => {
    })
  }
  // gửi mail cho tất cả các user ít hoạt động
  sendInActivityReminderEmail() {
    this.showResult = true;
    this.resultAdd = true;
    this.dashboardService.sendInActivityReminderEmail().subscribe(res => {
    })
  }


  onMenuItemClick(index: number) {
    this.currentContent = index;
  }

  openQuizModal(item: any) {
    this.selectedUser = item;
  }

  updateUser(id: number, exp: number, roleId: number) {
    this.dashboardService.updateUser(id, exp, roleId).subscribe(res => {
      this.dashboardService.getAllUsesrList("", 1, 1000).subscribe(
        (res: any) => {
          this.listAllUsers = res
        },
        (error: any) => {
          console.error('Error:', error);
          this.isLoading = false;
        }
      );
    })
  }

  // gửi mail cho 1 cá nhân
  sendUserMail() {
    this.showResult = true
    this.resultSend = true
    this.displaySendMailCustom = false
    this.emailSubject = ""
    this.emailContent = ""
    this.dashboardService.sendCustomEmail(this.email, this.emailSubject, this.emailContent).subscribe(res => {
    })
  }

  cancelSendMail() {
    this.displaySendMailCustom = false
  }

}
