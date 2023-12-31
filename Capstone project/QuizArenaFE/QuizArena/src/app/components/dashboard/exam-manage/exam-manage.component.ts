import { Component } from '@angular/core';
import { DashboardService } from 'src/app/services/dashboard.service';
import { UserDataService } from 'src/app/services/user-data.service';
import { faCircleInfo, faPenToSquare, faEye, faEyeSlash, faTrashAlt } from '@fortawesome/free-solid-svg-icons';
import { Router } from '@angular/router';
@Component({
  selector: 'app-exam-manage',
  templateUrl: './exam-manage.component.html',
  styleUrls: ['./exam-manage.component.scss']
})
export class ExamManageComponent {
  isLoading: boolean = true; // Ban đầu, hiển thị khối div lúc đang load
  listExam: any
  displayDialog: boolean = false;
  itemToDelete: any;
  selectedExam: any;
  statusCurrent: number = 0
  isDisabled: boolean = true;
  loading: boolean = true;
  faCircleInfo = faCircleInfo
  faEye = faEye
  faEyeSlash = faEyeSlash
  faPenToSquare = faPenToSquare
  faTrashAlt = faTrashAlt
  constructor(private dashboardService: DashboardService,  private userDataService: UserDataService, private router: Router) { }

  // Simulate loading data, ví dụ: sau 3 giây, tắt khối div
  ngOnInit() {
    setTimeout(() => {
      this.isLoading = false; // Tắt khối div sau khi tải dữ liệu xong
    }, 500); // Đây chỉ là ví dụ, bạn cần thay thời gian tương ứng với việc tải dữ liệu thực tế
     this.userDataService.userCurr.subscribe(user => {
      if (user.userId) {
       this.getListExam()
      }
    });
  }

  getListExam(){
    this.dashboardService.getListExam().subscribe(res =>{
      this.listExam = res;
      this.loading = false;
    })
  }

  showDeleteConfirmation(item: any): void {
    console.log(item)
    this.itemToDelete = item;
    this.displayDialog = true;
  }

  deleteExam(): void {
    this.dashboardService.deleteExam(this.itemToDelete.examId).subscribe(
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

  changeQuizStatus(examId: number, status: number) {

    if (status === 0) {
      this.statusCurrent = 1
    } else {
      this.statusCurrent = 0
    }
    this.dashboardService.changeExamStatus(String(examId), this.statusCurrent).subscribe(res => {
      this.getListExam();
    }
    )
  }
}
