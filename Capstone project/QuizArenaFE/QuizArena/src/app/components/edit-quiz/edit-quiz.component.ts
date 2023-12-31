import { Component, ElementRef, HostListener, OnInit, Renderer2, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { faSquarePlus, faTrash, faXmark, faShareFromSquare, faTrashCan, faFloppyDisk, faShuffle, faRotateLeft } from '@fortawesome/free-solid-svg-icons';
import { switchMap } from 'rxjs';
import { QuestionData } from 'src/app/models/question-data.model';
import { Quiz } from 'src/app/models/quiz-data.model';
import { QuizSetData } from 'src/app/models/quiz-set-data.model';
import { User } from 'src/app/models/user.model';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { UserDataService } from 'src/app/services/user-data.service';
import { fadeIn, fadeOutIn } from 'src/assets/animations/animation-quiz';
import { v4 as uuidv4 } from 'uuid';


@Component({
  selector: 'app-edit-quiz',
  templateUrl: './edit-quiz.component.html',
  styleUrls: ['./edit-quiz.component.scss'],
  animations: [fadeIn, fadeOutIn]
})
export class EditQuizComponent implements OnInit {
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
  isCanSubmit: boolean = false; // biến xác định được add quiz hay chưa
  fileImage?: File; // biến lưu giữ ảnh
  messQuiz: { title?: boolean, description?: boolean, Category?: boolean, timeLimit?: boolean } = {};
  showResult: boolean = false; // biến hiển thị kết quả add
  resultEdit: boolean = false; // biến kết quả add quiz
  quizId?: number; // biến lưu quizId
  notPermissionEdit: boolean = false; // biến kiểm tra quyền edit quiz
  user?: User; // biến chứa dữ liệu người dùng
  isError: boolean = false; // biến hiển thị modal lỗi trang
  showScrollToTopButton: boolean = false; // biến hiển thị scroll
  showResultApprove: boolean = false; // biến hiển thị modal kết quả gửi duyệt quiz
  resultApproveMess?: string // biến hiển thị mess kết quả gửi duyệt quiz
  removeResult: boolean = false // biến hiển thị kết quả xóa
  showRemove: boolean = false; // biến mở modal xóa
  reasonReject: string = ''; // biến lưu reason reject

  showGenModal: boolean = false;//biến hiển thị modal gen ques
  categoryGenQues: number = 1; // biến lựa chọn category gen ques
  numLv1: number = 0; // biến lưu số ques lv 1 muốn gen ra
  numLv2: number = 0;// biến lưu số ques lv 2 muốn gen ra
  numLv3: number = 0;// biến lưu số ques lv 3 muốn gen ra
  undoGenQues: boolean = false; // biến hiển thị button undo gen
  private previousState: any[] = [];
  showAddQuestion: boolean = false; // biến hiển thị modal add question
  loading: boolean = true;
  questionList: QuestionData[] = [];
  selectedQuestion!: QuestionData[];

  ///icon
  faSquarePlus = faSquarePlus;
  faShareFromSquare = faShareFromSquare;
  faTrashCan = faTrashCan;
  faFloppyDisk = faFloppyDisk;
  faTrash = faTrash;
  faXmark = faXmark;
  faShuffle = faShuffle;
  faRotateLeft = faRotateLeft;

  numberQuestionCreate: any[] = Array(3).fill(null).map((_, index) => { // biến khởi tạo question ui
    return {
      quesId: "",
      all4question: "",
      difficultyLevel: 1,
      categoryId: 1,
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
    private route: ActivatedRoute, private quizService: QuizDataService, private router: Router) {

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

  ShowaddQuestion() {
    this.showAddQuestion = true;
    this.quizDataService.getQuestionsByCategory(this.selectedCategoryId, 1, undefined).subscribe(
      (response: any) => {
        if (response.status) {
          this.setupQuestionList(response.result);
        }
      },
      (error) => {
        console.error('Lỗi lấy list question:', error);
      }
    );
  }


  private setupQuestionList(ques: any[]) {

    // Lọc ra những câu hỏi không có questionId trong mảng numberQuestionCreate
    const filteredQuestions = ques.filter(question => {
      return !this.numberQuestionCreate.some(createQuestion => createQuestion.quesId === question.questionId);
    });

    this.questionList = filteredQuestions;
    this.loading = false;
  }

  /*
  * Hàm lấy question random
  */
  generateQuestions() {
    // Lưu trạng thái trước khi thêm câu hỏi random
    this.previousState = this.numberQuestionCreate.map(question => ({ ...question }));

    if (this.numLv1 != 0 || this.numLv2 != 0 || this.numLv3 != 0) {
      this.quizDataService.getRandomQuestion(this.categoryGenQues, this.numLv1, this.numLv2, this.numLv3).subscribe(
        (response: any) => {
          if (response.status) {
            this.setQuestionRandom(response.result);
            console.log(response.result)
          }
        },
        (error) => {
          console.error('Lỗi gen question:', error);
        }
      );
    } else {
      console.log('empty')
    }
  }



  addQuestionBank() {
    this.setQuestionBank(this.selectedQuestion);
    this.selectedQuestion = [];
    this.showAddQuestion = false;
  }

  /*
  * Hàm set giá trị question random vào mảng question
  */
  private async setQuestionBank(ques: QuestionData[]) {
    // Kiểm tra nếu ques không có hoặc số lượng ques ít hơn số lượng cần thiết
    if (!ques || ques.length < 1) {
      console.error("Invalid input for setQuestionRandom");
      return;
    }

    for (let i = 0; i < ques.length; i++) {
      const randomQuestion = ques[i];

      const optionsArray = randomQuestion.options.split('|');
      const radioTextItems = Array(optionsArray.length).fill(null).map((_, innerIndex) => {
        const isCorrect = innerIndex == (parseInt(randomQuestion.correctAnswer) - 1);
        return {
          radio: { id: "", name: "", value: isCorrect ? "correct" : "" },
          textInput: { id: "", name: innerIndex < optionsArray.length ? optionsArray[innerIndex] : "" }
        };
      });

      this.numberQuestionCreate.push({
        quesId: randomQuestion.questionId,
        all4question: randomQuestion.questionText || "",
        categoryId: this.selectedCategoryId || 1,
        difficultyLevel: randomQuestion.difficultyLevel || 1,
        correctAnswer: randomQuestion.correctAnswer || "",
        messError: "",
        radioTextItems: radioTextItems
      });

    }
  }


  /*
  * Hàm set giá trị question random vào mảng question
  */
  private async setQuestionRandom(ques: any[]) {
    // Kiểm tra nếu ques không có hoặc số lượng ques ít hơn số lượng cần thiết
    if (!ques || ques.length < 1) {
      console.error("Invalid input for setQuestionRandom");
      return;
    }

    for (let i = 0; i < ques.length; i++) {
      const randomQuestion = ques[i];

      const optionsArray = randomQuestion.Options.split('|');
      const radioTextItems = Array(optionsArray.length).fill(null).map((_, innerIndex) => {
        const isCorrect = innerIndex == (parseInt(randomQuestion.CorrectAnswer) - 1);
        return {
          radio: { id: "", name: "", value: isCorrect ? "correct" : "" },
          textInput: { id: "", name: innerIndex < optionsArray.length ? optionsArray[innerIndex] : "" }
        };
      });

      this.numberQuestionCreate.push({
        quesId: randomQuestion.QuestionId,
        all4question: randomQuestion.QuestionText || "",
        categoryId: randomQuestion.CategoryId || 1,
        difficultyLevel: randomQuestion.DifficultyLevel || 1,
        correctAnswer: randomQuestion.CorrectAnswer || "",
        messError: "",
        radioTextItems: radioTextItems
      });

    }
    this.undoGenQues = true;
  }



  /*
  * Hàm show modal gen question
  */
  showGenerateQues() {
    this.showGenModal = true;
  }

  /*
  * Hàm quay lại trước khi gen question
  */
  undoGen() {
    if (this.previousState.length > 0) {
      this.numberQuestionCreate = this.previousState.map(question => ({ ...question }));
      this.previousState = [];
      this.undoGenQues = false;
    }
  }



  /*
  * Hàm gửi yêu cầu duyệt quiz
  */
  SendRequestApprove() {
    if ((this.quizData.quizz.status == 0 || this.quizData.quizz.status == 4) && this.quizData.quizz.creatorId == this.user?.userId && this.quizData.quizz.quizId) {
      this.editQuiz(2);
    }
  }

  /*
  * Hàm xóa quiz
  */
  async removeQuiz(): Promise<void> {
    //đang sửa api chưa xong
    if ((this.quizData.quizz.status == 0 || this.quizData.quizz.status == 4) && this.quizData.quizz.creatorId == this.user?.userId && this.quizData.quizz.quizId) {
      await this.quizService.deleteQuiz(this.quizData.quizz.quizId, 1).subscribe(
        (response) => {
          // chặn sửa khi quiz ở trạng thái chờ duyệt hoặc đang hiển thị, hoặc quiz này do người khác tạo
          if (response.status) {
            this.removeResult = true;
            this.showRemove = true;
            setTimeout(() => {
              this.router.navigate(['/staff-view']);
            }, 3000);
          } else {
            this.removeResult = false;
            this.showRemove = true;
          }
        },
        (error) => {
          this.removeResult = false;
          this.showRemove = true;
          console.error('Lỗi khi xóa quiz:', error);
        }
      );
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
          if (response.result.quizz.quizType == 3) {
            this.router.navigate(['/edit-quiz/' + this.quizId]);
          } else {
            if (response.result.quizz.creatorId != this.user?.userId) {
              this.notPermissionEdit = true;
            } else {
              this.quizData.questions = response.result.questions;
              this.quizData.quizz = response.result.quizz;
              this.mapQuizData(response.result.quizz);
              this.mapQuestionsToNumberQuestionCreate();
            }
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

      return {
        quesId: question.questionId,
        all4question: question.questionText || "",
        categoryId: this.selectedCategoryId || 1,
        difficultyLevel: question.difficultyLevel || 1,
        correctAnswer: question.correctAnswer || "",
        messError: "",
        radioTextItems: radioTextItems
      };
    });
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
    } else if (question.categoryId != this.selectedCategoryId) {
      // Nếu correctAnswer trống
      question.messError = "The category of this question is different from the category quiz.";
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
    if (this.validateInputQuiz() && checkResult) {
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


  /*
  * Hàm xử lý update quiz
  */
  editQuiz(status: number) {
    const quizDataNew: QuizSetData = { quizz: {}, questions: [] };
    if (this.checkQuestion() && !this.notPermissionEdit) { // check validate các trường this.validateInputQuiz() &&
      quizDataNew.quizz.title = this.title;
      quizDataNew.quizz.quizId = this.quizData.quizz.quizId;
      quizDataNew.quizz.description = this.description;
      quizDataNew.quizz.status = status;
      quizDataNew.quizz.quizType = Number(this.selectedTypeQuiz);
      quizDataNew.quizz.difficultyLevel = Number(this.selectedDifficultyLevel);
      quizDataNew.quizz.timeLimit = Number(this.timeLimit);
      if (this.selectedTypeQuiz.includes('2')) {
        quizDataNew.quizz.timeLimit = Number(this.timeLimit);
        quizDataNew.quizz.categoryId = 0;
      } else {
        quizDataNew.quizz.timeLimit = 0;
        quizDataNew.quizz.categoryId = this.selectedCategoryId;
      }
      if (this.fileImage) {
        const imgName = this.setImageNameUpdate();
        if (imgName && imgName.trim().length > 0)
          quizDataNew.quizz.image = `image/quiz-practice/` + imgName;
      }

      for (let i = 0; i < this.numberQuestionCreate.length; i++) {
        const question = this.numberQuestionCreate[i];

        // Lấy tất cả các textInput names và join chúng thành một chuỗi bằng dấu '|'
        const options = question.radioTextItems
          .map((item: { textInput: { name: any; }; }) => item.textInput.name)
          .join('|');

        // Gán dữ liệu cho mảng questions trong quizData
        quizDataNew.questions[i] = {
          questionId: question.quesId,
          questionText: question.all4question,
          difficultyLevel: Number(question.difficultyLevel),
          correctAnswer: question.correctAnswer.toString(),
          options: options
        };
      }
      console.log(quizDataNew);
      this.quizDataService.updateQuiz(quizDataNew).subscribe(
        (response: any) => {
          if (response.status) {
            if (this.fileImage && quizDataNew.quizz.image) {
              this.fireBase.uploadImageQuiz(this.fileImage, quizDataNew.quizz.image);
              if (this.image && this.image?.length > 0) {
                this.fireBase.deleteImage(this.image);
              }
            }
            if (status != 4) {
              this.showResult = true;
              this.resultEdit = true;
              setTimeout(() => {
                this.router.navigate(['/staff-view']);
              }, 3000);
            } else {
              this.showResultApprove = true;
              this.resultApproveMess = 'Send approve success.'
              setTimeout(() => {
                this.router.navigate(['/staff-view']);
              }, 3000);
            }

          } else {
            if (status != 4) {
              this.showResult = true;
              this.resultEdit = false;
            } else {
              this.showResultApprove = true;
              this.resultApproveMess = 'Send approve fail something, try again.'
            }
            console.error('Lỗi edit quiz:', response.message);
          }
        },
        (error) => {
          this.showResult = true;
          this.resultEdit = false;
          console.error('Lỗi edit quiz:', error);
        }
      );
    }
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
  * Hàm kiểm tra dữ liệu và các trường
  */
  validateInputQuiz(): boolean {
    let checkResult = true;
    if (!this.title || this.title.length < 1) {
      this.messQuiz.title = true;
      checkResult = false;
    } else {
      this.messQuiz.title = false;
    }
    if (!this.description || this.description.length < 100) {
      this.messQuiz.description = true;
      checkResult = false;
    } else {
      this.messQuiz.description = false;
    }
    if (this.selectedTypeQuiz.includes('2') && !this.timeLimit) {
      this.messQuiz.timeLimit = true;
      checkResult = false;
    } else {
      if (this.timeLimit && /^\d+$/.test(this.timeLimit))
        this.messQuiz.timeLimit = false;
    }
    return checkResult;
  }


  /*
  * Hàm show time limit khi thay đổi type quiz
  */
  onQuizTypeChange() {
    if (this.selectedTypeQuiz === "1") {
      this.displayTimeLimit = false;
    } else {
      this.displayTimeLimit = true;
    }
  }

  /*
  * Hàm mở cửa sổ chọn file
  */
  openFileInput() {
    if (this.fileInput && this.quizData.quizz.status == 0)
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

}
