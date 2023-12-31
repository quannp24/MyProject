import { Component, OnInit } from '@angular/core';
import { Quiz } from 'src/app/models/quiz-data.model';
import { faChartLine, faUserGroup } from '@fortawesome/free-solid-svg-icons';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { ActivatedRoute, Router } from '@angular/router';
import { UserDataService } from 'src/app/services/user-data.service';
import { switchMap } from 'rxjs';
import { User } from 'src/app/models/user.model';
import { MenuItem } from 'primeng/api';
import { QuizSetData } from 'src/app/models/quiz-set-data.model';
import { AccountService } from 'src/app/services/account.service';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';
import { Location } from '@angular/common';


@Component({
  selector: 'app-quiz-private-detail',
  templateUrl: './quiz-private-detail.component.html',
  styleUrls: ['./quiz-private-detail.component.scss']
})
export class QuizPrivateDetailComponent implements OnInit {
  quiz?: Quiz;
  quizId?: number;
  creator?: User;
  messError?: string;
  showUpgrade: boolean = false; // biến hiển thị modal upgrade
  modalRemove: boolean = false; // biến mở modal remove
  quizData: QuizSetData = { quizz: {}, questions: [] }; // biến lưu data quiz cũ
  isLoadingQuiz: boolean = true; // biến loading dữ liệu quiz\
  numDoDay?: number; // biến số lượng người làm quiz hôm nay
  numDoMonth?: number; // biến số lượng người làm quiz tháng này
  user?: User;//biến thông tin người dùng
  notPermission: boolean = false; // biến kiểm tra quyền truy cập trang


  items: MenuItem[] = [
    {
      items: [
        {
          label: 'Edit',
          icon: 'pi pi-pencil',
          command: () => {
            this.RedirectEdit();
          }
        },
        {
          label: 'Remove',
          icon: 'pi pi-trash',
          command: () => {
            this.showModalRemove();
          }
        }
      ]
    }
  ];


  //icon
  faChartLine = faChartLine;
  faUserGroup = faUserGroup;


  constructor(private quizService: QuizDataService, private route: ActivatedRoute, private userDataService: UserDataService,
    private router: Router, private accountService: AccountService, private fireBase: FirebaseImageService, private location: Location) { }


  async ngOnInit(): Promise<void> {
    await this.route.params.pipe(
      switchMap(params => {
        this.quizId = params['quizId'];
        return this.userDataService.userCurr;
      })
    ).subscribe(userData => {
      if (userData.userId) {
        this.user = userData;
        this.GetInforQuiz();
      }
    });
  }

  async removeQuiz(): Promise<void> {
    if (this.quizData.quizz.quizType == 3 && this.quizData.quizz.creatorId == this.user?.userId && this.quizData.quizz.quizId) {
      await this.quizService.deleteQuiz(this.quizData.quizz.quizId, 3).subscribe(
        (response) => {
          if (response.status) {
            this.router.navigate(['/your-library']);
          }
        },
        (error) => {
          console.error('Lỗi khi xóa quiz:', error);
        }
      );
    }
  }

  async RedirectEdit() {
    if (this.quizId)
      this.router.navigate(['/edit-quiz/' + this.quizId]);
  }

  async createRoomDoQuiz() {
    if (this.user && this.quizId) {
      if (this.user.role != 4) {
        await this.quizService.createRoomQuiz(this.quizId).subscribe(
          (response: any) => {
            if (response.status) {
              if (response.result)
                this.router.navigate(['/do-quiz-friends/' + this.quizId + '/' + response.result]);
            } else {
              this.messError = response.message;
            }
          },
          (error) => {
            console.error('Create room fail:', error);
          }
        );
      } else {
        this.showUpgrade = true;
      }
    }
  }

  private async GetInforQuiz(): Promise<void> {
    if (this.quizId) {
      this.quizService.getquiz(this.quizId).subscribe(
        (response) => {
          if (response.status) {
            if (response.result.quizz.quizType != 3) {
              this.router.navigate(['/quiz-detail', this.quizId]);
            } else {
              if (response.result.quizz.creatorId == this.user?.userId || response.result.quizz.isFriendCreator) {
                this.setupInforQuiz(response.result);
              } else {
                this.notPermission = true;
              }

            }
          }
        },
        (error) => {
          console.error('Lỗi khi lấy dữ liệu quiz:', error);
        }
      );
    }
  }

  private async getNumberDoToday(): Promise<void> {
    if (this.quizId)
      this.quizService.getUserDoQuizToday(this.quizId).subscribe(
        (response) => {
          if (response.status) {
            this.numDoDay = response.result.numDay;
            this.numDoMonth = response.result.numMonth;
          }
        },
        (error) => {
          console.error('Lỗi khi lấy dữ liệu người làm quiz:', error);
        }
      );
  }

  goBack() {
    this.location.back();
  }

  private async setupInforQuiz(quiz: QuizSetData) {
    if (quiz.quizz.image && quiz.quizz.image.length > 2) {
      this.fireBase.getImageUrl(quiz.quizz.image).subscribe(
        (url) => {
          quiz.quizz.image = url;
          this.quizData = quiz;
          this.isLoadingQuiz = false;
          if (quiz.quizz.creatorId)
            this.GetInforCreator(quiz.quizz.creatorId);
        },
        (error) => {
          console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
        }
      );
    } else {
      quiz.quizz.image = '';
      this.quizData = quiz;
      this.isLoadingQuiz = false;
      if (quiz.quizz.creatorId)
        this.GetInforCreator(quiz.quizz.creatorId);
    }
  }

  private async GetInforCreator(userId: number): Promise<void> {
    if (userId)
      this.accountService.getUserId(userId).subscribe(
        (response) => {
          if (response.status) {
            this.setupInforCreator(response.result);
            this.getNumberDoToday();
          }
        },
        (error) => {
          console.error('Lỗi khi lấy dữ liệu creator:', error);
        }
      );
  }

  private async setupInforCreator(user: User) {
    if (user.images && user.images.length > 2) {
      this.fireBase.getImageUrl(user.images).subscribe(
        (url) => {
          user.images = url;
          this.creator = user;
        },
        (error) => {
          console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
        }
      );
    } else {
      user.images = '';
      this.creator = user;
    }
  }

  showModalRemove() {
    this.modalRemove = true;
  }
}
