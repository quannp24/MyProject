import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { Page } from 'src/app/models/page.model';
import { DashboardService } from 'src/app/services/dashboard.service';
import { JwtService } from 'src/app/services/jwt.service';
import { UserDataService } from 'src/app/services/user-data.service';
import { faCircleInfo, faPenToSquare, faEye, faEyeSlash, faTrashAlt } from '@fortawesome/free-solid-svg-icons';
import { Quiz } from 'src/app/models/quiz-data.model';
import { QuizDataService } from 'src/app/services/quiz-data.service';

@Component({
  selector: 'app-quiz-manage',
  templateUrl: './quiz-manage.component.html',
  styleUrls: ['./quiz-manage.component.scss']
})
export class QuizManageComponent {
  [x: string]: any;
  isLoggedIn = false;


  constructor(private dashboardService: DashboardService, private userDataService: UserDataService, private router: Router, private quizData: QuizDataService) { }

  isLoading: boolean = true;
  statusCurrent: number = 0
  totalQuizzes: any;
  totalQuizlevel1: any;
  totalQuizlevel2: any;
  totalQuizlevel3: any;
  listQuiz: any
  listApproveQuiz: any
  listUnapproveQuiz: any
  selectedFilter: number = 0;
  searchTextUnApprove: string = "";
  searchTextApprove: string = "";
  displayDialog: boolean = false;
  itemToDelete: any;
  listCategory: any
  loading: boolean = true
  newCategoryName : any
  showResultApprove = false;
  displayAddCategory = false;
  resultAdd: boolean = false; 
  resultUpdate: boolean = true
  showResult: boolean = false
  categoryId!: number
  edit: boolean = false
  faCircleInfo = faCircleInfo
  faEye = faEye
  faEyeSlash = faEyeSlash
  faPenToSquare = faPenToSquare
  faTrashAlt = faTrashAlt
  selectedQuiz: any;
  async ngOnInit() {
    await this.userDataService.userCurr.subscribe(user => {
      if (user.userId) {
        this.dashboardService.getDashboardStatistics().subscribe(
          (stats: any) => {
            this.totalQuizzes = stats.totalQuizzes;
            this.totalQuizlevel1 = stats.totalQuizlevel1;
            this.totalQuizlevel2 = stats.totalQuizlevel2;
            this.totalQuizlevel3 = stats.totalQuizlevel3;
            if(stats){
              this.onUnApproveSearch();
              this.getCategoryList();
            }
            this.isLoading = false;
          },
          (error: any) => {
            console.error('Error:', error);
            this.isLoading = false;
          }
        );
      }
    })
  }

  openCategoryManage(){
    this.showResultApprove = true;
  }

  addCategoryButton(){
    this.displayAddCategory = true
  }

  editCategoryButton(category: any){
    this.newCategoryName = category.categoryName
    this.categoryId = category.categoryId
    this.edit = true;
    this.displayAddCategory = true
  }

  addCategory(){
    this.quizData.addCategory(this.newCategoryName).subscribe(res => {
      this.resultAdd = true
      this.showResult = true;
      this.displayAddCategory = false
      this.getCategoryList();
    })
  }

  updateCategoy(){
    this.quizData.updateCategory(this.categoryId, this.newCategoryName).subscribe(res => {
      this.resultUpdate = true
      this.showResult = true;
      this.displayAddCategory = false
      this.getCategoryList();
    })
  }


  onUnApproveSearch() {
    this.dashboardService.getUnapprovedQuizzes().subscribe(res => {
      this.onApproveSearch();
      this.listUnapproveQuiz = res;
      if (res && this.searchTextUnApprove) {
        const filteredUserResults: Quiz[] = res.filter((quiz: Quiz) => quiz.title?.toLocaleLowerCase().includes(this.searchTextUnApprove.toLocaleLowerCase()));
        this.listUnapproveQuiz = filteredUserResults
      }
    })
  }

  onApproveSearch() {
    this.dashboardService.getApprovedQuizzes().subscribe(res => {
      this.listApproveQuiz = res
      if (res && this.searchTextApprove) {
        const filteredUserResults: Quiz[] = res.filter((quiz: Quiz) => quiz.title?.toLocaleLowerCase().includes(this.searchTextApprove.toLocaleLowerCase()));
        this.listApproveQuiz = filteredUserResults
      }
    })
  }

  getCategoryList(){
    this.quizData.getCategory().subscribe( res => {
      this.listCategory = res.result
      this.loading = false
    })
  }

  openQuizModal(item: any) {
    this.selectedQuiz = item;
    console.log(item.Object, "item")
  }

  approveQuiz(quizId: number) {
    this.router.navigate(['/approve-quiz', quizId]);
  }

  deleteQuiz(): void {
    this.dashboardService.updateQuizStatus(this.itemToDelete.quizId, -1).subscribe(
      response => {
        this.displayDialog = false;
        this.reloadPage();
      },
      error => {
        console.error('Error deleting quiz:', error);
        this.displayDialog = false;
      }
    );
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
  // bị bắt bắt dê
  changeQuizStatus(quizId: number, status: number) {

    if (status === 3) {
      this.statusCurrent = 1
    } else {
      this.statusCurrent = 3
    }
    this.dashboardService.changeQuizStatus(quizId, this.statusCurrent).subscribe(res => {
      this.onApproveSearch()
      this.onApproveSearch()
    }
    )
  }

}
