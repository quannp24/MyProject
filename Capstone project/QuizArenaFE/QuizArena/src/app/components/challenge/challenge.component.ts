import { Component, OnInit } from '@angular/core';
import { async } from '@angular/core/testing';
import { Router } from '@angular/router';
import { faMagnifyingGlass, faHourglassStart } from '@fortawesome/free-solid-svg-icons';
import { ChallengeData } from 'src/app/models/challenge-data.model';
import { User } from 'src/app/models/user.model';
import { ChallengeService } from 'src/app/services/challenge.service';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';
import { UserDataService } from 'src/app/services/user-data.service';
import { slideInFromBottom } from 'src/assets/animations/animation-quiz';

@Component({
  selector: 'app-challenge',
  templateUrl: './challenge.component.html',
  styleUrls: ['./challenge.component.scss'],
  animations: [slideInFromBottom]
})
export class ChallengeComponent {
  options: string[] = ['2023', '2022', '2021', '2020', '2019'];
  selectedOption: string = 'Select year';
  isDropdownOpen: boolean = false;
  isShowAchievements = true; // biến hiển thị achievements

  achievements: { date?: Date, examName?: string, image?: string, score?: number, topUser?: number } = {}; // biến lưu trữ dữ liệu achievements
  challengeComing: { date?: Date, examName?: string, description?: string, examId?: string, status?: number } = {}; // biến lưu trữ dữ liệu achievements
  top3User: { fullname?: string, images?: string, score?: number, user_id?: number }[] = []; // biến lưu trữ dữ liệu top 3 user
  listChallenge: {
    countQuestion?: number, date?: Date, description?: string, // biến lưu trữ dữ liệu danh sách challenge
    examId?: number, examName?: string,
    exam_type?: number, image?: string, numberUserJoin?: number, status?: number, time_limit?: number
  }[] = [];

  countdown?: number; // biến đếm ngược challenge tới
  displayTime?: string; // biến hiển thị thời gian đếm ngược
  showBtnJoin: boolean = false; // biến hiển thị nút tham gia challenge
  showError: boolean = false; // biến show thông báo error
  messError?: string; // biến hiển thị tbao error
  userOutChallenge: boolean = false;// biến trạng thái người dùng có phải bị out khi đang thi không
  user?: User; // biến lưu thông tin user

  //icon
  faMagnifyingGlass = faMagnifyingGlass;
  faHourglassStart = faHourglassStart;

  constructor(private challengeService: ChallengeService, private userDataService: UserDataService, private fireBase: FirebaseImageService,
    private directRoute: Router) { }

  async ngOnInit(): Promise<void> {
    const token = localStorage.getItem('authToken');

    await this.userDataService.userCurr.subscribe(async user => {
      if (user.userId) {
        this.user = user;
        this.setupPage();
      } else {
        if (!token)
          this.setupPage();
      }
    });
  }

  /*
  * Hàm lấy thông tin cho trang
  */
  private async setupPage(): Promise<void> {
    await this.challengeService.getInforChallengePage().subscribe(
      (response) => {
        if (response.status) {
          if (response.result.examToWeek) {
            this.setChallengeComing(response.result.examToWeek);
          }

          if (!response.result.examInfoUser) {
            this.isShowAchievements = false;
          } else {
            this.setAchievements(response.result.examInfoUser);
          }

          if (response.result.examTop3User && response.result.examTop3User.length > 0) {
            console.log(response.result.examTop3User)
            this.setTop3User(response.result.examTop3User);
          }

          if (response.result.examListTop && response.result.examListTop.length > 0) {
            this.setListChallenge(response.result.examListTop);
          }

          if (response.result.userCanJoin) {
            this.userOutChallenge = response.result.userCanJoin;
          }

        }
      },
      (error) => {
        console.error('Lỗi khi lấy thông tin trang:', error);
      }
    );
  }

  joinChallenge(examId: string) { // call api thêm mới user vào bảng userExam, thêm thành công mới chuyển sang lobby
    if (examId) {
      if (this.user && this.user?.exp > 999) {
        this.challengeService.addUserExam(examId).subscribe(
          (response) => {
            if (response.status) {
              this.directRoute.navigate(['/lobby-challenge/' + examId]);
            } else {
              this.messError = "Faild something, try again!";
              this.showError = true;
              setTimeout(() => {
                this.showError = false;
              }, 5000);
            }
          },
          (error) => {
            this.messError = "Faild something, try again!";
            this.showError = true;
            setTimeout(() => {
              this.showError = false;
            }, 5000);
            console.error('Lỗi khi thêm người vào room exam:', error);
          }
        );
      } else {
        this.messError = "You do not have enough exp to join, at least silver rank!";
        this.showError = true;
        setTimeout(() => {
          this.showError = false;
        }, 5000);
      }

    }
  }

  private async setListChallenge(listChall: any[]): Promise<void> {
    if (listChall) {
      const promises = listChall.map(async (slide) => {
        if (slide.image) {
          try {
            const url = await this.fireBase.getImageUrl(slide.image).toPromise();
            slide.image = url;
          } catch (error) {
            console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
          }
        }
        return slide;
      });

      try {
        const resolvedTop3 = await Promise.all(promises);
        this.listChallenge = resolvedTop3;
      } catch (error) {
        console.error('Lỗi khi xử lý top 3:', error);
      }
    }
  }

  private async setTop3User(top3: any[]): Promise<void> {
    if (top3) {
      const promises = top3.map(async (slide) => {
        if (slide.images) {
          try {
            const url = await this.fireBase.getImageUrl(slide.images).toPromise();
            slide.images = url;
          } catch (error) {
            console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
          }
        }
        return slide;
      });

      try {
        const resolvedTop3 = await Promise.all(promises);
        this.top3User = resolvedTop3;
      } catch (error) {
        console.error('Lỗi khi xử lý top 3:', error);
      }
    }
  }


  private async setChallengeComing(chall: any): Promise<void> {
    if (chall) {
      this.challengeComing = chall;
      this.calculateTimeRemaining();
      setInterval(() => this.calculateTimeRemaining(), 1000);
    }
  }

  private async setAchievements(achie: any): Promise<void> {
    if (achie) {
      await this.fireBase.getImageUrl(achie.image).subscribe(
        (url) => {
          achie.image = url;
          this.achievements = achie;
        },
        (error) => {
          console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
        }
      );
    } else {
      this.achievements = achie;
    }
  }


  private calculateTimeRemaining() {
    if (this.challengeComing.date) {
      const now = new Date().getTime();
      const targetDate = new Date(this.challengeComing.date).getTime(); // Ngày cố định

      this.countdown = Math.max(0, Math.floor((targetDate - now) / 1000));

      if (this.countdown > 86400) { // Nếu còn nhiều hơn một ngày
        const days = Math.floor(this.countdown / 86400);
        const hours = Math.floor((this.countdown % 86400) / 3600);
        this.displayTime = `${days} days ${this.padZero(hours)} hours`;
      } else {
        const hours = Math.floor(this.countdown / 3600);
        const minutes = Math.floor((this.countdown % 3600) / 60);
        if (hours == 0 && minutes <= 20) {
          this.showBtnJoin = true;
        }
        if (this.countdown == 0) {
          this.showBtnJoin = false;
        }
        this.displayTime = `${this.padZero(hours)} hours ${this.padZero(minutes)} minutes`;
      }
    }
  }

  private padZero(value: number): string {
    return value < 10 ? `0${value}` : `${value}`;
  }


  toggleDropdown() {
    console.log(this.isDropdownOpen)
    this.isDropdownOpen = !this.isDropdownOpen;
  }

  changeForm() {
    this.userDataService.setloginForm(true);
  }

  selectOption(option: string) {
    this.selectedOption = option;
    this.isDropdownOpen = false;

  }
}
