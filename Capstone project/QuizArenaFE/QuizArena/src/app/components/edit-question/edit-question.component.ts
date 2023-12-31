import { Component, ElementRef, HostListener, Renderer2, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { faSquarePlus, faTrash, faXmark, faShareFromSquare, faTrashCan, faFloppyDisk } from '@fortawesome/free-solid-svg-icons';
import { switchMap } from 'rxjs';
import { QuestionData } from 'src/app/models/question-data.model';
import { Quiz } from 'src/app/models/quiz-data.model';
import { QuizSetData } from 'src/app/models/quiz-set-data.model';
import { User } from 'src/app/models/user.model';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { UserDataService } from 'src/app/services/user-data.service';

@Component({
  selector: 'app-edit-question',
  templateUrl: './edit-question.component.html',
  styleUrls: ['./edit-question.component.scss']
})
export class EditQuestionComponent {
  radioText: any[] = [];
  questionList: any[] = [];
  selectedOption: string = '';
  selectedRadioValue: string = '';
  showResult: boolean = false; // biến hiển thị kết quả add
  resultEdit: boolean = false; // biến kết quả add quiz
  quizId?: number; // biến lưu quizId
  notPermissionEdit: boolean = false; // biến kiểm tra quyền edit quiz
  user?: User; // biến chứa dữ liệu người dùng
  isError: boolean = false; // biến hiển thị modal lỗi trang
  showScrollToTopButton: boolean = false; // biến hiển thị scroll
  removeResult: boolean = false // biến hiển thị kết quả xóa
  questionCreate: QuestionData[] = []
  userId: any
  resultEditQuestion: boolean = false;
  categoryId: any
  questionId!: number
  showResultApprove: any
  resultApproveMess: any
  showRemove: any
  categorySelect: any
  ///icon
  faSquarePlus = faSquarePlus;
  faShareFromSquare = faShareFromSquare;
  faTrashCan = faTrashCan;
  faFloppyDisk = faFloppyDisk;
  faTrash = faTrash;
  faXmark = faXmark;
  displayDialog: boolean = false;

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
    private route: ActivatedRoute, private quizService: QuizDataService) {

  }

  async ngOnInit() {
    await this.route.params.pipe(
      switchMap(params => {
        this.categoryId = params['categoryId'];
        return this.userDataService.userCurr;
      })
    ).subscribe(userData => {
      if (userData.userId) {
        this.user = userData;
        this.userId = userData.userId
        this.getQuestionsByCategory()
      }
    });

    this.quizDataService.getCategory().subscribe(res => {
      this.categorySelect = res.result.find((item: any) => item.categoryId === Number(this.categoryId));
    })
  }

  /*
  * Hàm gửi yêu cầu duyệt quiz
  */
  SendRequestApprove(question: any) {
    // Lấy tất cả các textInput names và join chúng thành một chuỗi bằng dấu '|'
    const options = question.radioTextItems
      .map((item: { textInput: { name: any; }; }) => item.textInput.name)
      .join('|');

    // Gán dữ liệu cho mảng questions trong quizData
    this.questionCreate[0] = {
      questionId: question.quesId,
      questionText: question.all4question,
      difficultyLevel: Number(question.difficultyLevel),
      correctAnswer: question.correctAnswer.toString(),
      options: options,
      status: 2,
      userId: this.userId
    };
    this.quizDataService.editQuestion(this.categoryId, this.questionCreate).subscribe(
      (response: any) => {
        if (response.status) {
          this.getQuestionsByCategory();
          this.showResult = true;
          this.resultEdit = true
        } else {
          this.showResult = true;
          this.resultEdit = true
          this.getQuestionsByCategory();
          console.error('Lỗi edit question:', response.message);
        }
      },
      (error) => {
        this.showResult = true;
        console.error('Lỗi edit question:', error);
      }
    );
  }

  getQuestionsByCategory() {
    this.quizDataService.getQuestionsByCategory(this.categoryId, 4, this.user?.userId).subscribe(res => {
      this.questionList = res.result
      console.log(this.questionList)
      this.resultEditQuestion = res.result
      this.numberQuestionCreate = this.questionList.map((question: QuestionData) => {
        const optionsArray = question.options.split('|');
        const radioTextItems = Array(optionsArray.length).fill(null).map((_, innerIndex) => {
          const isCorrect = innerIndex == (parseInt(question.correctAnswer) - 1);
          return {
            radio: { id: "", name: "", value: isCorrect ? "correct" : "" },
            textInput: { name: innerIndex < optionsArray.length ? optionsArray[innerIndex] : "" }
          };
        });

        return {
          quesId: question.questionId,
          all4question: question.questionText || "",
          difficultyLevel: question.difficultyLevel || 1,
          correctAnswer: question.correctAnswer || "",
          messError: "",
          radioTextItems: radioTextItems
        };
      });
    })
  }

  /*
  * Hàm xóa quiz
  */
  removeQuestion() {
    this.quizDataService.deleteQuestion(this.questionId).subscribe(res => {
      this.displayDialog = false;
      this.getQuestionsByCategory();
    })
  }
  /*
  *Hàm xử lý sự kiện xóa các đáp án
  */
  deleteRadioWithText(outerIndex: number, innerIndex: number) {
    this.numberQuestionCreate[outerIndex].radioTextItems.splice(innerIndex, 1);
    if (innerIndex == (this.numberQuestionCreate[outerIndex].correctAnswer - 1))
      this.numberQuestionCreate[outerIndex].correctAnswer = '';
  }


  /*
  *Hàm thêm một đáp án mới
  */
  addRadioTextEmpty(outerIndex: number) {
    const newItem = {
      radio: {
        id: "",
        name: "",
        value: ""
      },
      textInput: {
        id: "",
      }
    };

    this.numberQuestionCreate[outerIndex].radioTextItems.push(newItem);
  }

  /*
  *Hàm thêm câu hỏi mới
  */
  addQuestionEmpty() {
    const newQuestion = {
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
    this.numberQuestionCreate.push(newQuestion);
  }

  /*
  *Hàm xóa câu hỏi
  */
  deleteQuestion(index: number) {
    this.numberQuestionCreate.splice(index, 1);
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
 * Hàm check các question
 */
  checkQuestion(): boolean {
    let checkResult = true;
    // Sử dụng hàm kiểm tra trong một vòng lặp hoặc bất kỳ nơi nào cần thiết
    for (let i = 0; i < this.numberQuestionCreate.length; i++) {
      const question = this.numberQuestionCreate[i];
      if (!this.updateMessError(question)) {
        checkResult = false;
      }
    }
    if (checkResult) {
      return true;
    } else {
      return false;
    }
  }



  /*
  *Hàm thay đổi đáp án đúng
  */
  onRadioValueChange(m: number, n: number, value: any) {
    // Set correctAnswer for the selected question
    this.numberQuestionCreate[m].correctAnswer = n + 1;
  }



  showDeleteConfirmation(questionId: number): void {
    this.questionId = questionId
    this.displayDialog = true;
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
}
