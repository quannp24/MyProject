import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { switchMap } from 'rxjs';
import { Quiz } from 'src/app/models/quiz-data.model';
import { User } from 'src/app/models/user.model';
import { AccountService } from 'src/app/services/account.service';
import { ChallengeService } from 'src/app/services/challenge.service';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { UserDataService } from 'src/app/services/user-data.service';

@Component({
  selector: 'app-profile-user-orther',
  templateUrl: './profile-user-orther.component.html',
  styleUrls: ['./profile-user-orther.component.scss']
})
export class ProfileUserOrtherComponent {
  friendId: number = 0;
  userId: number = 0;
  friend?: User; // biến lưu trữ thông tin bạn bè
  rankingPercent: number = 0;
  friendAction?: number; // 0: chưa add friend  | 1: đã add friend | 2:đang chờ duyệt | 3: có lời mời add
  loading: boolean = true;
  quizlist: Quiz[] = [];
  achievements: { date?: Date, examName?: string, image?: string, score?: number, topUser?: number } = {}; // biến lưu trữ dữ liệu achievements
  isloading: boolean = true;


  constructor(private route: ActivatedRoute, private userService: UserDataService, private accService: AccountService, private fireBase: FirebaseImageService,
    private router: Router, private quizService: QuizDataService, private challengeService: ChallengeService) {
  }

  async ngOnInit(): Promise<void> {

    await this.route.params.pipe(
      switchMap(params => {
        this.friendId = params['friendId'];
        return this.userService.userCurr;
      })
    ).subscribe(userData => {
      if (userData.userId == this.friendId) {
        this.router.navigate(['/profile']);
      } else {
        if (userData.userId && this.friendId) {
          this.userId = userData.userId;
          this.accService.getUserId(this.friendId).subscribe(
            (response) => {
              if (response.result.userId) {

                this.accService.getFriendStatus(this.friendId).subscribe(
                  (response) => {
                    if (response.status) {
                      this.friendAction = response.result;
                      this.getAchievement();
                    }
                  },
                  (error) => {
                  }
                );
              }
              if (response.result.images) {
                this.fireBase.getImageUrl(response.result.images).subscribe(
                  (url) => {
                    if (url) {
                      response.result.images = url;
                      this.friend = response.result;
                      this.setupQuizPrivate();
                      this.caculateExp();
                    }
                  },
                  (error) => {
                    console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
                  }
                );
              } else {

                this.friend = response.result;
                this.setupQuizPrivate();
                this.caculateExp();
              }
            },
            (error) => {
              console.error('Lỗi khi lấy dữ liệu quiz:', error);
            }
          );
        }
      }

    });

  }

  private async getAchievement() {
    await this.quizService.getAchievementsUser(this.friendId).subscribe(
      (response) => {
        if (response.status) {
          console.log(response)

          if (!response.result) {
            this.isloading = false;
          } else {
            this.setAchievements(response.result);
          }
        } else {
          this.isloading = false;
        }
      },
      (error) => {
        this.isloading = false;
        console.error('Lỗi khi lấy achievement user:', error);
      }
    );
  }

  private async setAchievements(achie: any): Promise<void> {
    if (achie && achie.image) {
      await this.fireBase.getImageUrl(achie.image).subscribe(
        (url) => {
          achie.image = url;
          this.achievements = achie;
          this.isloading = false;
        },
        (error) => {
          console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
        }
      );
    } else {
      this.achievements = achie;
      this.isloading = false;
    }
  }

  private async setupQuizPrivate() {
    if (this.friend?.userId)
      await this.quizService.getListQuizPrivate(this.friend?.userId).subscribe(
        (res) => {
          if (res.status) {
            this.quizlist = res.result;
            this.loading = false;
          }
        },
        (error) => {
          console.error('Lỗi khi lấy dữ liệu quiz private:', error);
        }
      );
  }


  groupDataByMonth(data: Quiz[]): any {
    return data.map(item => {
      if (item.createDate) {
        const monthYear = this.getMonthYearFromDate(item.createDate);
        return { ...item, monthYear };
      }
      return item;
    });
  }

  getMonthYearFromDate(date: Date): string {
    return new Date(date).toLocaleString('en-us', { month: 'long', year: 'numeric' });
  }


  private caculateExp() {
    if (this.friend) {
      if (this.friend.exp < 1000) {
        this.rankingPercent = (this.friend.exp / 1000) * 100;
      }
      if (this.friend.exp < 10000 && this.friend.exp >= 1000) {
        this.rankingPercent = (this.friend.exp / 10000) * 100;
      }
      if (this.friend.exp >= 10000) {
        this.rankingPercent = 100;
      }
    }
  }





  handleFriendAction(): void {
    if (this.friendAction === 0) {
      if (this.userId && this.friendId)
        this.accService.addFriend(this.userId, this.friendId).subscribe(
          (response) => {
            if (response.status) {
              this.friendAction = 2;
            }
          },
          (error) => {
            console.error('Lỗi khi xử lý kết bạn:', error);
          }
        );
    }

    if (this.friendAction === 3) {
      if (this.userId && this.friendId)
        this.accService.confirmFriendRequest(this.userId, this.friendId).subscribe(
          () => {
            this.friendAction = 1;
          },
          (error) => {
            console.error('Lỗi khi xử lý kết bạn:', error);
          }
        );
    }
    if (this.friendAction === 2) {
      if (this.userId && this.friendId)
        this.accService.declineFriendRequest(this.userId, this.friendId).subscribe(
          () => {
            this.friendAction = 0;
          },
          (error) => {
            console.error('Lỗi khi xử lý kết bạn:', error);
          }
        );
    }
  }


  DeleteRequestAction(): void {
    if (this.friendAction === 3) {
      if (this.friendId)
        this.accService.declineFriendRequest(this.friendId, this.userId).subscribe(
          (response) => {
            if (response.status) {
              this.friendAction = 0;
            }
          },
          (error) => {
            console.error('Lỗi khi xử lý kết bạn:', error);
          }
        );
    }
  }
}
