import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { Page } from 'src/app/models/page.model';
import { DashboardService } from 'src/app/services/dashboard.service';
import { JwtService } from 'src/app/services/jwt.service';
import { UserDataService } from 'src/app/services/user-data.service';
import { faCircleInfo, faPenToSquare, faEye, faEyeSlash, faTrashAlt } from '@fortawesome/free-solid-svg-icons';
import { Quiz } from 'src/app/models/quiz-data.model';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { QuestionData } from 'src/app/models/question-data.model';

@Component({
  selector: 'app-question-manage',
  templateUrl: './question-manage.component.html',
  styleUrls: ['./question-manage.component.scss']
})
export class QuestionManageComponent {
  [x: string]: any;
  isLoggedIn = false;
  constructor(private dashboardService: DashboardService, private userDataService: UserDataService, private router: Router, private quizDataService: QuizDataService) { }

  isLoading: boolean = true;
  statusCurrent: number = 0
  totalQuestion: any;
  listApproveCategory: any
  listUnapproveCategory: any
  displayDialog: boolean = false;
  itemToDelete: any;
  loading: boolean = true;
  showResultApprove = false;
  listQuestion: QuestionData[] = []
  totalUnapprove = 0
  totalApprove = 0
  faCircleInfo = faCircleInfo
  faEye = faEye
  faEyeSlash = faEyeSlash
  faPenToSquare = faPenToSquare
  faTrashAlt = faTrashAlt

  async ngOnInit() {
    await this.userDataService.userCurr.subscribe(user => {
      if (user.userId) {
        this.quizDataService.getCategoryByStatus(1, undefined).subscribe(res => {
          if (res) {
            this.listApproveCategory = res;
            this.totalApprove = res.length
            this.totalQuestion = this.totalApprove
            this.getCategoryUnApprove();
          }
        })
        this.isLoading = false;
      }
    })
  }

  private async getNumberQuestion(): Promise<void> {
    await this.userDataService.userCurr.subscribe(user => {
      if (user.userId) {
        this.dashboardService.getDashboardStatistics().subscribe(
          (stats: any) => {
            if (stats.numQuestion) {
              this.totalUnapprove = stats.numQuestion.numApprove;
              this.totalApprove = stats.numQuestion.numAll;
            }
          },
          (error: any) => {
            console.error('Error:', error);
          }
        );
      }
    })
  }

  getCategoryUnApprove() {
    this.quizDataService.getCategoryByStatus(2, undefined).subscribe(res => {
      this.listUnapproveCategory = res;
      this.getNumberQuestion();
      this.loading = false;
    })
  }

  approveQuiz(quizId: number) {
    this.router.navigate(['/approve-quiz', quizId]);
  }


  reloadPage(): void {
    // Lấy url hiện tại
    const currentUrl = this.router.url;

    // Navigate đến cùng một url để reload trang
    this.router.navigateByUrl('/', { skipLocationChange: true }).then(() => {
      this.router.navigate([currentUrl]);
    });
  }

  showDeleteConfirmation(item: any): void {
    this.itemToDelete = item;
    this.displayDialog = true;
  }

  showDetailQuestion(categoyId: number) {
    // Set the boolean variable to true to show the dialog
    this.showResultApprove = true;
    this.getQuestionsByCategory(categoyId, 1);
  }

  getQuestionsByCategory(categoyId: number, status: number) {
    this.quizDataService.getQuestionsByCategory(categoyId, status, undefined).subscribe(res => {
      this.listQuestion = res.result
      this.loading = false
    })
  }

}
