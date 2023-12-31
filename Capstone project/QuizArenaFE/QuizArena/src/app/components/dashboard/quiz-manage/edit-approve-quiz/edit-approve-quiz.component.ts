import { Component, ElementRef, HostListener, Renderer2, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { faSquarePlus, faTrash, faXmark, faShareFromSquare, faFloppyDisk, faTrashCan, faCheck } from '@fortawesome/free-solid-svg-icons';
import { switchMap } from 'rxjs';
import { QuestionData } from 'src/app/models/question-data.model';
import { Quiz } from 'src/app/models/quiz-data.model';
import { QuizSetData } from 'src/app/models/quiz-set-data.model';
import { User } from 'src/app/models/user.model';
import { DashboardService } from 'src/app/services/dashboard.service';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { UserDataService } from 'src/app/services/user-data.service';
import { fadeIn, fadeOutIn } from 'src/assets/animations/animation-quiz';

@Component({
  selector: 'app-edit-approve-quiz',
  templateUrl: './edit-approve-quiz.component.html',
  styleUrls: ['./edit-approve-quiz.component.scss'],
  animations: [fadeIn, fadeOutIn]
})
export class EditApproveQuizComponent {
  imageUrl: string = '';
  @ViewChild('fileInput') fileInput: ElementRef | undefined;
  @ViewChild('imageSlot') imageSlot: ElementRef | undefined;
  radioText: any[] = [];
  categoryList: any[] = [];
  selectedCategoryId: number = 1;
  selectedDifficultyLevel: number = 1;
  timeLimit?: string;
  selectedTypeQuiz: string = "1";
  title: string = '';
  description: string = '';
  image?: string;
  selectedOption: string = '';
  selectedRadioValue: string = '';
  DifficultyQuestion: any
  correctAnswer: string = "";
  displayTimeLimit: boolean = false;
  displayDialog: boolean = false; /// hiển thị thông báo
  itemToDelete: any; // item chọn xóa
  isCanSubmit: boolean = false; // biến xác định được add quiz hay chưa
  fileImage?: File; // biến lưu giữ ảnh
  messQuiz: { title?: boolean, description?: boolean, Category?: boolean, timeLimit?: boolean } = {};
  showResult: boolean = false; // biến hiển thị kết quả add
  resultEdit: boolean = false; // biến kết quả add quiz
  quizId: number = 0; // biến lưu quizId
  user?: User; // biến chứa dữ liệu người dùng
  isError: boolean = false; // biến hiển thị modal lỗi trang
  showScrollToTopButton: boolean = false; // biến hiển thị scroll
  showResultApprove: boolean = false; // biến hiển thị modal kết quả gửi duyệt quiz
  resultApproveMess?: string // biến hiển thị mess kết quả gửi duyệt quiz
  isLoading: boolean = true; // biến trạng thái loading
  reasonReject: string = ''; // biến lưu reason
  messReason?: string; // biến lưu error trường reason
  ///icon
  faSquarePlus = faSquarePlus;
  faTrash = faTrash;
  faXmark = faXmark;
  faShareFromSquare = faShareFromSquare;
  faTrashCan = faTrashCan;
  faFloppyDisk = faFloppyDisk;
  faCheck = faCheck;
  numberQuestionCreate: any[] = Array(3).fill(null).map((_, index) => { // biến khởi tạo question ui
    return {
      quesId: "",
      all4question: "",
      difficultyLevel: 1,
      correctAnswer: "",
      messError: "",
      radioTextItems: Array(4).fill(null).map((_, innerIndex) => {
        return {
          radio: { id: "", name: "", value: "" },
          textInput: { id: "", }
        };
      })
    };
  });

  quizData: QuizSetData = { quizz: {}, questions: [] }; // biến lưu data quiz cũ

  constructor(private quizDataService: QuizDataService, private userDataService: UserDataService, private renderer: Renderer2, private fireBase: FirebaseImageService,
    private route: ActivatedRoute, private quizService: QuizDataService, private dashboardService: DashboardService, private router: Router) {

  }

  async ngOnInit() {
    await this.route.params.pipe(
      switchMap(params => {
        this.quizId = params['quizId'];
        return this.userDataService.userCurr;
      })
    ).subscribe(userData => {
      if (userData.userId) {
        this.user = userData;
        this.quizDataService.getCategory().subscribe(res => {
          this.categoryList = res.result;
          if (this.quizId)
            this.onStartQuiz(this.quizId);
        });
      }
    });

  }

  rejectQuiz() {
    if (this.reasonReject.length > 0) {
      this.dashboardService.updateQuizStatus(this.quizId, 4, this.reasonReject).subscribe(res => {
        if (res.status) {
          this.showResultApprove = true;
          this.resultApproveMess = 'Reject success.';
          setTimeout(() => {
            this.router.navigate(['/quiz-manage']);
          }, 3000);
        } else {
          this.showResultApprove = true;
          this.resultApproveMess = 'Reject fail something, try again.';
        }
        (error: any) => {
          this.showResultApprove = true;
          this.resultApproveMess = 'Reject fail something, try again.';
          console.error('Lỗi khi reject quiz:', error);
        }
      })
    } else {
      this.messReason = 'Reason reject is not empty.';
    }

  }


  /*
  *Hàm lấy dữ liệu của quiz
  */
  async onStartQuiz(quizId: number) {
    // Gọi service để lấy dữ liệu quiz
    if (this.quizId)
      await this.quizService.getquiz(this.quizId).subscribe(
        (response) => {
          // chặn sửa khi quiz ở trạng thái chờ duyệt hoặc đang hiển thị, hoặc quiz này do người khác tạo
          if (response.result.quizz.status == 2) {
            this.quizData.questions = response.result.questions;
            this.quizData.quizz = response.result.quizz;
            this.mapQuizData(response.result.quizz);
            this.mapQuestionsToNumberQuestionCreate();
          }
        },
        (error) => {
          this.isError = true;
          console.error('Lỗi khi lấy dữ liệu quiz:', error);
        }
      );
  }

  private mapQuizData(quiz: Quiz) {
    if (quiz.title && quiz.title?.length > 0) {
      this.title = quiz.title;
    }
    if (quiz.description && quiz.description.length > 0) {
      this.description = quiz.description;
    }
    if (quiz.image && quiz.image.length > 0) {
      this.image = quiz.image;
      this.getImageQuiz(quiz.image);
    }
    if (quiz.categoryId && quiz.categoryId != 0) {
      this.selectedCategoryId = quiz.categoryId;
    }
    if (quiz.quizType && quiz.quizType != 0) {
      if (quiz.quizType == 2) {
        this.displayTimeLimit = true;
      }
      this.selectedTypeQuiz = '' + quiz.quizType;
    }
    if (quiz.difficultyLevel && quiz.difficultyLevel != 0) {
      this.selectedDifficultyLevel = quiz.difficultyLevel;
    }
    if (quiz.timeLimit && quiz.timeLimit != 0) {
      this.timeLimit = quiz.timeLimit + '';
    }
    if (quiz.comment && quiz.comment.length > 0) {
      this.reasonReject = quiz.comment;
    }
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
  *Hàm map dữ liệu lấy được từ quiz vào hiển thị giao diện
  */
  private mapQuestionsToNumberQuestionCreate(): void {
    this.numberQuestionCreate = this.quizData.questions.map((question: QuestionData) => {
      const optionsArray = question.options.split('|');
      const radioTextItems = Array(optionsArray.length).fill(null).map((_, innerIndex) => {
        const isCorrect = innerIndex == (parseInt(question.correctAnswer) - 1);
        return {
          radio: { id: "", name: "", value: isCorrect ? "correct" : "" },
          textInput: { name: innerIndex < optionsArray.length ? optionsArray[innerIndex] : "" }
        };
      });

      this.isLoading = false;

      return {
        quesId: question.questionId,
        all4question: question.questionText || "",
        difficultyLevel: question.difficultyLevel || 1,
        correctAnswer: question.correctAnswer || "",
        messError: "",
        radioTextItems: radioTextItems
      };
    });
  }


  /*
  *Hàm xử lý chuyển hướng khi modal lỗi hiển thị
  */
  goBack() {
    this.router.navigateByUrl('/quiz-manage', { skipLocationChange: true }).then(() => {
      this.router.navigate(['/quiz-manage']);
    });
  }



  /*
  * Hàm scroll top tự động
  */
  scrollToTop() {
    window.scrollTo({ top: 0, behavior: 'smooth' }); // Sử dụng 'smooth' để có hiệu ứng cuộn mượt
  }


  updateQuizStatus() {
    this.dashboardService.updateQuizStatus(this.quizId, 1).subscribe(res => {
      console.log(res);
      if (res.status) {
        this.showResultApprove = true;
        this.resultApproveMess = 'Approve success.';
        setTimeout(() => {
          this.router.navigate(['/quiz-manage']);
        }, 3000);
      } else {
        this.showResultApprove = true;
        this.resultApproveMess = 'Approve fail something, try again.';
      }
      (error: any) => {
        this.showResultApprove = true;
        this.resultApproveMess = 'Approve fail something, try again.';
        console.error('Lỗi khi update status quiz:', error);
      }
    })
  }

}
