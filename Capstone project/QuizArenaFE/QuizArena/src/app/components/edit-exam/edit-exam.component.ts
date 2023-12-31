import { Component, ElementRef, HostListener, Renderer2, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { faSquarePlus, faTrash, faXmark, faShareFromSquare, faTrashCan, faFloppyDisk } from '@fortawesome/free-solid-svg-icons';
import { switchMap } from 'rxjs';
import { ExamData } from 'src/app/models/exam-data.model';
import { QuestionData } from 'src/app/models/question-data.model';
import { Quiz } from 'src/app/models/quiz-data.model';
import { QuizSetData } from 'src/app/models/quiz-set-data.model';
import { User } from 'src/app/models/user.model';
import { DashboardService } from 'src/app/services/dashboard.service';
import { ExamService } from 'src/app/services/exam-data.service';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { UserDataService } from 'src/app/services/user-data.service';
import { fadeIn, fadeOutIn } from 'src/assets/animations/animation-quiz';
import { v4 as uuidv4 } from 'uuid';


@Component({
  selector: 'app-edit-exam',
  templateUrl: './edit-exam.component.html',
  styleUrls: ['./edit-exam.component.scss']
})
export class EditExamComponent {
  imageUrl: string = '';
  @ViewChild('fileInput') fileInput: ElementRef | undefined;
  @ViewChild('imageSlot') imageSlot: ElementRef | undefined;
  selectedQuizId: number = 1;
  selectedTypeExam: string = "1";
  examId: string = '';
  name: string = '';
  description: string = '';
  image?: string;
  isCanSubmit: boolean = false; // biến xác định được add quiz hay chưa
  fileImage?: File; // biến lưu giữ ảnh
  messQuiz: { title?: boolean, description?: boolean, Category?: boolean, timeLimit?: boolean } = {};
  showScrollToTopButton: boolean = false; // biến hiển thị scroll
  showResult: boolean = false; // biến hiển thị kết quả add
  resultAdd: boolean = false; // biến kết quả add quiz
  listQuiz: any
  selectedDateTime!: Date;
  user?: User; // biến chứa dữ liệu người dùng
  displayDialog: boolean = false; /// hiển thị thông báo
  isLoading:boolean = true; // biến loading

  ///icon
  faSquarePlus = faSquarePlus;
  faShareFromSquare = faShareFromSquare;
  faTrashCan = faTrashCan;
  faFloppyDisk = faFloppyDisk;
  faTrash = faTrash;
  faXmark = faXmark;
  isDisabled: boolean = true;
  constructor(private quizDataService: QuizDataService, private userDataService: UserDataService, private renderer: Renderer2, private fireBase: FirebaseImageService,
    private route: ActivatedRoute, private examService: ExamService, private dashboardService: DashboardService, private router: Router) {

  }

  async ngOnInit() {
    await this.route.params.pipe(
      switchMap(params => {
        this.examId = params['examId'];
        return this.userDataService.userCurr;
      })
    ).subscribe(userData => {
      if (userData.userId) {
        this.examService.getQuizzesByTypeAndStatus().subscribe(res => {
          this.selectedQuizId = res[0].quizId
          this.listQuiz = res
          this.examService.getExamById(this.examId).subscribe(res => {
            this.mapChallengeData(res);
          })
        })
      }
    });

  }

  private mapChallengeData(chall: any) {
    if (chall.examName && chall.examName.length > 0) {
      this.name = chall.examName;
    }
    if (chall.description && chall.description.length > 0) {
      this.description = chall.description;
    }
    if (chall.image && chall.image.length > 0) {
      this.image = chall.image;
      this.getImageQuiz(chall.image);
    }
    if (chall.date) {
      this.selectedDateTime = chall.date;
    }
    if (chall.examType) {
      this.selectedTypeExam = chall.examType;
    }
    if (chall.quizId && chall.quizId != 0) {
      this.selectedQuizId = chall.quizId;
    }
    this.isLoading = false;

  }


  private getImageQuiz(img: string) {
    this.fireBase.getImageUrl(img).subscribe(
      (url) => {
        if (url) {
          if (this.imageSlot)
            this.renderer.setProperty(this.imageSlot.nativeElement, 'innerHTML', `<img src="${url}" class="img-upload" style="width: 508px;object-fit: cover;height: 348px;border-radius:5px" alt="Selected Image">`);
        }
      },
      (error) => {
        console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
      }
    );
  }



  /*
  *Hàm check và hiển thị mess lỗi các trường của question
  */
  private updateMessError(question: any): boolean {
    // Kiểm tra nếu cả hai trường all4question và correctAnswer đều trống
    if (!question.all4question) {
      // Nếu all4question trống
      question.messError = "Question text is empty.";
      return false;
    } else if (!question.correctAnswer) {
      // Nếu correctAnswer trống
      question.messError = "Choose the correct answer for the question.";
      return false;
    } else {
      // Nếu không có lỗi, đảm bảo messError được đặt về trạng thái rỗng
      question.messError = "";
      return true;
    }
  }



  /*
  * Hàm xử lý update quiz
  */
  editQuiz() {
    const examData: ExamData = {};
    examData.examId = this.examId;
    examData.examName = this.name;
    examData.description = this.description;
    examData.quizId = this.selectedQuizId;
    examData.examType = Number(this.selectedTypeExam);
    examData.date = this.selectedDateTime;
    if (this.fileImage && this.image) {
      const imgName = this.setImageNameUpdate();
      if (imgName && imgName.trim().length > 0)
        examData.image = `image/challenge/` + imgName;
    }
    console.log(examData);
    this.examService.updateExam(examData).subscribe(
      (response: any) => {
        if (response.status) {
          if (this.fileImage && examData && examData.image) {
            this.fireBase.uploadImageQuiz(this.fileImage, examData.image);
            if (this.image && this.image?.length > 0) {
              this.fireBase.deleteImage(this.image);
            }
          }
          this.showResult = true;
          this.resultAdd = true;
        } else {
          this.showResult = true;
          this.resultAdd = false;
          console.error('Lỗi update challenge:', response.message);
        }
      },
      (error: any) => {
        this.showResult = true;
        this.resultAdd = false;
        console.error('Lỗi update challenge:', error);
      }
    );
  }


  /*
  *Hàm set tên ảnh theo mã guid
  */
  private setImageNameUpdate(): string {
    const newGuid = uuidv4();
    let fileName: string = '';
    if (this.fileImage) {
      if (this.fileImage.type == 'image/jpeg') {
        fileName = newGuid + '.jpg';
      }
      if (this.fileImage.type == 'image/png') {
        fileName = newGuid + '.png';
      }
    }
    return fileName;
  }

  /*
  *Hàm xử lý chuyển hướng khi modal lỗi hiển thị
  */
  goBack() {
    this.router.navigateByUrl('/challenge-manage', { skipLocationChange: true }).then(() => {
      this.router.navigate(['/challenge-manage']);
    });
  }


  /*
  * Hàm kiểm tra dữ liệu và các trường
  */
  // validateInputQuiz(): boolean {
  //   let checkResult = true;
  //   if (!this.title || this.title.length < 1) {
  //     this.messQuiz.title = true;
  //     checkResult = false;
  //   } else {
  //     this.messQuiz.title = false;
  //   }
  //   if (!this.description || this.description.length < 100) {
  //     this.messQuiz.description = true;
  //     checkResult = false;
  //   } else {
  //     this.messQuiz.description = false;
  //   }
  //   if (this.selectedTypeQuiz.includes('2') && !this.timeLimit) {
  //     this.messQuiz.timeLimit = true;
  //     checkResult = false;
  //   } else {
  //     if (this.timeLimit && /^\d+$/.test(this.timeLimit))
  //       this.messQuiz.timeLimit = false;
  //   }
  //   return checkResult;
  // }


  /*
  * Hàm mở cửa sổ chọn file
  */
  openFileInput() {
    if (this.fileInput)
      this.renderer.selectRootElement(this.fileInput.nativeElement).click();
  }




  /*
  * Hàm load ảnh
  */
  handleFileInput(event: any) {
    const fileInput = event.target;

    if (fileInput.files && fileInput.files[0]) {
      const reader = new FileReader();
      reader.onload = (e: any) => {
        if (this.imageSlot)
          this.renderer.setProperty(this.imageSlot.nativeElement, 'innerHTML', `<img src="${e.target.result}" class="img-upload" style="width: 508px;object-fit: cover;height: 348px;border-radius:5px" alt="Selected Image">`);
      };
      this.fileImage = fileInput.files[0];
      reader.readAsDataURL(fileInput.files[0]);
    }
  }

  /*
  * Hàm nhận sự kiện kéo xuống hiện nút scroll
  */
  @HostListener('window:scroll', [])
  onWindowScroll() {
    const scrollPosition = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;

    // Hiển thị nút khi scroll xuống một khoảng nhất định, ví dụ, 200px
    this.showScrollToTopButton = scrollPosition > 300;
  }

  /*
  * Hàm scroll top tự động
  */
  scrollToTop() {
    window.scrollTo({ top: 0, behavior: 'smooth' }); // Sử dụng 'smooth' để có hiệu ứng cuộn mượt
  }

  // xóa quiz
  deleteExam(): void {
    this.dashboardService.deleteExam(this.examId).subscribe(
      response => {
        if (this.image && this.image?.length > 0) {
          this.fireBase.deleteImage(this.image);

        }
        this.displayDialog = false;
        this.router.navigate(['/challenge-manage']);

      },
      error => {
        console.error('Error deleting exam:', error);
        this.displayDialog = false;
      }
    );
  }

  // confirm xóa
  showDeleteConfirmation(): void {
    this.displayDialog = true;
  }
}
