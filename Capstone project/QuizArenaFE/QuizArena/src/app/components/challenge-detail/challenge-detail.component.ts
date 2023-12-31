import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { switchMap } from 'rxjs';
import { User } from 'src/app/models/user.model';
import { ChallengeService } from 'src/app/services/challenge.service';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';
import { UserDataService } from 'src/app/services/user-data.service';

@Component({
  selector: 'app-challenge-detail',
  templateUrl: './challenge-detail.component.html',
  styleUrls: ['./challenge-detail.component.scss']
})
export class ChallengeDetailComponent implements OnInit {
  examId?: string; // biến lưu examId
  myRank: { score?: number, timeSubmit?: Date, positionRank?: number } = {}; // biến lưu rank user
  challInfo: {
    examName?: string, examType?: number,
    image?: string, date?: Date, status?: number,
    timeLimit?: number, numberQuestion?: number, numberUser?: number
  } = {}; // biến lưu thông tin challenge
  user?: User; // biến lưu dữ liệu user
  usersRank: {
    userId?: number, username?: string, images?: string,
    fullname?: string, score?: number, timeSubmit?: Date,
    positionRank?: number
  }[] = []; // biến lưu thông tin challenge

  constructor(private route: ActivatedRoute, private userService: UserDataService, private challService: ChallengeService, private fireBase: FirebaseImageService) { }

  async ngOnInit(): Promise<void> {
    const token = localStorage.getItem('authToken');


    await this.route.params.pipe(
      switchMap(params => {
        this.examId = params['examId'];
        return this.userService.userCurr;
      })
    ).subscribe(userData => {
      if (token) {
        this.user = userData;
        if (userData.userId && this.examId) {
          this.challService.getInforChallengeDetail(this.examId).subscribe(
            (response) => {
              if (response.status) {
                this.setupInfoChallenge(response.result.examInfo);
                this.setupMyRank(response.result.myRanking);
                this.setupRankBoard(response.result.ranking);
              }
            },
            (error) => {
              console.error('Lỗi khi lấy dữ liệu challenge:', error);
            }
          );
        }
      } else {
        if (this.examId)
          this.challService.getInforChallengeDetail(this.examId).subscribe(
            (response) => {
              if (response.status) {
                this.setupInfoChallenge(response.result.examInfo);
                this.setupMyRank(response.result.myRanking);
                this.setupRankBoard(response.result.ranking);
              }
            },
            (error) => {
              console.error('Lỗi khi lấy dữ liệu challenge:', error);
            }
          );
      }

    });



  }


  private async setupInfoChallenge(chall: any): Promise<void> {
    if (chall) {
      if (chall.image && chall.image.length > 0) {
        this.fireBase.getImageUrl(chall.image).subscribe(
          (url) => {
            if (url) {
              chall.image = url;
              this.challInfo = chall;
            }
          },
          (error) => {
            console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
          }
        );
      } else {
        this.challInfo = chall;
      }
    }
  }


  private async setupMyRank(rank: any): Promise<void> {
    if (rank) {
      this.myRank = rank;
    }
  }

  private async setupRankBoard(userRank: any[]): Promise<void> {
    if (userRank) {
      const promises = userRank.map(async (slide) => {
        if (slide.images && slide.images.length > 0) {
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
        this.usersRank = resolvedTop3;
      } catch (error) {
        console.error('Lỗi khi lấy dữ liệu bảng rank:', error);
      }
    }
  }


}
